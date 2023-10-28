#' Download Button
#'
#' @description
#' This function alters the default [shiny::downloadButton()] to include a Font Awesome icon corresponding to the file
#' type being downloaded.
#'
#' @param outputId The output slot that will be used to access the value.
#' @param label The contents of the button.
#' @param icon The icon to be used. Possible values are: "download", "export", "import", "image", "excel", "pdf", "word",
#' "text", "csv", "zip", "code", "powerpoint", "lines", "audio", "video", "admin".
#' @param ... Future parameters to be passed to [shiny::downloadButton()].
#'
#' @return HTML
#'
#' @examples
#' download_bttn("download", "Download", "csv")
#'
#' @export
#'
#' @seealso [shiny::downloadButton()] and [shiny::icon()]
#' @importFrom glue glue
download_bttn <- function(
  outputId,
  label = NULL,
  icon = c("download", "export", "import", "image", "excel", "pdf", "word", "text", "csv", "zip", "code",
           "powerpoint", "lines", "audio", "video", "admin"),
  ...
) {

  icon <- match.arg(icon)

  glue::glue(
    '<a id="{outputId}" class="btn btn-default shiny-download-link" href="" target="_blank" download>
      <i class="far fa-file-{icon}" role="presentation" aria-label="file-{icon} icon"></i>
    </a>'
  )

}
