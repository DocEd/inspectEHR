#' @title Evaluate episodes
#'
#' @details Determines which months are invalid based on a low contribution of data.
#' This is based upon the long term daily average for admissions. Days that
#' fall below 2 SD of the long term mean are flagged. If more than the
#' `threshold` number of flagged days occur in a single month, then the
#' month is invalidated and removed from further analysis.
#'
#' This procedure removes episodes that occur during particularly sparse periods
#' (as this is likely that these months are contributing poor data) and return
#' only episodes that have a logical consistency in non-sparse months. The
#' analyst should consider if the denominator for the number of study months
#' should be changed following the use of this function.
#'
#' @param episode_length a table returned by [characterise_episodes()]
#' @param threshold numeric scalar threshold number of days to use in calculation
#'
#' @return a table of the same form as [episode_length()] but with failing
#'   episodes removed and placed into the `invalid_records` attribute
#' @export
#'
#' @importFrom dplyr mutate group_by summarise left_join right_join n_distinct
#' distinct tibble bind_rows pull
#' @importFrom lubridate date year month wday
#' @md
evaluate_episodes <- function(episode_length = NULL,
                            threshold = 10) {

  invalid_records <- attr(episode_length, "invalid_records")

  # The typical admissions for a given day of the week within a year window
  # This helps to account for seasonality and trend changes over time
  typical_admissions <- episode_length %>%
    mutate(date = lubridate::date(epi_start_dttm)) %>%
    group_by(site, date) %>%
    summarise(episode_count = n_distinct(episode_id)) %>%
    mutate(
      year = lubridate::year(date),
      month = lubridate::month(date, label = TRUE),
      wday = lubridate::wday(date, label = TRUE)
    ) %>%
    group_by(site, year, wday) %>%
    summarise(
      mean_episodes = mean(episode_count),
      sd_episode = sd(episode_count)
    )

  # too_few tells me the days when admissions fell under the expected
  too_few <- episode_length %>%
    mutate(date = lubridate::date(epi_start_dttm)) %>%
    group_by(site, date) %>%
    summarise(episodes = n()) %>%
    mutate(
      year = lubridate::year(date),
      wday = lubridate::wday(date, label = TRUE)
    ) %>%
    left_join(typical_admissions, by = c(
      "site" = "site",
      "year" = "year",
      "wday" = "wday"
    )) %>%
    mutate(
      too_few = if_else(
        episodes < (mean_episodes - 2 * sd_episode), TRUE, FALSE
      )
    ) %>%
    filter(too_few == TRUE) %>%
    select(site, date)

  # what we don't capture is days when there is no data - i.e. NAs
  # this is what we will fix here
  na_days <- episode_length %>%
    mutate(date = lubridate::date(epi_start_dttm)) %>%
    select(site, date) %>%
    distinct(.keep_all = TRUE) %>%
    mutate(admission = TRUE)

  ds <- tibble(
    date = rep(
      seq.Date(
        from = min(lubridate::date(episode_length$epi_start_dttm)),
        to = max(lubridate::date(episode_length$epi_start_dttm)),
        by = "day"
      ),
      times = length(unique(episode_length$site))
    )
  )

  ds <- ds %>%
    mutate(
      site = rep(
        unique(episode_length$site),
        each = nrow(ds) / length(unique(episode_length$site))
        )
      )

  too_few_all <- na_days %>%
    right_join(ds,
      by = c(
        "date" = "date",
        "site" = "site"
      )
    ) %>%
    filter(is.na(admission)) %>%
    select(-admission) %>%
    bind_rows(too_few)

  ## Too few all now contains all the months where we will be excluding
  ##episodes
  invalid_months <- too_few_all %>%
    mutate(
      year = as.integer(lubridate::year(date)),
      month = lubridate::month(date)
    ) %>%
    group_by(site, year, month) %>%
    summarise(count = n()) %>%
    filter(count >= threshold)

  episode_length <- episode_length %>%
    mutate(
      year = lubridate::year(epi_start_dttm),
      month = lubridate::month(epi_start_dttm)
    ) %>%
    left_join(invalid_months, by = c(
      "site" = "site",
      "year" = "year",
      "month" = "month"
    )) %>%
    select(episode_id, count) %>%
    mutate(veracity = if_else(is.na(count), 0L, 1L)) %>%
    select(episode_id, veracity) %>%
    right_join(episode_length, by = "episode_id")

  invalid_records <- episode_length %>%
    filter(.data$veracity == 1) %>%
    select(.data$episode_id) %>%
    mutate(
      code = "VE_CP_03",
      reason = "episode originates in bad sector"
    ) %>%
    bind_rows(invalid_records)

  attr(episode_length, "invalid_records") <- invalid_records

  episode_length <- episode_length %>%
    filter(.data$veracity == 0) %>%
    select(-.data$veracity)

  return(episode_length)
}
