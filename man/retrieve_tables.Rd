% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{retrieve_tables}
\alias{retrieve_tables}
\title{Retrieve database tables}
\usage{
retrieve_tables(connection = NULL, schema = "public")
}
\arguments{
\item{connection}{a database connection object returned from
\code{\link[DBI:dbConnect]{DBI::dbConnect()}}}

\item{schema}{character string length 1 detailing the name of the target
schema}
}
\value{
a list containing pointers to tables within the sql connection.
}
\description{
Retrieve database tables
}
\details{
Places all tables from the database connection into a local list.
This makes accessing the tables straightforward.
}
\seealso{
Other connection: 
\code{\link{write_notify}()}
}
\concept{connection}
