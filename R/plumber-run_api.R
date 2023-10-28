#' Run the Plumber API
#'
#' @param .host Host - defaults to "0.0.0.0" (localhost)
#' @param .port Post - defaults to 8080
#' @inheritDotParams plumber::pr_run
#'
#' @return Plumber API
#' @export
#'
#' @importFrom fs path_package
#' @importFrom plumber plumb
run_api <- function(.host = "0.0.0.0", .port = 8080, ...) {

  pr <- plumber::plumb(dir = fs::path_package("RPkg", "api"))
  hooks <- api_database_hooks()
  error_handler <- api_err_handler()
  pr$registerHooks(hooks)
  pr$setErrorHandler(error_handler)
  pr$run(host = .host, port = .port, ...)

}


run_api.docker <- function(...) {

}

run_api.callr <- function(...) {

}

run_api.job <- function(...) {

}
