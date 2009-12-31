# Test basic document operations
#
#

test.Documents <- function()
{
  require(RUnit); require(RGoogleData)
  username <- "rdocsdemo@gmail.com"
  password <- "RGooglePass12"
  con <- googleConnect(username, password)

  docs <- getDocuments(con)
  folders <- getFolders(con)

  cat("check if there are any documents:\n")
  target <- (length(docs)>0)
  print(checkEquals(TRUE, target))

  cat("check if there are any folders:\n")
  target <- (length(folders)>0)
  print(checkEquals(TRUE, target))

  cat("create a new document in home directory:\n")
  target <- newDocument(con, title="test1234")
  print(checkEquals(TRUE, target))

  cat("Sleep 5 secs...\n")  # if I don't sleep I may not find the doc!!
  Sys.sleep(5)
  cat("move the document into folder ", folders[[1]]@title, ":\n", sep="")
  docs <- getDocuments(con)
  doc  <- docs[[which(sapply(docs, slot, "title") == "test1234")[1]]]
  target <- moveFileToFolder(doc, folders[[1]])
  print(checkEquals(TRUE, target))

  cat("trash document 'test1234':\n", sep="")
  docs <- getDocuments(con)
  doc  <- docs[[which(sapply(docs, slot, "title") == "test1234")[1]]]
  if (length(doc)==1){
    target <- trashFile(doc)
    print(checkEquals(TRUE, target))
  } else {
    print("FAILED.  Maybe document wasn't created?!")
  } 
  
}





