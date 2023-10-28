#' @title Ping the Plumber API
#'
#' @description Utility function used to perform an API healthcheck.
#'
#' @param req Plumber request object
#' @param res Plumber response object
#'
#' @return plumber response
#' @export
api_ping <- function(req, res) {

  list(
    `API Status` = "OK"
  )

}

#' @title Request the API Package's Version
#'
#' @description Utility function to retrieve the version of the API.
#'
#' @param req Plumber request object
#' @param res Plumber response object
#'
#' @return plumber response
#' @export
#'
#' @importFrom utils packageVersion
api_version <- function(req, res) {
  list(
    "R Package Version:" = as.character(utils::packageVersion("RPkg")),
    "API version" = get_api_version()
  )
}

#' Get API Version
#'
#' @description Utility function to retrieve the version of the API from the plumber `#* @apiVersion` roxygen tag.
#'
#' @param ... Not used
#'
#' @return character
#' @export
#' @importFrom fs path_package
#' @importFrom stringr str_extract regex
get_api_version <- function(...) {
  readLines(
    fs::path_package("RPkg", "api/plumber.R")
  ) |>
  stringr::str_extract(
    stringr::regex("[:digit:].[:digit:].[:digit:]")
  ) |>
  setdiff(c(NULL, NA))
}
