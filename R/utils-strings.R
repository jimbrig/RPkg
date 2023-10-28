#' Encrypt String
#'
#' @param string string
#' @param secret_key secret
#'
#' @return encrypted string
#' @export
#'
#' @importFrom safer encrypt_string
#' @importFrom urltools url_encode
encrypt_string <- function(string, secret_key = NA) {

  time <- time_now_utc()
  if (is.na(secret_key)) secret_key <- get_config("api")$secretkey
  hold <- paste(time, string, sep = ";")
  urltools::url_encode(safer::encrypt_string(hold, key = secret_key))

}
