\name{GoogleConnection-class}
\Rdversion{1.1}
\docType{class}
\alias{GoogleConnection-class}
\alias{getDocuments,GoogleConnection-method}
\alias{getFolders,GoogleConnection-method}
\alias{getPresentations,GoogleConnection-method}
\alias{getSpreadsheets,GoogleConnection-method}
\alias{initialize,GoogleConnection-method}
\alias{show,GoogleConnection-method}

\title{Class "GoogleConnection"}
\description{Keep the user related info needed to login to Google.}
\section{Objects from the Class}{
Objects can be created by calls of the form
\code{new("GoogleConnection", login, password)}.  One connection should be
  enough per session.  
}
\section{Slots}{
	 \describe{
    \item{\code{login}:}{Object of class \code{"character"} with user login.}
    \item{\code{password}:}{Object of class \code{"character"} with user
      password.}
    \item{\code{ref}:}{Object of class \code{"jobjRef"}.  The reference
      to the Java interface.}
  }
}
\section{Methods}{
  \describe{
    \item{getDocuments}{\code{signature(con = "GoogleConnection")}: ... }
    \item{getFolders}{\code{signature(con = "GoogleConnection")}: ... }
    \item{getPresentations}{\code{signature(con = "GoogleConnection")}: ... }
    \item{getSpreadsheets}{\code{signature(con = "GoogleConnection")}: ... }
    \item{initialize}{\code{signature(.Object = "GoogleConnection")}: ... }
    \item{show}{\code{signature(object = "GoogleConnection")}: ... }
	 }
}
\author{Adrian Dragulescu}


\seealso{
  \code{\linkS4class{DocumentListEntry}} for classes representing the documents.
}
\examples{
showClass("GoogleConnection")

username <- "rdocsdemo@gmail.com"
password <- "RGooglePass12"
con <- googleConnect(username, password)

}
\keyword{classes}
