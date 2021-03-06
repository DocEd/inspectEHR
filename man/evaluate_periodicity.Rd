% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/evaluate_periodicity.R
\name{evaluate_periodicity}
\alias{evaluate_periodicity}
\title{Evaluate event periodicity}
\usage{
evaluate_periodicity(x = NULL, periodicity = NULL)
}
\arguments{
\item{x}{extracted dataitem returned by [extract()]}

\item{periodicity}{the limits of anticipated periodicity given as a character
vector of length 1 in the form "(1, 6)" where the numbers are comma
separated and represent the lower and upper bounds respectively. The
numbers reflect the limits of the anticipated periodicity in the number of
events expected in an average 24 hour period on ICU. Round and square
brackets are used for non-inclusive and inclusive limits respectively.}
}
\value{
a tibble with (potential) error codes ready for import into the
  `events_quality` table.
}
\description{
Evaluate event periodicity
}
\details{
Evaluates the periodicity of a data item. This is the frequency of
events submitted. Only defined for 2d data.

A potential flaw of the current approach is that patients who undergo large
breaks from treatments during a prolonged ICU stay may erroneously flag via
this method (e.g. propofol). As such, quite conservative limits are typically
applied so as to reduce false positive findings. This flag should be taken as
a light warning.
}
\seealso{
\code{\link[=evaluate_coverage]{evaluate_coverage()}}, \code{\link[=parse_periodicity]{parse_periodicity()}}
}
\concept{evaluations}
