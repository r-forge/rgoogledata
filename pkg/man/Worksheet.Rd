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
  \item{xls}{ An \code{SpreadsheetEntry} object.}
  \item{title}{ A character string for the name of the sheet.}
  \item{nrow}{ An integer specifiying the number of rows for the new
    worksheet.}
  \item{ncol}{ An integer specifiying the number of columns for the new
    worksheet.}
  \item{wks}{ A \code{WorksheetEntry} object.}  
}

\details{
  \code{getWorksheets} returns all the worksheets in the spreadsheet as a
  list of \code{WorksheetEntry} objects.
}
\value{
  \code{getWorksheets} returns all the worksheets in the spreadsheet as a
  list of \code{WorksheetEntry} objects.
  
  \code{addWorksheet} and \code{deleteWorksheet} return a logical, true for
  success and NA for failure.
}
\author{Adrian Dragulescu}
\seealso{\code{\linkS4class{WorksheetEntry}} for the 'WorksheetEntry'
  class, and \code{\link{getListEntries}} for manipulating worksheet
  data.}
\examples{

  username <- "rdocsdemo@gmail.com"
  password <- "RGooglePass12"
  con <- googleConnect(username, password)
  
  allXls <- getSpreadsheets(con)

  xls <- allXls[[which(sapply(allXls, slot, "title") == "testxls")]]

  allWks <- getWorksheets(xls)            # get the worksheets
  titles <- sapply(allWks, slot, "title") # get the titles

  wks <- allWks[[which(sapply(allWks, slot, "title") == "Second")]] 
  listEntries <- getListEntries(wks)   # get the rows 

}

