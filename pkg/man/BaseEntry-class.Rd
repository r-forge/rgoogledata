\name{BaseEntry-class}
\Rdversion{1.1}
\docType{class}
\alias{BaseEntry-class}
\alias{coerce,BaseEntry,list-method}
\alias{coerce,BaseEntry,data.frame-method}
\alias{initialize,BaseEntry-method}

\title{Class "BaseEntry"}
\description{ Base entry of Google Data.  It roughly corresponds to the
  Java class com.google.gdata.data.BaseEntry<E>.  It is an internal
  class, used as a parent to other classes.}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("BaseEntry", listFields, ...)}.
}
\section{Slots}{
	 \describe{
    \item{\code{authors}:}{Object of class \code{"character"}.  The
      author of the entry.}
    \item{\code{canEdit}:}{Object of class \code{"logical"}.  If the
      entry can be edited.}
    \item{\code{id}:}{Object of class \code{"character"}.  The unique id
      of the entry.  Very important. }
    \item{\code{etag}:}{Object of class \code{"character"}.  An unique
      etag.  It is used by Google to keep track of entry versioning.
      Not used by R.}
    \item{\code{published}:}{Object of class \code{"POSIXt"}.  Time
      stamp when entry was published.}
    \item{\code{content}:}{Object of class \code{"character"}.  Empty
      stub with entry content.  Not used yet.}
    \item{\code{title}:}{Object of class \code{"character"}.  Title of
      the entry.}
    \item{\code{con}:}{Object of class \code{"GoogleConnection"}.
      Reference the connection object in order to access the methods.}
  }
}
\section{Methods}{
  \describe{
    \item{coerce}{\code{signature(from = "BaseEntry", to = "list")}: ... }
    \item{coerce}{\code{signature(from = "BaseEntry", to = "data.frame")}: ... }
    \item{initialize}{\code{signature(.Object = "BaseEntry", listFields
	= "list")}.  If listFields is a list with names matching slotNames
        the BaseEntry gets populated with the values.  Should be used
	directly by the user.}
	 }
}
\references{The Google Data Java API \url{http://code.google.com/apis/gdata/javadoc/}.}
\author{Adrian Dragulescu}
\seealso{Child classes \code{\linkS4class{DocumentListEntry}},
  \code{\linkS4class{ListEntry}}, \code{\linkS4class{WorksheetEntry}},
  \code{\linkS4class{TableEntry}}.
}
\keyword{classes}
