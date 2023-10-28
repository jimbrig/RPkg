#' API Database Hooks
#'
#' @description Utility function to close the database connection when the API is stopped.
#'
#' @param ... Not used
#' @return list
#' @export
#'
#' @importFrom pool poolClose
#' @importFrom DBI dbDisconnect
#' @importFrom pool poolClose
api_database_hooks <- function() {
  list(
    exit = function() {
      if (exists("conn")) {
        if (inherits(conn, "PqConnection")) DBI::dbDisconnect(conn)
        if (inherits(conn, "Pool")) pool::poolClose(conn)
      }
      if (exists("pool")) {
        if (inherits(pool, "Pool")) pool::poolClose(pool)
      }
    }
  )
}
