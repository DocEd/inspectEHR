% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/evaluate_distribution.R
\name{ks_test}
\alias{ks_test}
\title{Pairwise Kolmogorov-Smirnov Distance}
\usage{
ks_test(x, col_name = "value")
}
\arguments{
\item{x}{extracted dataitem returned by [extract()]}

\item{col_name}{column name for the column of interest (defaults to \code{value})}
}
\description{
Pairwise Kolmogorov-Smirnov Distance
}
\details{
Performs a pairwise comparison of any 2 continuous distributions and
returns their KS distance. If the chosen column is of class \code{POSIXct} then
the comparison occurs over the time component only, since the date component
is unlikely to yield a useful comparison.
}
\concept{site level evaluation}
