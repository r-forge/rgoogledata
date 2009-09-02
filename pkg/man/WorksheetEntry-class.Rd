\name{WorksheetEntry-class}
\Rdversion{1.1}
\docType{class}
\alias{WorksheetEntry-class}
\alias{WorksheetEntry}
\alias{coerce,WorksheetEntry,list-method}
\alias{coerce,WorksheetEntry,data.frame-method}
\alias{initialize,WorksheetEntry-method}

\title{Class "WorksheetEntry"}

\description{ Base entry of Google Data.  It roughly corresponds to the
  Java class com.google.gdata.data.spreadsheet.WorksheetEntry.  This class 
  inherits from 'BaseEntry' class.
  
  Objects of class 'WorksheetEntry' appear when working with worksheet data
  as part of a "list" feed.  Each 'WorksheetEntry' corresponds to a row in
  the table.  There is one "list" feed per worksheet. The "list" feed
  terminates at the first full empty data row.  If suspect you did not
  get the entire data, please check if your worksheet contains empty
  rows.  In particular, for a worksheet with an empty first row the feed
  will be empty.

  For list feeds, the first row in the worksheet is supposed to contain
  the column names.  Preferably the data in the worksheet should be a
  rectangular table. 
  
  For more flexible ways to deal with data in worksheets, see the
  'TableEntry' class.  (TO BE IMPLEMENTED)
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("WorksheetEntry", listFields, ...)}.
}
\section{Slots}{
  Besides the slots inherited from 'BaseEntry', 
  \describe{
    \item{\code{nrow}:}{Object of class \code{"integer"}.  Number of rows.}
    \item{\code{ncol}:}{Object of class \code{"integer"}.  Number of columns.}
  }
}
\section{Methods}{
  \describe{
    \item{coerce}{\code{signature(from = "WorksheetEntry", to = "list")}.}
    \item{coerce}{\code{signature(from = "WorksheetEntry", to =
       "data.frame")}.}
    \item{initialize}{\code{signature(.Object = "WorksheetEntry", listFields
       = "list")}.  If listFields is a list with names matching slotNames
       the WorksheetEntry gets populated with the values.  Should not be used
       directly by the user.}
  }
    
}
\references{The Google Data Java API \url{http://code.google.com/apis/gdata/javadoc/}.}
\author{Adrian Dragulescu}
\seealso{Parent class \code{\linkS4class{BaseEntry}} and how to extract
  them from a spreadsheet \code{\link{getWorksheets}}.
}
\keyword{classes}
