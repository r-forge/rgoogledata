\name{ListEntry}
\alias{getListEntries}
\alias{addListEntry}
\alias{updateListEntry}
\alias{deleteListEntry}
\title{ Functions to manipulate Google ListEntries. }
\description{
Functions to manipulate Google ListEntries. 
}
\usage{

getListEntries(wks)

addListEntry(wks, contentList)

updateListEntry(listEntries, contentList)

deleteListEntry(listEntries)

}
\arguments{
  \item{wks}{ A 'WorksheetEntry' object.}  
  \item{listEntries}{ A list of 'ListEntry' objects.}
  \item{contentList}{ A list of lists.  An element of the inside list
    contains the data to be uploaded with names that match the 'tags'
    (column names of the worksheet).  As all the data is passed as
    strings to Google, an internal conversion to \code{as.character} is
    automatically performed.}  
}

\details{
  'ListEntry' objects correspond to one row of a worksheet.  See the
  class documentation \code{\linkS4class{ListEntry} for more details.}
  
  'addListEntry' adds the contentList to the worksheet.
  
  'updateListEntries' modifies only the 'tags' that are specified in the
  contentList.  The other 'tags' are left unmodified.  This allows for
  modification of only parts of the spreadsheet. 
  
  'deleteListEntries' permanently removes the corresponding
  'ListEntries' from your account.  I am not aware of ways to reverse
  this action, so be careful. 
  
}
\value{
  'getListEntries' returns a list of 'ListEntry' objects, each element
  of the list pointing to one row of the worksheet.  To extract the
  content of a 'ListEntry' object you need to call it's
  \code{getContent} method.
  
  'addListEntry', 'updateListEntries', and 'deleteListEntries' return a
  logical, true for success and NA for failure.  In case of failure, you
  can inspect the reason by using \code{\link{getMsg}} function.
}
\author{Adrian Dragulescu}
\seealso{\code{\linkS4class{ListEntry}} for the 'ListEntry'
  class, and \code{\link{Worksheets}} for manipulating spreadsheets.}
\examples{

# get the ListEntries of a WorksheetEntry
listEntries <- getListEntries(wks)
listEntry <- listEntries[[1]]

# how to coerce to data.frame
as(listEntry, "data.frame")
do.call("rbind", lapply(listEntries, as, "data.frame"))

# get the contents of a listEntry
getContent(listEntry)
getContent(listEntries)

# add ListEntries, by constructing a contentList from a data.frame
aux <- data.frame(year=2001:2010, value=1:10, transaction.point=letters[1:10])
contentList <- apply(aux, 1, as.list)
addListEntry(wks, contentList)

# modify existing ListEntries
theseListEntries <- listEntries[1:3]
contentList <- list(list(year=2051, month=1), list(year=2052), list(year=2053))
updateListEntry(theseListEntries, contentList)

# delete ListEntries
theseListEntries <- listEntries[1:3]
deleteListEntry(theseListEntries)




}

