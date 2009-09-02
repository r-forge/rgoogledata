\name{getContent-methods}
\docType{methods}
\alias{getContent-methods}
\alias{getContent,list-method}
\alias{getContent,ListEntry-method}
\title{ Methods for Function getContent.  }
\description{
Methods for function \code{getContent} in Package `RGoogleData'
}
\section{Methods}{
\describe{

\item{obj = "list"}{ Apply \code{getContent} to a list of objects.  This
  method is defined for convenience.  The corresponding
  \code{getContent} method will be dispatched for each element of the
  list. Other arguments in the signature are \code{as.data.frame=TRUE,
  col.names=NA, colClasses=NA}.  If the \code{as.data.frame=TRUE}, the
  output will be coerced to a data.frame.  Using \code{col.names} you
  can specify which columns you want to extract, by providing a vector
  of column names.  The \code{colClasses} argument is the same as the
  one from \code{\link[utils]{read.table}}.}

\item{obj = "ListEntry"}{ Get the content of a \code{ListEntry} object.
  Returns a character matrix with one row. The matrix colnames are the
  ListEntry 'tags', the matrix rowname is the ListEntry rowId.}
}}
\keyword{methods}

