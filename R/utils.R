download_bttn <- function(
  outputId,
  label = NULL,
  icon = c("download", "export", "import", "image", "excel", "pdf", "word", "text", "csv", "zip", "code", "powerpoint", "lines", "audio", "video", "admin"),
  ..
) {

  icon <- match.arg(icon)

  glue::glue(
    '<a id="{outputId}" class="btn btn-default shiny-download-link" href="" target="_blank" download>
      <i class="far fa-file-{icon}" role="presentation" aria-label="file-{icon} icon"></i>
    </a>'
  )

}
