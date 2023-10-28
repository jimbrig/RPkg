# No Remotes ----
# Attachments ----
to_install <- c("DBI", "fs", "glue", "jsonlite", "plumber", "pool", "sessioninfo", "stringr", "tibble")
  for (i in to_install) {
    message(paste("looking for ", i))
    if (!requireNamespace(i, quietly = TRUE)) {
      message(paste("     installing", i))
      install.packages(i)
    }
  }

