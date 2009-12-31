# Test basic document operations
#
#

test.UploadDownload <- function(deleteFiles=TRUE)
{
  require(RGoogleData); require(RUnit)
  username <- "rdocsdemo@gmail.com"
  password <- "RGooglePass12"
  con <- googleConnect(username, password)

  ##################################################################
  # upload  DOES NOT WORK WELL

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
  filepath1 <- "C:/Temp/iris.csv"
  downloadDocument(doc, filepath1, fileformat="csv", sheetIndex=1)
  if (file.exists(filepath1)){
    target <- TRUE
  }
  print(checkEquals(TRUE, target))

  cat("download 5th sheet of 'myOnCall' to a csv format:\n")
  doc <- allXls[[which(sapply(allXls, slot, "title")=="myOnCall")]]  
  filepath1 <- "C:/Temp/myOnCall5.csv"
  downloadDocument(doc, filepath1, fileformat="csv", sheetIndex=5)
  if (file.exists(filepath1)){
    target <- TRUE
    cat("Wrote", filepath1, "\n\n")
  }
  print(checkEquals(TRUE, target))

  cat("download 'testxls' to an 'xls' format (two shets):\n")
  filepath2 <- "C:/Temp/testxls.xls"
  doc <- allXls[[which(sapply(allXls, slot, "title")=="testxls")]]  
  downloadDocument(doc, filepath2, fileformat="xls")
  if (file.exists(filepath2)){
    target <- TRUE
    cat("Wrote", filepath2, "\n\n")
  }
  print(checkEquals(TRUE, target))
 
  cat("download 'iris' to a pdf format:\n")
  filepath3 <- "C:/Temp/iris.pdf"
  downloadDocument(doc, filepath3, fileformat="pdf")
  if (file.exists(filepath3)){
    target <- TRUE
    cat("Wrote", filepath3, "\n\n")
  }
  print(checkEquals(TRUE, target))

  cat("download 'OnCall' with multiple sheets to a spreadsheet format:\n")
  doc <- allXls[[which(sapply(allXls, slot, "title")=="OnCall")]]
  filepath4 <- "C:/Temp/OnCall.xls"
  downloadDocument(doc, filepath4, fileformat="xls")
  if (file.exists(filepath4)){
    target <- TRUE
    cat("Wrote", filepath4, "\n\n")
    cat("File should be corrupt.  Bad format?!")
  }
  print(checkEquals(TRUE, target))  

  if (deleteFiles){
    unlink(c(filepath1, filepath2, filepath3, filepath4))
  }
  

  
}





