\name{getDocuments}
\alias{getDocuments}
\alias{getPresentations}
\alias{getSpreadsheets}
\alias{getFolders}
\title{ Get all the DocumentListEntry of a certain type.}
\description{
Show the documents, spreadsheets, presentations and folders that exist
in the account.   
}
\usage{
getFolders(con)

getDocuments(con, folder)

getSpreadsheets(con, folder)

getPresentations(con, folder)
}
\arguments{
  \item{con}{ A "GoogleConnection" object as returned by \code{googleConnect}.}
  \item{folder}{ A folder object.  If specified, the function returns the
    documents in that folder only.}
}
\details{
  Internally, all these functions create S4 objects buy calling their
  initialize method.  
}
\value{
  
  'getFolders' returns a list of 'FolderEntry' objects. 
  
  'getDocuments' returns a list of 'DocumentEntry' objects. 
  
  'getSpreadsheets' returns a list of 'SpreadsheetEntry' objects.
  
  'getPresentations' returns a list of 'PresentationEntry' objects.
  
}
\author{ Adrian Dragulescu }
\seealso{\code{\link{Documents}} and \code{\link{Worksheets}}.}
\examples{

# get all folders
folders <- getFolderNames(con) 
do.call("rbind", lapply(folders, as, "data.frame"))

# get all documents
docs <- getDocuments(con)
as(docs[[1]], "data.frame")

}

