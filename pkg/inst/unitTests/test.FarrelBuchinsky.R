# His issues
#
#

test.FarrelBuchinsky <- function()
{
  require(RGoogleData)
  username <- "rdocsdemo@gmail.com"
  password <- "RGooglePass12"
  con <- googleConnect(username, password)
  
  allXls <- getSpreadsheets(con)

  xls <- allXls[[which(sapply(allXls, slot, "title") == "OnCall")]]
  #xls <- allXls[[which(sapply(allXls, slot, "title") == "testxls")]]

  allWks <- getWorksheets(xls)            # get the worksheets
  titles <- sapply(allWks, slot, "title") # get the titles

  wks <- allWks[[which(sapply(allWks, slot, "title") == "y2009")]] 
  listEntries <- getListEntries(wks)   # get the rows 
  
  res <- getContent(listEntries)       # get the content for the rows
  # wait a bit ... and works

  
  # read ?getListEntries for help


  # read all the sheets
  res <- vector("list", length=length(allWks))
  names(res) <- titles
  for (i in 1:length(allWks)){
    cat("Working on sheet:", allWks[[i]]@title, "\n")
    listEntries <- getListEntries(allWks[[i]])
    res[[i]] <- getContent(listEntries[1:3])   # get the first 3 rows only
  }



  # download OnCall_reloaded document.  OnCall does not work -- too old?!
  allXls <- getSpreadsheets(con)  
  xls <- allXls[[which(sapply(allXls, slot, "title") == "OnCall_reloaded")]]  
  downloadDocument(xls, "C:/Temp/oncall_1.csv", "csv", 1)

  
       


       
}

  
 


