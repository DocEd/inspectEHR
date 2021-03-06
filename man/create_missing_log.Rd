% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/evaluate_events.R
\name{create_missing_log}
\alias{create_missing_log}
\title{Create a missing event log}
\usage{
create_missing_log(failures, eval_code, description)
}
\arguments{
\item{failures}{a table (possible with nrow == 0 if there are no errors) with
the following columns: `site` and `code_name`. Each corresponding to a site
that does not contribute any data for the specified code.}

\item{eval_code}{character vector length 1 with the data quality evaluation
code}

\item{description}{character vector length 1 with a standardised text
description of the code in use}
}
\value{

}
\description{
Create a missing event log
}
\details{
Creates a missing event log ready to be imported into the
  `events_missing` table. This ensures there is a standardised format in use
  and returns an empty table should there not be any failures.
}
