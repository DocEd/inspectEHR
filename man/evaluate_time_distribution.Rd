% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/evaluate_distribution.R
\name{evaluate_time_distribution}
\alias{evaluate_time_distribution}
\title{Evaluate time distribution}
\usage{
evaluate_time_distribution(x = NULL, col_name = "datetime", threshold = 0.5)
}
\arguments{
\item{x}{extracted dataitem returned by [extract()]}

\item{col_name}{column name for the column of interest (defaults to \code{datetime})}

\item{threshold}{the limit value of the KS distance to consider a "different"
distribution. Default = 0.5}
}
\value{
a tibble with (potential) error codes ready for import into the
  `events_quality` table.
}
\description{
Evaluate time distribution
}
\details{
Evaluate the distribution between time data using the KS distance
}
\seealso{
\code{\link[=ks_test]{ks_test()}}
}
