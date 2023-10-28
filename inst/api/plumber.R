library(plumber)

#* @apiTitle Plumber API
#* @apiDescription Plumber API for the RPkg package
#* @apiVersion 0.0.1

#* @get /ping
RPkg::api_ping

#* @get /version
RPkg::api_version

#* @get /sessioninfo
RPkg::api_sessioninfo
