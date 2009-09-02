\name{ListEntry-class}
\Rdversion{1.1}
\docType{class}
\alias{ListEntry-class}
\alias{ListEntry}
\alias{coerce,ListEntry,list-method}
\alias{coerce,ListEntry,data.frame-method}
\alias{initialize,ListEntry-method}

\title{Class "ListEntry"}

\description{ Base entry of Google Data.  It roughly corresponds to the
  Java class com.google.gdata.data.spreadsheet.ListEntry.  This class 
  inherits from 'BaseEntry' class.
  
  Objects of class 'ListEntry' appear when working with worksheet data
  as part of a "list" feed.  Each 'ListEntry' corresponds to a row in
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
Objects can be created by calls of the form \code{new("ListEntry", listFields, ...)}.
}
\section{Slots}{
  Besides the slots it inherits from 'BaseEntry', 
  \describe{
    \item{\code{rowId}:}{Object of class \code{"character"}.  Unique row
    identifier.  Last token of the 'id' slot, separated for convenience.}
  }
}
\section{Methods}{
  \describe{
    \item{coerce}{\code{signature(from = "ListEntry", to = "list")}.}
    \item{coerce}{\code{signature(from = "ListEntry", to =
       "data.frame")}.}
    \item{initialize}{\code{signature(.Object = "ListEntry", listFields
       = "list")}.  If listFields is a list with names matching slotNames
       the ListEntry gets populated with the values.  Should be used
       directly by the user.}
    \item{getContent}{\code{signature(obj, ...)}.  Get the content of
       a 'ListEntry' object.  Returns a character matrix with one
       row. The matrix colnames are the ListEntry 'tags', the matrix
       rowname is the ListEntry rowId.}
  }
    
}
\references{The Google Data Java API \url{http://code.google.com/apis/gdata/javadoc/}.}
\author{Adrian Dragulescu}
\seealso{Parent class \code{\linkS4class{BaseEntry}}, and for functions
  to manipulate ListEntries see \code{\link{getListEntries}}.
}
\keyword{classes}
