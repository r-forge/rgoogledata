\name{fullTextQuery}
\alias{fullTextQuery}
\title{ Do a full text query on your documents. }
\description{
Do a full text query on your documents.
}
\usage{

fullTextQuery(con, query)

}
\arguments{
  \item{con}{ An RInterface object as returned by \code{login}.}
  \item{query}{ A character string to look for in the documents.}
}
\details{
  The match is case insensitive.  The match is done on the entire
  query, not on substrings of the query.  Regexp are not supported.  
}
\value{
  Returns a character vector of documents that contain the query. 
}
\author{ Adrian Dragulescu }
\seealso{\code{\link{googleConnect}} and \code{\link{Documents}}}
\examples{
\dontrun{

# you should already have an GoogleConnection object!

# if you have a document called "iris" with the iris data set ... 
fullTextQuery(con, "virginica")
# will return "iris" 


fullTextQuery(con, "vir")
# will return empty

}
}

