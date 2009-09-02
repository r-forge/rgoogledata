\name{DocumentListEntry-class}
\Rdversion{1.1}
\docType{class}
\alias{DocumentListEntry-class}
\alias{coerce,DocumentListEntry,list-method}
\alias{coerce,DocumentListEntry,data.frame-method}
\alias{initialize,DocumentListEntry-method}

\title{Class "DocumentListEntry"}
\description{A class that contains different document objects.  It roughly corresponds to the
  Java class com.google.gdata.data.docs.DocumentListEntry.  It is an internal
  class, used as a parent to other classes.  It inherits from BaseEntry.}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("DocumentListEntry", listFields, ...)}.
}
\section{Slots}{
  Other slots not inherited from BaseEntry.
	 \describe{
    \item{\code{htmlLink}:}{Object of class \code{"character"}.  The
      html link to the document that can be used in a browser.}
    \item{\code{lastModifiedBy}:}{Object of class \code{"character"}.}
    \item{\code{lastUpdated}:}{Object of class \code{"POSIXt"}.  Time
      stamp.}
    \item{\code{lastViewed}:}{Object of class \code{"POSIXt"}.  Time
      stamp.}
    \item{\code{isHidden}:}{Object of class \code{"logical"}.}
    \item{\code{isStarred}:}{Object of class \code{"logical"}.}
    \item{\code{isTrashed}:}{Object of class \code{"logical"}.}
    \item{\code{isViewed}:}{Object of class \code{"logical"}.}
    \item{\code{isWritersCanInvite}:}{Object of class \code{"logical"}.}
    \item{\code{folder}:}{Object of class \code{"character"}.  Parent folder.}
    \item{\code{key}:}{Object of class \code{"character"}.  Internal
      unique key.}
  }
}
\section{Methods}{
  \describe{
    \item{coerce}{\code{signature(from = "DocumentListEntry", to = "list")}: ... }
    \item{coerce}{\code{signature(from = "DocumentListEntry", to = "data.frame")}: ... }
    \item{initialize}{\code{signature(.Object = "DocumentListEntry", listFields
	= "list")}.  If listFields is a list with names matching slotNames
        the DocumentListEntry gets populated with the values.  Should be used
	directly by the user.}
	 }
}
\references{The Google Data Java API \url{http://code.google.com/apis/gdata/javadoc/}.}
\author{Adrian Dragulescu}
\seealso{Parent class \code{\linkS4class{BaseEntry}} and the child classes 
  \code{\linkS4class{DocumentEntry}}, \code{\linkS4class{SpreadsheetEntry}},
  \code{\linkS4class{PresentationEntry}},
  \code{\linkS4class{FolderEntry}}.  See also
  \code{\link{getDocuments}}. 
}
\keyword{classes}
