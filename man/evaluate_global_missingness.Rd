% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/evaluate_missingness.R
\name{evaluate_global_missingness}
\alias{evaluate_global_missingness}
\title{Evaluate (global) event missingness}
\usage{
evaluate_global_missingness(core_tbl = NULL, reference_tbl = NULL)
}
\arguments{
\item{core_tbl}{a core table returned from \code{\link[=make_core]{make_core()}}}

\item{reference_tbl}{a reference table returned from \code{\link[=make_reference]{make_reference()}}}
}
\value{
a tibble with (potential) error codes ready for import into the
\code{events_missing} table.
}
\description{
Evaluate (global) event missingness
}
