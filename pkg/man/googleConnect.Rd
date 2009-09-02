\name{googleConnect}
\alias{googleConnect}
\title{ GoogleConnect to Google Docs from R }
\description{
Login to Google Data from R.  It starts the RInterface between R and
Google.   
}
\usage{
googleConnect(username, password)
}
\arguments{
  \item{username}{ The gmail email address of the user.  How you login
    to Google web site.}
  \item{password}{ The password.}
}
\details{
  Returns an object of class 'GoogleConnection' which contains the external
  reference to the Java object that represents
  the connection.  This connection will be used in all API calls.
}
\value{
An \code{RInterface} object.  Contains only one field that
hold the Java reference pointing to the RInterface object. 
}
\author{ Adrian Dragulescu }
\note{
The service should remain connected.  In case of a disconnect, please
connect again. 
}
\examples{
\dontrun{

# start the services for Google Docs API and login
# you should use your own login info!
RInt <- googleConnect(username="rdocsdemo@gmail.com", password="RGooglePass12") 

}
}
\keyword{ utilities }
