downloadDocument <- function(doc, filepath, fileformat)
{
  if (class(doc)=="list")
    stop("Input 'doc' should not be a list!")
  
  # check that the format matches the document type ...
  ind <- regexpr("%3A", doc@key)
  if (attr(ind, "match.length")!=3)
    stop("Invalid docId.")
  
  docType <- substr(doc@key, 1, ind-1) # document, spreadsheet, presentation

  if (docType == "document")
    if (!(fileformat %in% c("doc", "txt", "odt", "png", "pdf", "rtf", "html")))
      warning("Unrecognized format for document type.")    
  
  if (docType == "spreadsheet")
    if (!(fileformat %in% c("4", "13", "12", "5", "23", "102")))
      warning("Unrecognized format for spreadsheet type.")    

  if (docType == "presentation")
    if (!(fileformat %in% c("pdf", "ppt", "swf")))
      warning("Unrecognized format for presentation type.")    

  doc@con@ref$downloadDocument(doc@key, filepath, as.character(fileformat))

  invisible()
}

uploadDocument <- function(con, filepath, title, folder)
{
  if (missing(folder)) {
    folderId <- ""
  } else {
    # need to fix here
    folderId <- ""
  }
  
   con@ref$uploadDocument(filepath, title, folderId)
   # what happens if the file does not exist?!, is the error thrown out?

   invisible()
}


