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

trashFile(documentListEntry, delete=FALSE)

}
\arguments{
  \item{con}{ A \code{GoogleConnection} object as returned by
    \code{\link{googleConnect}}.}
  \item{title}{ A character string for the document title.}
  \item{folder}{ An object of class \code{FolderEntry}.}
  \item{documentListEntry}{ An object of class \code{DocumentEntry},
    \code{SpreadsheetEntry}, \code{PresentationEntry}, or
    \code{FolderEntry} object.}
  \item{delete}{ A logical value indicating if the document should be
    permanently deleted.  If \code{FALSE}, the document is just moved
    into the trash bin.}
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
  
}
\value{
  All functions return a logical, \code{TRUE} for success and \code{NA}
  for failure.
}
\author{ Adrian Dragulescu }
\seealso{\code{\link{getDocuments}}.  To upload/download files see
  \code{\link{uploadDocument}.}
}
\examples{

# create an empty document on your Google account
newDocument(con, title="test1234")

# list all documents
docs <- getDocuments(con)
doc  <- docs[[which(sapply(docs, slot, "title") == "test1234")[1]]]

# trash the document you just created
target <- trashFile(doc)


}

