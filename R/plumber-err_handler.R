#' Plumber API Error Handler
#'
#' @description Utility function to handle errors in the API.
#'
#' @param req Plumber request object
#' @param res Plumber response object
#' @param err Error object
#' @param ... Not used
#'
#' @return function
#'
#' @export
#'
#' @importFrom utils str
api_err_handler <- function(req, res, err, ...) {
  function(req, res, err) {
    message("Found error: ")
    utils::str(err)
  }
}
