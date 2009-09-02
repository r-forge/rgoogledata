
# Run some simple automated tests for the package
#
#

dirUT <- "H:/user/R/Adrian/findataweb/temp/RGoogleData/inst/unitTests/"

require(RUnit)
require(RGoogleData)

source(paste(dirUT, "/test.Documents.R", sep=""))
test.Documents()

source(paste(dirUT, "/test.Spreadsheets.R", sep=""))
test.Spreadsheets()

source(paste(dirUT, "/test.UploadDownload.R", sep=""))
test.UploadDownload(deleteFiles=FALSE)






## testSuite <- defineTestSuite("RGoogleData",
##   dirs=dirUT,
##   testFileRegexp="\\.R$",
##   testFuncRegexp="^test.+",
##   rngKind = "Marsaglia-Multicarry",
##   rngNormalKind = "Kinderman-Ramage"                                     
## )

## results <- runTestSuite(testSuite)
## printTextProtocol(results)










## # get all folders
## folders <- getFolders(con)
## do.call("rbind", lapply(folders, as, "data.frame"))

## # get all the documents
## docs <- getDocuments(con)

## # convert to user-friendly data.frame
## as(docs[[1]], "data.frame")
## do.call("rbind", lapply(docs, as, "data.frame"))

## # select all documents with title == "test"
## doc <- docs[sapply(docs, function(doc){doc@title=="test"})]

## #extract one slot
## sapply(docs, slot, "title")

# get all the spreadsheets
allXls <- getSpreadsheets(con)
do.call("rbind", lapply(allXls, as, "data.frame"))

## # get the worksheets
## xls <- allXls[[1]]
## wks <- getWorksheets(xls)[[1]]  # get the first sheet
## as(wks, "data.frame")

## # get the ListEntries of a WorksheetEntry
## listEntries <- getListEntries(wks)
## listEntry <- listEntries[[1]]
## as(listEntry, "data.frame")
## do.call("rbind", lapply(listEntries, as, "data.frame"))

## # get the contents of a listEntry
## getContent(listEntry)
## getContent(listEntries)

## # add ListEntries
## aux <- data.frame(year=2001:2010, value=1:10, transaction.point=letters[1:10])
## contentList <- apply(aux, 1, as.list)
## addListEntry(wks, contentList)

## # modify existing ListEntries
## theseListEntries <- listEntries[1:3]
## contentList <- list(list(year=2051, month=1), list(year=2052), list(year=2053))
## updateListEntry(theseListEntries, contentList)

## # delete ListEntries
## theseListEntries <- listEntries[1:3]
## deleteListEntry(theseListEntries)



## # add a new worksheet
## addWorksheet(xls, title="mySheet", nrow=100, ncol=5)

## # delete a worksheet
## wks <- getWorksheets(xls)
## wks <- wks[sapply(wks, function(x){x@title=="mySheet"})]
## deleteWorksheet(wks)





slots <- slotNames(wks[[1]])
cat(paste("      ", slots, " = from@", slots, sep="", collapse=",\n"))


## ######################################################################
## # FILE/FOLDER MANIPULATIONS
## # create an empty GoogleDocument in your Google account
## newDocument(con, title="another test", folder=folders[[1]])

## newDocument(con, title="another test")

## newFolder(con, title="Folder2")

## docs <- getDocuments(con)
## doc <- docs[sapply(docs, function(doc){doc@title=="another test"})][[1]]
## removeFromFolder(con, doc, folder=folders[[1]])

## trashDocument(con, doc)
















#########################################################################
#########################################################################
#########################################################################
#########################################################################

## require(RGoogleData)
## username <- "rdocsdemo@gmail.com"
## password <- "RGooglePass12"


## RInt <- login(username, password)

## titles  <- getDocsNames(RInt)

## folders <- getFolderNames(RInt)

## dd <- getDocsDetails(RInt)


## spreadsheetId <- "ttXrIUcU402o2GV2jsGsF0g"
## getSpreadsheetDetails(RInt, spreadsheetId)


## readWorksheet(RInt, spreadsheetId, worksheetname="Sheet 1",
##   colClasses=c("integer", "integer", rep("character", 3), "numeric"))

## data <- readWorksheet(RInt, spreadsheetId, worksheetname="Sheet 1")

## # USA arrests has problems because first entry is empty!
## spreadsheetId <- "tsXXZb-ez5G-_dPfJLtr3pA"  
## data <- readWorksheet(RInt, spreadsheetId, worksheetname="Sheet 1")

## # state.x77 has the same issue!
## spreadsheetId <- "spreadsheet%3AtWLlY55vi-lLx0IqyFZmSiw"
## data <- readWorksheet(RInt, spreadsheetId, worksheetname="Sheet 1")

## spreadsheetId <- "spreadsheet%3Ate-a0B-G6X1dfZ0tD5AH9vA"
## data <- readWorksheet(RInt, spreadsheetId, worksheetname="Sheet 1")
