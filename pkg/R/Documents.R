

setClass("BaseEntry",
  representation(
    authors     = "character", 
    canEdit     = "logical",
    id          = "character",
    etag        = "character", 
    published   = "POSIXt",
    content     = "character",  # a stub unless getContent is called
    title       = "character",
    con         = "GoogleConnection"))

setClass("MediaEntry", contains="BaseEntry")

setClass("DocumentListEntry",
  contains="MediaEntry",
    representation(
      htmlLink   = "character",   # the html you can open in a browser
      lastModifiedBy = "character",
      lastUpdated    = "POSIXt",              
      lastViewed     = "POSIXt",
      isHidden       = "logical",
      isStarred      = "logical",
      isTrashed      = "logical",
      isViewed       = "logical",
      isWritersCanInvite = "logical",
      folder   = "character",        # parent folder
      key      = "character"))

setClass("WorksheetEntry",
  contains = "BaseEntry",
    representation(
      ncol = "integer",
      nrow = "integer"))

setClass("TableEntry", contains = "BaseEntry")
setClass("ListEntry", representation(rowId = "character"),
  contains = "BaseEntry")
setClass("CellEntry",  contains = "BaseEntry")


setClass("DocumentEntry",     contains = "DocumentListEntry")
setClass("FolderEntry",       contains = "DocumentListEntry")
setClass("PresentationEntry", contains = "DocumentListEntry")
setClass("SpreadsheetEntry",  contains = "DocumentListEntry")

setGeneric("getContent", function(obj, ...){
  standardGeneric("getContent")})

##############################################################################
# obj can be a list of other objects (ListEntry, RecordEntry, CellEntry)
# data can be a list of named character vectors or a data.frame
#
setGeneric("setContent", function(obj, data, ...){
  standardGeneric("setContent")})


##############################################################################
# How to aggregate getContent from lists of objects
# Each list element is a matrix
#
setMethod("getContent", "list",              # how to operate on lists of stuff
  function(obj, as.data.frame=TRUE, col.names=NA, colClasses=NA)
  {
    res <- lapply(obj, "getContent")

    allColnames <- unique(unlist(lapply(res, colnames)))  
    if (!is.na(col.names))
      allColnames <- allColnames[col.names]
    # fill columns with missing colnames 
    temp <- matrix(NA, nrow=nrow(res[[1]]), ncol=length(allColnames))
    colnames(temp) <- allColnames
    res <- lapply(res, function(x, temp){
        ans <- temp
        ind <- which(allColnames %in% colnames(x))
        ans[, ind] <- x   # will I have drop=TRUE problems?
        ans}, temp)

    
    if (as.data.frame){
      rows <- length(res)
      cols <- length(allColnames)
      rnames <- names(res)
      
      res <- split(unlist(res), rep(1:cols, rows))
      names(res) <- allColnames
      
    # impose colClasses -- copied code from read.table
      nmColClasses <- names(colClasses)
      if (length(colClasses) < cols) 
         if (is.null(nmColClasses)) {
            colClasses <- rep(colClasses, length.out = cols)
          } else {
            tmp <- rep(NA_character_, length.out = cols)
            names(tmp) <- col.names
            i <- match(nmColClasses, col.names, 0L)
            if (any(i <= 0L)) 
               warning("not all columns named in 'colClasses' exist")
            tmp[i[i > 0L]] <- colClasses
            colClasses <- tmp
         }
      for (i in (1L:cols)) {
        res[[i]] <- if (is.na(colClasses[i])) 
          type.convert(res[[i]], as.is = TRUE, na.strings = character(0L))
         else if (colClasses[i] == "factor") 
           as.factor(res[[i]])
         else if (colClasses[i] == "Date") 
           as.Date(res[[i]])
         else if (colClasses[i] == "POSIXct") 
           as.POSIXct(res[[i]])
         else methods::as(res[[i]], colClasses[i])
      }
      res <- as.data.frame(res, stringsAsFactors=FALSE, optional=TRUE)
      rownames(res) <- rnames
    }
      
    res
  })


# to use for getting ListEntry feeds ...
# http://spreadsheets.google.com/feeds/lists/ttXrIUcU402o2GV2jsGsF0g/od6/private/full

##############################################################################
# initialize a BaseEntry from a list with meta-data.
#
setMethod("initialize", "BaseEntry",
  function(.Object, listFields, ...)
  {
    slots <- names(listFields) 
    for (slotName in slots)
      slot(.Object, slotName) <- listFields[[slotName]]
    
    .Object
  }
)

setAs("BaseEntry", "list",
  function(from){
    res <- list(
      title = from@title,
      authors = from@authors,
      canEdit = from@canEdit,
#      etag = from@etag,
      published = from@published,
#      content = from@content,
#      con = from@con,
      id = from@id
     )

    res
  })

setAs("BaseEntry", "data.frame",
  function(from){
    as.data.frame(as(from, "list"), stringsAsFactors=FALSE)
  })

setMethod("show", "BaseEntry",
  function(object){
    cat("S4 object of class \"", class(object), "\"\n", sep="")
    cat("@title =", object@title, 
        "\n@authors =", object@authors,
        "\n@published =", as.character(object@published),
        "\n@id =", object@id)
  })


######################################################################
# initialize a DocumentListEntry from a list with meta-data.
# Not even sure I need this ... use callNextMethod
setMethod("initialize", "DocumentListEntry",
  function(.Object, listFields, ...)
  {
    #browser()
    slots <- names(listFields) 
    for (slotName in slots)
      slot(.Object, slotName) <- listFields[[slotName]]
    
    .Object
  }
)

setMethod("initialize", "DocumentEntry",
  function(.Object, listFields, ...)
    callNextMethod(.Object, listFields, ...))
setMethod("initialize", "SpreadsheetEntry",
  function(.Object, listFields, ...)
    callNextMethod(.Object, listFields, ...))
setMethod("initialize", "FolderEntry",
  function(.Object, listFields, ...)
    callNextMethod(.Object, listFields, ...))
setMethod("initialize", "PresentationEntry",
  function(.Object, listFields, ...)
    callNextMethod(.Object, listFields, ...))


setAs("DocumentListEntry", "list",
  function(from){
    res <- list(
      title = from@title,  
      folder = from@folder,
#      htmlLink = from@htmlLink,
#      lastModifiedBy = from@lastModifiedBy,
      lastUpdated = from@lastUpdated,
      lastViewed = from@lastViewed,
      isHidden = from@isHidden,
      isStarred = from@isStarred,
      isTrashed = from@isTrashed,
      isViewed = from@isViewed,
      isWritersCanInvite = from@isWritersCanInvite,
#      key = from@key,
#      authors = from@authors,
      canEdit = from@canEdit,
#      id = from@id,
#      etag = from@etag,
      published = from@published
#      content = from@content,
      )

    res 
  })

setAs("DocumentListEntry", "data.frame",
  function(from){
    as.data.frame(as(from, "list"), stringsAsFactors=FALSE)
  })


####################################################################
# create an empty document/spreadheet/presentation on the Google side
# some syntactic sugar
newDocument <- function(con, title, folder)
  .newDocumentListEntry(con, title, folder, type="document")
newSpreadsheet <- function(con, title, folder)
  .newDocumentListEntry(con, title, folder, type="spreadsheet")
newPresentation <- function(con, title, folder)
  .newDocumentListEntry(con, title, folder, type="presentation")
newFolder <- function(con, title, folder)
  .newDocumentListEntry(con, title, folder, type="folder")
.newDocumentListEntry <- function(con, title, folder, type=c("document",
  "presentation", "spreadsheet", "folder"))
{ 
  type <- match.arg(type)

  inFolderId <- ""
  if (!missing(folder))
    inFolderId <- folder@key
       
  con@ref$newDocument(title, type, inFolderId)
  
  invisible(as.logical(con@ref$getMsg()))
}


####################################################################
# move a document to another folder
# need to have inFolderId.  If inFolderId="", move to home. 
moveFileToFolder <- function(doc, folder)
{
  doc@con@ref$moveDocumentToFolder(doc@id, folder@key)

  invisible(as.logical(doc@con@ref$getMsg()))
}


####################################################################
# take the document from folder and bring it to home directory
#
removeFileFromFolder <- function(doc, folder)
{
  doc@con@ref$removeDocumentFromFolder(doc@key, folder@key)

  invisible(as.logical(doc@con@ref$getMsg()))
}

####################################################################
# Send document to trash bin.  If document is in a folder, 
# inFolderId needs to be specified. 
trashFile <- function(doc)
{
  doc@con@ref$trashDocument(doc@key)

  invisible(as.logical(doc@con@ref$getMsg()))
}


