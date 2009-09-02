\name{Documents}
\alias{Documents}
\alias{newDocument}
\alias{moveFileToFolder}
\alias{removeFileFromFolder}
\alias{trashFile}
\title{ Functions to manipulate DocumentListEntry objects.}
\description{
Various functions that allow simple operations on DocumentListEntry objects.
Remember that DocumentEntry, SpreadsheetEntry, PresentationEntry, and
FolderEntry are subclasses of DocumentListEntry.
}
\usage{

newDocument(con, title, folder)

newSpreadsheet(con, title, folder)

newPresentation(con, title, folder)

newFolder(con, title, folder)

moveFileToFolder(documentListEntry, folder)

removeFileFromFolder(documentListEntry, folder)

trashFile(documentListEntry)

}
\arguments{
  \item{con}{ A \code{GoogleConnection} object as returned by
    \code{\link{googleConnect}}.}
  \item{title}{ A character string for the document title.}
  \item{folder}{ An object of class \code{FolderEntry}.}
  \item{documentListEntry}{ An object of class \code{DocumentEntry},
    \code{SpreadsheetEntry}, \code{PresentationEntry}, or
    \code{FolderEntry} object.}
}

\details{
  
  The 'new*' functions create an empty object of their respective class name
  in your Google account (NOT in R).  To get the document in R you have
  to call one of the 'get*' functions (e.g. \code{getDocuments}.)

  These functions are not vectorized and can work with only one
  \code{DocumentListEntry} at a time.
  
  \code{removeFileFromFolder} moves the file from its folder into your home
  directory. 
  
  \code{trashFile} moves the file into the Trash folder in your Google account.
  
  For simplicity, in the last three function names I prefered the use of 
  'file' instead of the more precise 'DocumentListEntry'.
  
}
\value{
  All functions return a logical, true for success and NA for failure.
  In case of failure, you can inspect the reason by using
  \code{\link{getMsg}} function.  
}
\author{ Adrian Dragulescu }
\seealso{\code{\link{getDocuments}}, and for retreiving error messages
  \code{\link{getMsg}}.  To upload/download files see
  \code{\link{uploadDocument}.}
}
\examples{

# create an empty document on your Google account
newDocument(con, title="test")



}

