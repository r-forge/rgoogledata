\name{getMsg}
\alias{getMsg}
\alias{clearMsg}
\title{ Get and clear messages from the RGoogle interface. }
\description{
Functions to get and clear internal messages from the RGoogle interface. 
}
\usage{

getMsg(con)

clearMsg(con)

}
\arguments{
  \item{con}{ An object of class 'GoogleConnection' as returned by
    \code{\link{googleConnect}}.}
}

\details{
  
  On the Java side of the RGoogle interface, there is an instance
  variable of string type that is used for logging error messages or
  sometimes even content.

  In case your command does not behave the way you think it should, you
  can use the 'getMsg' function to retrieve the possible error message
  on the Java side.  This may provide you with insight on your error.

  'clearMsg' resets the Java variable to an empty string.  In normal
  use, it should not be necessary to use this function. 
}
\value{
  'getMsg' returns a character string.  If there is no exceptional
  condition on the Java side, it will return "".
  
  'clearMsg' returns nothing.
}
\author{Adrian Dragulescu}

