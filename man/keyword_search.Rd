\name{keyword_search}
\alias{keyword_search}
\title{Real-time Search for Petitions Based on a Keyword}
\description{
  This function performs a real-time search for petitions on the Local Leader Message Board (LLMB, see \link[=https://liuyan.people.com.cn/]{https://liuyan.people.com.cn/}) using the specified keyword. It creates a JavaScript environment in R using the V8 engine to reverse-engineer the search process.
}
\usage{
keyword_search(keywords = "your keywords", page = 1, rows = 20, format = "tibble", sleep = sample(seq(1, 2, 0.05), 1))
}
\arguments{
  \item{keywords}{A character string specifying the keyword for the search. It should be provided in Chinese.}
  \item{page}{A numeric value indicating the page number to access, with the default set to 1.}
  \item{rows}{A numeric value specifying the number of results per page. The default is set to 20.}
  \item{format}{A character string that defines the output format. The default is "tibble". Available formats include "JSON", "tibble", and "string".}
  \item{sleep}{A numeric value that sets the sleep time in seconds to prevent overloading the server. By default, it is a random value between 1 and 2 seconds.}
}
\details{
  This function leverages the V8 JavaScript engine to simulate a browser environment, allowing for dynamic web content interaction within R. It is designed to fetch data seamlessly from the LLMB website by simulating real user search queries.
}
\examples{
keyword_search(
  keywords = "上访",
  page = 2,
  rows = 10,
  format = "tibble"
)
}
\seealso{
  \link{https://www.npmjs.com/package/crypto-js}, for other related functions.
}
\author{
  Xinzhuo HUANG
}
