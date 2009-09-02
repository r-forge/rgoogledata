# A collection of utilities to format the tws output stream and other

.onLoad <- function(libname, pkgname)
{
  .jpackage(pkgname)
  
  # what's your java  version?  Need > 1.5.0.
  jversion <- .jcall('java.lang.System','S','getProperty','java.version')
  if (jversion <= "1.5.0")
    stop(paste("Your java version is ", jversion,
                 ".  Need 1.5.0 or higher.", sep=""))
    
}

#######################################################################
# Get and clear the message buffer
#
getMsg <- function(con) con@ref$getMsg()

clearMsg <- function(con) con@ref$clearMsgBuffer()

# Strip x and return only the unique document Id.
.getUniqueId <- function(x)
{
  # remove everything before the "%3A"
  x <- gsub(".*%3A(.*)$", "\\1", x)

  strsplit(x, "/")
}


.reshapeMsgToDataFrame <- function(msg, colnames)
{
  msg <- matrix(strsplit(msg, "\n")[[1]], ncol=length(colnames), byrow=TRUE)
  msg <- as.data.frame(msg, stringsAsFactors=FALSE)
  colnames(msg) <- colnames

  msg
}



#######################################################################
# 
#
## login <- function(username, password)
## {
##   # hook up to the goog api
##   ref <- .jnew("dev/RInterface", "R Interface Service")

##   ref$login(username, password)

##   if (ref$getMsg() != "")
##     stop(ref$getMsg())

##   if (class(ref)[1] != "jobjRef" | is.jnull(ref))
##     stop("Could not connect.  Check your settings.")  

##   structure(list(ref=ref), class="RInterface")

## }
