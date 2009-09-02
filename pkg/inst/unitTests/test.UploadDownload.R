# Test basic document operations
#
#

test.UploadDownload <- function(deleteFiles=TRUE)
{
  username <- "rdocsdemo@gmail.com"
  password <- "RGooglePass12"
  con <- googleConnect(username, password)

  ##################################################################
  # upload

  # a text file
  cat("upload R license text file to a document 'RLicense':")
  filepath <- "C:/Temp/RLicense.txt"
  sink(file=filepath)
  license()
  sink()
  title <- "RLicense" 
  uploadDocument(con, filepath, title)
  target <- con@ref$getMsg() == ""
  #print(checkException(TRUE != target, "Not working", silent=TRUE))
  if (!target) cat("Not working!\n")
  if (target)  cat("Remove the file!")
  
  
  # a csv file
  cat("upload a csv file to a document 'roseton':")
  filepath <- "C:/Temp/rosetonFTRs.csv"
  title <- "roseton" 
  uploadDocument(con, filepath, title)
  target <- con@ref$getMsg() == ""
  #print(checkException(TRUE, target))
  if (!target) cat("Not working!\n")
  if (target) cat("Remove the file!")

 

  folders <- getFolders(con)


  ##################################################################
  # download

  allXls <- getSpreadsheets(con)
  doc <- allXls[[which(sapply(allXls, slot, "title")=="iris")]]
  
  cat("download 'iris' to a csv format:\n")
  filepath1 <- "C:/Temp/iris3.csv"
  downloadDocument(doc, filepath1, fileformat="5")
  if (file.exists(filepath1)){
    target <- TRUE
  }
  print(checkEquals(TRUE, target))

  cat("download 'iris' to a spreadsheet format:\n")
  filepath2 <- "C:/Temp/iris3.xls"
  downloadDocument(doc, filepath2, fileformat="4")
  if (file.exists(filepath2)){
    target <- TRUE
  }
  print(checkEquals(TRUE, target))
 
  cat("download 'iris' to a pdf format:\n")
  filepath3 <- "C:/Temp/iris3.pdf"
  downloadDocument(doc, filepath3, fileformat="12")
  if (file.exists(filepath3)){
    target <- TRUE
  }
  print(checkEquals(TRUE, target))


  cat("download 'testXls' with multiple sheets to a spreadsheet format:\n")
  doc <- allXls[[which(sapply(allXls, slot, "title")=="testxls")]]
  filepath4 <- "C:/Temp/testxls3.xls"
  downloadDocument(doc, filepath4, fileformat="4")
  if (file.exists(filepath4)){
    target <- TRUE
  }
  print(checkEquals(TRUE, target))

  
  if (deleteFiles){
    unlink(c(filepath1, filepath2, filepath3, filepath4))
  }
  

  
}





