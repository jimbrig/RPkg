test_that("download_bttn works", {

  res <- download_bttn("download", "Download", "csv")

  expect_equal(
    res,
    glue::glue(
      '<a id="download" class="btn btn-default shiny-download-link" href="" target="_blank" download>
        <i class="far fa-file-csv" role="presentation" aria-label="file-csv icon"></i>
      </a>'
    )
  )

})
