% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shiny-download_bttn.R
\name{download_bttn}
\alias{download_bttn}
\title{Download Button}
\usage{
download_bttn(
  outputId,
  label = NULL,
  icon = c("download", "export", "import", "image", "excel", "pdf", "word", "text",
    "csv", "zip", "code", "powerpoint", "lines", "audio", "video", "admin"),
  ...
)
}
\arguments{
\item{outputId}{The output slot that will be used to access the value.}

\item{label}{The contents of the button.}

\item{icon}{The icon to be used. Possible values are: "download", "export", "import", "image", "excel", "pdf", "word",
"text", "csv", "zip", "code", "powerpoint", "lines", "audio", "video", "admin".}

\item{...}{Future parameters to be passed to \code{\link[shiny:downloadButton]{shiny::downloadButton()}}.}
}
\value{
HTML
}
\description{
This function alters the default \code{\link[shiny:downloadButton]{shiny::downloadButton()}} to include a Font Awesome icon corresponding to the file
type being downloaded.
}
\examples{
download_bttn("download", "Download", "csv")

}
\seealso{
\code{\link[shiny:downloadButton]{shiny::downloadButton()}} and \code{\link[shiny:icon]{shiny::icon()}}
}
