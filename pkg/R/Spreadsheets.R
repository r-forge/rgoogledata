# 

setClass("SpreadsheetData",
  representation(
    insertionMode  = "character", 
    startRow       = "integer",
    nrow           = "integer",             
    colIndex       = "character",   # a vector
    colnames       = "character")   # a vector
)


setGeneric("getWorksheets", function(xls, ...){standardGeneric("getWorksheets")})
setGeneric("getTables", function(xls, ...){standardGeneric("getTables")})
setGeneric("getListEntries", function(wks, ...){standardGeneric("getListEntries")})
setGeneric("getCells", function(wks, ...){standardGeneric("getCells")})


setMethod("initialize", "WorksheetEntry",
  function(.Object, listFields, ...)
    callNextMethod(.Object, listFields, ...))
setMethod("initialize", "ListEntry",
  function(.Object, listFields, ...)
    callNextMethod(.Object, listFields, ...))

setMethod("show", "WorksheetEntry",
  function(object){
    callNextMethod(object)
    cat("\n@nrow =", object@nrow, 
        "\n@ncol =", object@ncol)
  })



##########################################################################
#
#setMethod("getWorksheets", "SpreadsheetEntry",
#  function(xls, ...) .getWorksheetEntries(xls, ...))

getWorksheets <- function(xls, ...)
{
  id <- .getUniqueId(xls@id)[[1]]
  worksheetId <- paste("http://spreadsheets.google.com/feeds/spreadsheets/",
                       id, sep="")
   
  msg <- xls@con@ref$getWorksheetEntries(worksheetId)

  msg <- strsplit(msg, "\n")[[1]]      # split by worksheets
  if (length(msg)==1){
    cat("No worksheets found in the spreadheet.\n")
    return
  }
  msg <- strsplit(msg, "\t")           # split by fields
  slotNames <- msg[[1]]
  msg <- msg[-1]
  msg <- lapply(msg, as.list)
  msg <- lapply(msg, function(x, slotNames){names(x) <- slotNames; x},
                slotNames)
  
  msg <- lapply(msg,
    function(x, slotNames){
      x$canEdit <- as.logical(toupper(x$canEdit))
      x$nrow  <- as.integer(x$nrow)
      x$ncol  <- as.integer(x$ncol)
      x$published <- as.POSIXct(x$published, "%Y-%m-%dT%H:%M:%OSZ", tz="")
      x
    }, slotNames)
 
  wks <- vector("list", length(msg))
  for (w in 1:length(wks)){
    listFields <- msg[[w]]
    listFields$con <- xls@con
    wks[[w]] <- new("WorksheetEntry", listFields)  # call the constructor
  }
  
  wks
}


##########################################################################
# convert to data.frame
setAs("WorksheetEntry", "data.frame",
  function(from){
    res <- data.frame(
      title = from@title,
      nrow = from@nrow,
      ncol = from@ncol,
      authors = from@authors,
      canEdit = from@canEdit,
#      id = from@id,
#      etag = from@etag,
      published = from@published,
#      content = from@content,
#      con = from@con,
      stringsAsFactors = FALSE)

    res
  })


##########################################################################
#
#setMethod("getListEntries", "WorksheetEntry",
#  function(wks, ...) .getListEntries(wks, ...))

getListEntries <- function(wks, ...)
{
  id <- gsub("worksheets", "list", wks@id)
  worksheetId <- paste(id, "/private/full", sep="")
   
  msg <- wks@con@ref$getListEntries(worksheetId)

  if (wks@con@ref$getMsg() != "")
    stop(wks@con@ref$getMsg())

  msg <- strsplit(msg, "\n")[[1]]      # split by list entries
  if (length(msg)==0){
    cat("No list entries found in the worksheet.\n")
    return
  }
  msg <- strsplit(msg, "\t")           # split by fields
  slotNames <- msg[[1]]
  msg <- msg[-1]
  msg <- lapply(msg, as.list)
  msg <- lapply(msg, function(x, slotNames){names(x) <- slotNames; x},
                slotNames)
  
  msg <- lapply(msg,
    function(x, slotNames){
      x$canEdit <- as.logical(toupper(x$canEdit))
      x$published <- as.POSIXct(x$published, "%Y-%m-%dT%H:%M:%OSZ", tz="")
      x
    }, slotNames)
 
  entries <- vector("list", length(msg))
  for (e in 1:length(entries)){
    listFields       <- msg[[e]]
    listFields$rowId <- sub(".*/(.*)$", "\\1", listFields$id)
    listFields$con   <- wks@con
    entries[[e]] <- new("ListEntry", listFields)  # call the constructor
  }
  names(entries) <- sapply(entries, slot, "rowId")
  
  entries
}


##########################################################################
# getContent for a ListEntry
# Returns a data.frame with one row
#
setMethod("getContent", "ListEntry",
  function(obj, ...){

    id  <- obj@id
    ind <- gregexpr("/", id)[[1]]
    id  <- paste(substr(id, 1, ind[length(ind)]), "private/full/",
                substr(id, ind[length(ind)]+1, nchar(id)), sep="")

    msg <- obj@con@ref$getContentListEntry(id)
    if (is.null(msg)) return(NULL)

    msg <- strsplit(msg, "\t")[[1]]           # split by fields
    N <- length(msg)
    values <- matrix(msg[seq.int(2,N,2)], ncol=N/2, byrow=TRUE)
    colnames(values) <- msg[seq.int(1,N,2)]
    rownames(values) <- obj@rowId
    
    values
  }
)




##########################################################################
# add ListEntries to a worksheetEntry (wks)
#
addListEntry <- function(wks, contentList)
{
  id  <- wks@id
  ind <- gregexpr("/", id)[[1]]
  id  <- paste(substr(id, 1, ind[length(ind)]), "private/full/",
               substr(id, ind[length(ind)]+1, nchar(id)), sep="")

  # make content string. tag,values separated by \t, listEntries
  # separated by \t.
  content <- sapply(contentList, function(x){
    paste(names(x), x, sep="\t", collapse="\t")})
  content <- paste(content, sep="", collapse="\n")

  wks@con@ref$addListEntry(id, content)

  invisible(as.logical(wks@con@ref$getMsg()))
}


##########################################################################
# add ListEntries to a worksheetEntry (wks)
#
updateListEntry <- function(listEntries, contentList)
{
  if (length(contentList)==1 & !is.list(contentList[1]))
    contentList <- list(contentList) # give the user a break
  
  if (length(listEntries) != length(contentList))
    stop("Non-equal length for the two arguments!")

  # construct the correct list entries id
  id  <- sapply(listEntries, slot, "id")
  ind <- gregexpr("/", id)
  id  <- mapply(function(id, ind){
    paste(substr(id, 1, ind[length(ind)]), "private/full/",
          substr(id, ind[length(ind)]+1, nchar(id)), sep="")}, id, ind)
  ids <- paste(id, sep="", collapse="\n")
  
  # make content string. tag,values separated by \t, listEntries
  # separated by \t.
  content <- sapply(contentList, function(x){
    paste(names(x), x, sep="\t", collapse="\t")})
  content <- paste(content, sep="", collapse="\n")

  listEntries[[1]]@con@ref$updateListEntry(ids, content)

  invisible(as.logical(listEntries[[1]]@con@ref$getMsg()))
}


##########################################################################
# delete ListEntries to a worksheetEntry (wks)
#
deleteListEntry <- function(listEntries)
{

  # construct the correct list entries id
  id  <- sapply(listEntries, slot, "id")
  ind <- gregexpr("/", id)
  id  <- mapply(function(id, ind){
    paste(substr(id, 1, ind[length(ind)]), "private/full/",
          substr(id, ind[length(ind)]+1, nchar(id)), sep="")}, id, ind)
  ids <- paste(id, sep="", collapse="\n")

  listEntries[[1]]@con@ref$deleteListEntry(ids)

  invisible(as.logical(listEntries[[1]]@con@ref$getMsg()))
}


##########################################################################
# create an empty worksheet.  Call it new instead of add for consistency
# with other objects. 
addWorksheet <- function(xls, title, nrow=100, ncol=20)
{
  key <- gsub("spreadsheet%3A(.*)", "\\1", xls@key)
  id <- paste("http://spreadsheets.google.com/feeds/spreadsheets/", key,
              sep="")
  xls@con@ref$addWorksheet(title, as.integer(nrow), as.integer(ncol), id)

  invisible(as.logical(xls@con@ref$getMsg()))
}

##########################################################################
# delete an existing worksheet
deleteWorksheet <- function(wks)
{
  id  <- wks@id
  ind <- gregexpr("/", id)[[1]]
  id  <- paste(substr(id, 1, ind[length(ind)]), "private/full/",
               substr(id, ind[length(ind)]+1, nchar(id)), sep="")
  wks@con@ref$deleteWorksheet(id)
   
  invisible(as.logical(wks@con@ref$getMsg()))
}























## getSpreadsheetDetails <- function(RInt, spreadsheetId)
## {
##   msg <- RInt$ref$getSpreadsheetDetails(spreadsheetId)

##   if (regexpr("^Cannot find", RInt$ref$getMsg())!=-1)
##     stop(RInt$ref$getMsg())

##   Ncols <- 5 
##   msg   <- matrix(strsplit(msg, "\n")[[1]], ncol=Ncols, byrow=TRUE)
##   colnames(msg) <- c("worksheetname", "nrow", "ncol", "worksheetId",
##     "lastUpdated")

##   msg <- as.data.frame(msg, stringsAsFactors=FALSE)
  
##   # make int columns 
##   ind <- which(colnames(msg) %in% c("nrow", "ncol"))
##   msg[,ind] <- sapply(msg[,ind], function(x){as.integer(x)})

##   # drop the unnecessary cruft
##   msg$worksheetId <- gsub(".*/(.*)$", "\\1", msg$worksheetId)
  
##   msg
## }

## setMethod("initialize", "WorksheetEntry",
##   function(.Object, listFields, ...)
##   {
##     slots <- names(listFields) 
##     for (slotName in slots)
##       slot(.Object, slotName) <- listFields[[slotName]]
    
##     .Object
##   }
## )



## ##########################################################################
## #
## readWorksheet <- function(Rint, spreadsheetId, worksheetname="Sheet 1",
##   colClasses=NA)
## {

##   spreadsheetId <- RGoogleData:::.getUniqueId(spreadsheetId)[[1]]
  
##   msg <- RInt$ref$readWorksheetListFeed(spreadsheetId, worksheetname)

##   if (regexpr("^Cannot find", RInt$ref$getMsg())!=-1)
##     stop(RInt$ref$getMsg())

##   msg <- strsplit(msg, "\n")[[1]]
##   msg <- strsplit(msg, "\t")

##   cnames <- msg[[1]][-1]
##   cols   <- length(cnames)
##   rows   <- length(msg)-1
##   rnames <- sapply(msg, "[", 1)   # the listId used as rownames
##   msg <- split(unlist(lapply(msg[-1], "[", 2:(cols+1))), rep(1:cols, rows))
##   names(msg) <- cnames

##   # impose colClasses -- copied code from read.table
##   nmColClasses <- names(colClasses)
##   if (length(colClasses) < cols) 
##      if (is.null(nmColClasses)) {
##         colClasses <- rep(colClasses, length.out = cols)
##       } else {
##         tmp <- rep(NA_character_, length.out = cols)
##         names(tmp) <- col.names
##         i <- match(nmColClasses, col.names, 0L)
##         if (any(i <= 0L)) 
##            warning("not all columns named in 'colClasses' exist")
##         tmp[i[i > 0L]] <- colClasses
##         colClasses <- tmp
##      }
##   for (i in (1L:cols)) {
##     msg[[i]] <- if (is.na(colClasses[i])) 
##       type.convert(msg[[i]], as.is = TRUE, na.strings = character(0L))
##      else if (colClasses[i] == "factor") 
##        as.factor(msg[[i]])
##      else if (colClasses[i] == "Date") 
##        as.Date(msg[[i]])
##      else if (colClasses[i] == "POSIXct") 
##        as.POSIXct(msg[[i]])
##      else methods::as(msg[[i]], colClasses[i])
##   }

##   msg <- as.data.frame(msg, stringsAsFactors=FALSE)
##   attr(msg, "Id") <- rnames

##   msg
## }

