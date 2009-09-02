\name{uploadDocument}
\alias{upload}
\alias{uploadDocument}
\alias{downloadDocument}
\title{ Upload documents to Google Docs.  Download Google Docs to local
  file system. }
\description{
Upload documents to Google Docs.  Download Google Docs to local
  file system in different formats.
}
\usage{
uploadDocument(con, filepath, title, folder)

downloadDocument(doc, filepath, format)

}
\arguments{
  \item{con}{ A 'GoogleConnection' object as returned by \code{googleConnect}.}
  \item{filepath}{ A character string with the file path to upload/download.}
  \item{title}{ How do you want to name your document in Google Docs.}
  \item{folder}{ A 'FolderEntry' object.  If empty, the document will be
    uploaded in the home directory.}
  \item{format}{ A character string representing a valid Google format.  See
    the Details section. }
  \item{doc}{An object of class 'DocumentEntry', 'SpreadsheetEntry', or
    'PresentationEntry'. }
}
\details{
  
  The following formats are supported:
  \describe{
    \item{documents:}{"doc", "docx", "txt", "odt", "png", "pdf",
      "rtf", "html"}
     \item{spreadsheets:}{"4" for xls, "??" for xlsx, "13" for ods,
       "12" for pdf, "5" for csv, "23" for tsv, "102" for html.}
     \item{presentations:}{"pdf", "ppt", "swf"}
  }
  Internally, all documents are stored as html.  When downloading a
  document to a different format, Google performs a conversion which
  may not always preserve the right formatting.  So after uploading and
  downloading, the resulting document will not be identical to the
  original document.

  If you try to download a spreadsheet with multiple worksheets into a
  'csv' or 'tsv' format, only the first worksheet will be downloaded.
}
\value{
  None.
}

\note{
  
IMPORTANT: The upload function does not currently work.  The error
messgage that you see has been reported to Google and classified as a
bug.  Hopefully, it will be resolved soon.  What I find strange is that
if I call the method from my Java application it works fine.
  
It is also possible to upload a document into Google Docs by email.
Follow these steps:

1) Click the Upload button from the sidebar in your Docs list page.  2)
In the screen that appears, you'll be given a unique email address. You
can email your files and new documents to this address.  3) Paste this
email into the To: field of an email, and include the content you'd like
to upload in either the body of the email, or as an attachment. In the
subject field, enter the title you'd like to apply to this emailed
document.  After you've done this, your emailed document will appear in
your Docs list.  It is only possible to email in ten or fewer
attachments at a time.

}
\author{ Adrian Dragulescu }
\seealso{\code{\link{getDocuments}} for extracting documents of
  different type from your account.}
\examples{
\dontrun{

  # doc is a spreadsheet in your account with iris data.
  cat("download 'iris' to a spreadsheet format:\n")
  filepath <- "C:/Temp/iris3.xls"
  target <- downloadDocument(doc, filepath, fileformat="4")



}
}

