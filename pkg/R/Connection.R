

googleConnect <- function(...)
  new("GoogleConnection", ...)  

setClass(
  Class="GoogleConnection",
  representation=representation(
    login       = "character",
    password    = "character",
    ref         = "jobjRef"),
  prototype=prototype(
    login       = "",
    password    = "",
    ref         = .jnull())
)

setMethod("initialize", "GoogleConnection", function(
  .Object, username, password)
  {
    
    ref <- .jnew("dev/RInterface", "R Interface service")

    ref$login(username, password)

    if (class(ref)[1] != "jobjRef" | is.jnull(ref))
      stop("Could not connect.  Check your settings.")  

    .Object@login    <- as.character(username)
    .Object@password <- as.character(password)
    .Object@ref      <- ref

    .Object
  }
)


setMethod("show", "GoogleConnection",
  function(object){
    cat("S4 object of class \"", class(object), "\"\n", sep="")
    lines <- NULL
    for (s in slotNames(object)){
      cont  <- slot(object, s)
      if (s == "password")
        cont <- paste(rep("x", nchar(cont)), sep="", collapse="")
      if (is.character(cont))cont <- paste('"', cont, '"', sep="")
      if (class(cont)=="jobjRef") cont <- "jobjRef"
      lines <- paste(lines, paste("@", s, " = ", cont, "\n",
                                  sep=""), sep="")
    }    
    cat(lines)    
  }
)


setGeneric("getDocuments", function(con, ...){standardGeneric("getDocuments")})
setGeneric("getSpreadsheets", function(con, ...){standardGeneric("getSpreadsheets")})
setGeneric("getPresentations", function(con, ...){standardGeneric("getPresentations")})
setGeneric("getFolders", function(con, ...){standardGeneric("getFolders")})


setMethod("getDocuments", "GoogleConnection",
  function(con, ...) .getDocumentListEntries(con, type="document"))

setMethod("getSpreadsheets", "GoogleConnection",
  function(con, ...) .getDocumentListEntries(con, type="spreadsheet"))

setMethod("getPresentations", "GoogleConnection",
  function(con, ...) .getDocumentListEntries(con, type="presentation"))

setMethod("getFolders", "GoogleConnection",
  function(con, ...) .getDocumentListEntries(con, type="folder"))

.getDocumentListEntries <- function(con, type=c("document",
   "spreadsheet", "folder", "presentation"))
{
  #type <- "document"
  msg <- con@ref$getDocumentListEntries(as.character(type))

  if (con@ref$getMsg() != "")
    stop(con@ref$getMsg())

  msg <- strsplit(msg, "\n")[[1]]      # split by docs
  if (length(msg)==0){
    cat("No ", type, "s found.\n", sep="")
    return
  }
  
  msg <- strsplit(msg, "\t")           # split by fields
  slotNames <- msg[[1]]
  msg <- msg[-1]
  msg <- lapply(msg, as.list)
  msg <- lapply(msg, function(x, slotNames){names(x) <- slotNames; x},
                slotNames)

  # make bolean columns
  msg <- lapply(msg,
    function(x, slotNames){
      ind <- which(slotNames %in% c("isViewed", "isWritersCanInvite",
        "isHidden", "isStarred", "canEdit", "isTrashed"))
      x[ind] <- as.logical(toupper(unlist(x[ind])))
      x
    }, slotNames)

  # make POSIXct columns
  msg <- lapply(msg,
    function(x, slotNames){
      x$published   <- as.POSIXct(x$published, "%Y-%m-%dT%H:%M:%OSZ", tz="")
      x$lastViewed  <- as.POSIXct(x$lastViewed, "%Y-%m-%dT%H:%M:%OSZ", tz="")
      x$lastUpdated <- as.POSIXct(x$lastUpdated, "%Y-%m-%dT%H:%M:%OSZ", tz="")
      x
    }, slotNames)
  
  # from doc API 3.0, the spreadsheet key != document key 
  if (type=="spreadsheet"){  
    msgSS <- con@ref$getSpreadsheetListEntries()
    msgSS <- strsplit(strsplit(msgSS, "\n")[[1]], "\t")
    msgSS <- unlist(lapply(msgSS[-1], "[", 1))
    spreadsheetKeys <- gsub(".*/(.*)", "\\1", msgSS)
    for (i in seq_along(spreadsheetKeys))
      msg[[i]]$spreadsheetKey <- spreadsheetKeys[i]   
  }

  
  docs <- vector("list", length(msg))
  # create the doc descriptions
  for (d in 1:length(msg)){
    listFields <- msg[[d]]
    listFields$con <- con
    if (type=="document"){
      docs[[d]] <- new("DocumentEntry", listFields)
    } else if (type == "spreadsheet"){
      docs[[d]] <- new("SpreadsheetEntry", listFields)
    } else if (type == "presentation"){
      docs[[d]] <- new("PresentationEntry", listFields)
    } else if (type == "folder"){
      docs[[d]] <- new("FolderEntry", listFields)
    } else {
      stop("Unkown document type", type)}   
  }
  
  docs
}



###############################################################################
# Exact matches only.  For example query="virginica" will show
# document iris.  But a search on "vir" will not match iris. 
fullTextQuery <- function(con, query)
{
  msg <- con@ref$fullTextQuery(query)

  if (RInt$ref$getMsg() != "")
    stop(RInt$ref$getMsg())
  
  strsplit(msg, "\n")[[1]]
}









## setGeneric("getDocsNames", function(con){standardGeneric("getDocsNames")})
## setGeneric("getAllDocs", function(con){standardGeneric("getAllDocs")})

## setMethod("getDocsNames", "GoogleConnection",
##   function(con)
##   {  
##     getDocsNames(con)
##   }
## )

## setMethod("getAllDocs", "GoogleConnection",
##   function(con)
##   {  
##     getAllDocs(con)
##   }
## )
