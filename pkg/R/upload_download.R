downloadDocument <- function(doc, filepath, fileformat, sheetIndex=NULL)
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
  
  if (docType == "spreadsheet"){
    if (!(fileformat %in% c("xls", "ods", "pdf", "csv", "tsv", "html")))
      warning("Unrecognized format for spreadsheet type.")
    if (fileformat %in% c("csv", "tsv") & is.null(sheetIndex))
      stop('Please provide a sheet index if you want "csv" or "tsv" output.')
  }
 
  if (docType == "presentation")
    if (!(fileformat %in% c("pdf", "ppt", "swf")))
      warning("Unrecognized format for presentation type.")    

  doc@con@ref$downloadDocument(doc@key, filepath, as.character(fileformat),
    as.character(sheetIndex-1))

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


