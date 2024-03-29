% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/enum.R
\name{enum_bullet}
\alias{enum_bullet}
\title{Enumerate elements in a bullet list.}
\usage{
enum_bullet(xs, bullet = "-")
}
\arguments{
\item{xs}{a vector of elements to be enumerated}

\item{bullet}{a character string to be used as bullet points}
}
\value{
a character string enumerating the elements in a bullet list
}
\description{
Enumerate elements in a bullet list.
}
\examples{
enum_bullet(1:3) #=> "- 1\\n- 2\\n- 3"
enum_bullet(1:3, bullet = "*") #=> "* 1\\n* 2\\n* 3"
}
