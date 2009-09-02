\name{readWorksheet}
\alias{readWorksheet}
\alias{writeWorksheet}
\title{ Read the contents of a worksheet into R }
\description{
Read the contents of a worksheet into R.
}
\usage{
readWorksheet(RInt, spreadsheetId, worksheetname="Sheet 1", colClasses=NA)
}
\arguments{
  \item{RInt}{ An RInterface object as returned by \code{login}.}
  \item{spreadsheetId}{ A character string as returned by
    \code{getDocsName} with the unique document identifier.}
  \item{worksheetname}{ A character string.  As you can have several
    sheets with the same name, the function will return the first sheet
    that macthes the worksheetname.}
  
  \item{colClasses}{A vector of classes to be assumed for the columns.
    Recycled as necessary, or if the character vector is named,
    unspecified values are taken to be 'NA'.

    Possible values are 'NA' (when 'type.convert' is used), one of the
    atomic vector classes (logical, integer, numeric, complex,
    character, raw), or '"factor"', '"Date"' or '"POSIXct"'.  Otherwise
    there needs to be an 'as' method (from package 'methods') for
    conversion from '"character"' to the specified formal class.  See
    also the same parameter from function \code{\link[utils]{read.table}}.}
}

\details{
  
  The first row in the worksheet is supposed to contain the column
  names.  Preferably the data in the worksheet should be a rectangular
  table missing data in the first row, although the code tries to deal
  with this situation.

  There are several ways to pull data from a worksheet, in what Google
  calls the "list", "cell", "record" and "table" feeds.  This function
  implements the "list" feed.  The "list" feed terminates at the first
  full empty data row.  If suspect you did not get the entire data,
  please check if your worksheet contains empty rows.  In particular,
  for a worksheet with an empty first row the feed will be empty.
 
  As all the data is pulled from Google as a string, the colClasses can
  be used to coerce the data from character to other classes.
   
}
\value{
  A data.frame containing the data as downloaded from the worksheet.  The
  rownames of the dataframe are the unique list id's used internally by
  Google.  You need these unique id's if you want to overwrite the rows
  of the spreadsheet. 
}
\author{ Adrian Dragulescu }
\seealso{\code{\link{writeWorksheet}}}
\examples{
\dontrun{

# you should already have an RInt object!

# readWorksheet(RInt, "document%3Adft5h9w9_1dtc28pg3",
#  "folder%3A7f42e3bd-a65f-486c-937d-a39a2c075458")




}
}

