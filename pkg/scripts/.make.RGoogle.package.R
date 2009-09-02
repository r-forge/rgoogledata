# A make file for the package ... 
# 
#
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
##################################################################

version <- NULL      # keep increasing the minor
#version <- "0.0.1"  # if you want to set it by hand

# the java classes are here
javadir <- "C:/Documents and Settings/e47187/workspace/test_gdata/"
# R package is here
packagedir <- "H:/user/R/Adrian/findataweb/temp/RGoogleData/"
Rcmd <- '"C:/Program Files/R/R-2.9.2/bin/Rcmd"'
#Rcmd <- "S:/All/Risk/Software/R/R-2.8.1/bin/Rcmd"

setwd(javadir)

# create my jar and move it to the inst/java/ directory
setwd("bin")
system("jar -cvf RInterface.jar dev/*.class")
file.copy("RInterface.jar", paste(packagedir,
  "inst/java/RInterface.jar", sep=""), overwrite=TRUE)
unlink("RInterface.jar")
setwd("..")

# move the source files to have for reference ... 
file.copy("src/dev/RInterface.java", paste(packagedir, 
  "inst/java/RInterface.java", sep=""), overwrite=TRUE)
file.copy("src/testRInterface.java", paste(packagedir, 
  "inst/java/testRInterface.java", sep=""), overwrite=TRUE)
file.copy("src/testRInterface.java", paste(packagedir, 
  "inst/java/DocumentListException.java", sep=""), overwrite=TRUE)

# change the version
newVersion <- .update.DESCRIPTION(packagedir, version)

# make the package
setwd(packagedir)
cmd <- paste(Rcmd, "build --force --binary --no-vignette", packagedir)
print(cmd)
system(cmd)  

#packname <- paste("H:/RGoogleData_", newVersion, ".zip", sep="")
#install.packages(packname, repos=NULL)
install.packages(paste("RGoogleData_",newVersion,".zip", sep=""), repos=NULL)




