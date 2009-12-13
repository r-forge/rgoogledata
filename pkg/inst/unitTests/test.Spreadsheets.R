# Test basic document operations
#
#

test.Spreadsheets <- function()
{
  require(RGoogleData)
  username <- "rdocsdemo@gmail.com"
  password <- "RGooglePass12"
  con <- googleConnect(username, password)
  
  allXls <- getSpreadsheets(con)

  cat("check if there are any spreadsheets:\n")
  target <- (length(allXls)>0)
  print(checkEquals(TRUE, target))

  cat("add worksheet 'toDelete' to 'testxls':\n")
  xls <- allXls[[which(sapply(allXls, slot, "title") == "testxls")]]
  target <- addWorksheet(xls, title="toDelete")
  print(checkEquals(TRUE, target))

  cat("delete worksheet I just created:\n")
  allWks <- getWorksheets(xls)
  wks <- allWks[[which(sapply(allWks, slot, "title") == "toDelete")]]
  target <- deleteWorksheet(wks)
  print(checkEquals(TRUE, target))

  cat("check that the 'toDelete' worksheet is no longer there:\n")
  allWks <- getWorksheets(xls)
  titles <- sapply(allWks, slot, "title")
  target <- !("toDelete" %in% sapply(allWks, slot, "title"))
  print(checkEquals(TRUE, target))

  ####################################################################
  # List Entries 
  
  cat("get the ListEntries from first sheet of 'testxls':\n", sep="")
  xls <- allXls[[which(sapply(allXls, slot, "title") == "testxls")]]
  allWks <- getWorksheets(xls)
  wks <- allWks[[which(sapply(xls, slot, "title") == "Sheet 1")]] 
  listEntries <- getListEntries(wks)
  target <- (length(listEntries) > 0)
  print(checkEquals(TRUE, target))

  cat("getContent from a list of ListEntries:\n")
  print(getContent(listEntries))
  cat("\n\n")

  cat("add ListEntries to the worksheet:\n")
  aux <- data.frame(year=1601:1610, value=1:10, transaction.point=letters[1:10])
  contentList <- apply(aux, 1, as.list)
  target <- addListEntry(wks, contentList)
  print(checkEquals(TRUE, target))

  cat("modify the ListEntries I just added to the worksheet:\n")
  listEntries <- getListEntries(wks)
  content <- getContent(listEntries)
  theseRowIds <- rownames(subset(content, year %in% 1601:1610))
  theseListEntries <- listEntries[which(sapply(listEntries, slot,
    "rowId") %in% theseRowIds)]
  aux <- data.frame(year=1201:1210, value=1:10, transaction.point=letters[1:10])
  contentList <- apply(aux, 1, as.list)
  target <- updateListEntry(theseListEntries, contentList)
  print(checkEquals(TRUE, target))

  cat("check that the content has actually been modified:\n")
  content <- getContent(theseListEntries)
  target <- all(content$year %in% 1201:1210)
  print(checkEquals(TRUE, target))
  
  cat("delete ListEntries I've just modified:\n")
  target <- deleteListEntry(theseListEntries)
  print(checkEquals(TRUE, target))
 
  cat("check that the ListEntries have actually been deleted:\n")
  listEntries <- getListEntries(wks)
  content <- getContent(listEntries)
  target <- all(content$year > 2000)
  print(checkEquals(TRUE, target))
  

  
}





