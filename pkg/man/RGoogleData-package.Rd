\name{RGoogleData-package}
\alias{RGoogleData-package}
\alias{RGoogleData}
\docType{package}
\title{
R Interface to Google Data API (Documents, Spreadsheets, etc.)
}
\description{
\emph{This software is in not affiliated, endorsed, or approved by
    Google.}

The package provides R access to Google services through the Google
supported Java API.  Although GoogleData API provides programatic access
to many Google services (Blogger, Books, Calendar, Contacts, Finance,
Health, Maps, Photos, Youtube, etc.), currently the R interface only
supports Google Docs and Spreadsheets.  Even for these two services,
only a basic set of actions have been made available.  Other useful
actions will be implemented in the future.

Size limits for Google Docs.  Documents: Each doc can have a maximum
size of 500K, plus up to 2MB per embedded image.  Spreadsheets: Each can
be up to 256 columns, 200,000 cells, or 100 sheets -- whichever is
reached first.  There's no limit on rows.  Presentations: Files in .ppt
and .pps formats can have a maximum size of 10MB or 200 slides; files
uploaded from the Web can be up to 2MB; emailed files can be up to 500K.
PDFs: You can store up to 10MB per PDF from your computer and 2MB from
the Web in your Docs list, up to 100 PDFs.  For more details consult the
Google documentation
(\url{http://docs.google.com/support/bin/answer.py?hl=en&answer=37603}).

A package with very similar functionality is maintained by Duncan Temple
Lang at \url{http://www.omegahat.org/RGoogleDocs/}.  The approach taken
there is to use \code{RCurl} and \code{XML} to interact with the lower
level Google HTML protocol.  You should check it out too. 

NOTE:  You will probably need to add to your PATH variable the
location of your JVM (e.g. C:/Program Files/Java/jre6/bin/client).

Only issues that relate directly to the R code should be reported as
bugs.  Patches with bug fixes and improvements are welcome.  For
reference the curent version of the package uses Google Java library
1.40 \url{http://code.google.com/p/gdata-java-client/}. 

}
\details{
\tabular{ll}{
Package: \tab RGoogleData\cr
Type: \tab Package\cr
Version: \tab 0.2.1\cr
Date: \tab 2009-12-31\cr
License: \tab GPL-3\cr
}

}
\author{
Adrian A. Dragulescu

Maintainer: Adrian A. Dragulescu <adrian.dragulescu@gmail.com>

}
\references{
Google Data API: \url{http://code.google.com/apis/gdata/clientlibs.html}
for all the services.  In particular the Docs API:
\url{http://code.google.com/apis/documents/overview.html} and the
Spreadsheets API \url{http://code.google.com/apis/spreadsheets/}.
}
\keyword{ package }
\examples{
\dontrun{

# start the services for Google Docs API and login
# you should use your own login info!
con <- googleConnect(username="rdocsdemo@gmail.com", password="RGooglePass12") 

# get all documents 
docs <- getDocuments(con)

# do a full text search.  Data set iris is there. 
fullTextQuery("virginica")

}
}
