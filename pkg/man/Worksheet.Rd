\name{Worksheet}
\alias{Worksheets}
\alias{getWorksheets}
\alias{addWorksheet}
\alias{deleteWorksheet}
\title{ Functions to manipulate Google worksheets. }
\description{
Functions to manipulate Google worksheets. 
}
\usage{

getWorksheets(xls)

addWorksheet(xls, title, nrow=100, ncol=20)

deleteWorksheet(wks)

}
\arguments{
  \item{xls}{ An 'SpreadsheetEntry' object.}
  \item{title}{ A character string for the name of the sheet.}
  \item{nrow}{ An integer specifiying the number of rows for the new
    worksheet.}
  \item{ncol}{ An integer specifiying the number of columns for the new
    worksheet.}
  \item{wks}{ A 'WorksheetEntry' object.}  
}

\details{
  'getWorksheets' returns all the worksheets in the spreadsheet as a
  list of 'WorksheetEntry' objects.
}
\value{
  'getWorksheets' returns all the worksheets in the spreadsheet as a
  list of 'WorksheetEntry' objects.
  
  'addWorksheet' and 'deleteWorksheet' return a logical, true for
  success and NA for failure.  In case of failure, you can inspect the
  reason by using \code{\link{getMsg}} function.
}
\author{Adrian Dragulescu}
\seealso{\code{\linkS4class{WorksheetEntry}} for the 'WorksheetEntry'
  class, and \code{\link{getListEntries}} for manipulating worksheet
  data.}


