#' Create a UTC Timestamp
#'
#' @param time POSIXct, POSIXlt, Date, chron date-time object
#'
#' @return a POSIXct object in the updated time zone
#' @export
#' @importFrom lubridate with_tz
time_now_utc <- function() {
  lubridate::with_tz(Sys.time(), tzone = "UTC")
}
