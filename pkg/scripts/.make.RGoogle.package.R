# A make file for the package ... 
# 
#
#

##################################################################
#
.setEnv <- function(computer=c("HOME", "LAPTOP", "WORK"))
{
  if (computer=="WORK"){
    pkgdir  <<- "H:/user/R/Adrian/findataweb/temp/RGoogleData/"
    outdir  <<- "H:/"
    Rcmd    <<- "S:/All/Risk/Software/R/R-2.10.1/bin/Rcmd"
    javadir <<- "C:/Documents and Settings/e47187/workspace/test_gdata/"
  } else if (computer == "LAPTOP"){
    pkgdir <<- "C:/Users/adrian/R/findataweb/temp/xlsx/"
    outdir <<- "C:/"
    Rcmd   <<- '"C:/Program Files/R/R-2.10.1/bin/Rcmd"'
  } else if (computer == "HOME"){
  } else {
  }

  invisible()
}

##################################################################
#
.update.DESCRIPTION <- function(packagedir, version)
{
  file <- paste(packagedir, "DESCRIPTION", sep="") 
  DD  <- readLines(file)
  ind  <- grep("Version: ", DD)
  aux <- strsplit(DD[ind], " ")[[1]]
  
  if (is.null(version)){   # increase by one 
    vSplit    <- strsplit(aux[2], "\\.")[[1]]
    vSplit[3] <- as.character(as.numeric(vSplit[3])+1) 
    version <- paste(vSplit, sep="", collapse=".")
  }   
  DD[ind] <- paste(aux[1], version)

  ind <- grep("Date: ", DD)
  aux <- strsplit(DD[ind], " ")[[1]]
  DD[ind] <- paste(aux[1], Sys.Date())
  
  writeLines(DD, con=file)
  return(version)
}

##################################################################
#
.move.java.classes <- function(do=TRUE)
{
  if (do){
    setwd(javadir)
    
    # create my jar and move it to the inst/java/ directory
    setwd("bin")
    system("jar -cvf RInterface.jar dev/*.class")
    file.copy("RInterface.jar", paste(pkgdir,
      "inst/java/RInterface.jar", sep=""), overwrite=TRUE)
    unlink("RInterface.jar")
    setwd("..")

    # move the source files to have for reference ... 
    file.copy("src/dev/RInterface.java", paste(pkgdir, 
      "inst/java/RInterface.java", sep=""), overwrite=TRUE)
    file.copy("src/testRInterface.java", paste(pkgdir, 
      "inst/java/testRInterface.java", sep=""), overwrite=TRUE)
    file.copy("src/dev/DocumentListException.java", paste(pkgdir, 
      "inst/java/DocumentListException.java", sep=""), overwrite=TRUE)
  }
  invisible()
}

##################################################################
##################################################################

#version <- NULL      # keep increasing the minor
version <- "0.2.0"  # if you want to set it by hand

.setEnv("WORK")

# change the version
#version <- .update.DESCRIPTION(pkgdir, version)

.move.java.classes(TRUE)  # move java classes

# make the package
setwd(outdir)
cmd <- paste(Rcmd, "build --force --binary --no-vignette", pkgdir)
print(cmd)

system(cmd)  
install.packages(paste("RGoogleData_",version,".zip", sep=""), repos=NULL)




