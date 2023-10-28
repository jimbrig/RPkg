

require(devtools)
require(usethis)
require(pkgbuild)
require(roxygen2)
require(testthat)
require(knitr)
require(fs)
require(purrr)
require(attachment)
require(papillon)
require(golem)

usethis::create_package(getwd())

usethis::use_git()
usethis::use_namespace()
usethis::use_roxygen_md()
usethis::use_package_doc()
# usethis::use_tibble() # #' @return a [tibble][tibble::tibble-package]
# usethis::use_pipe() # move to propaloc-package.R
# usethis::use_tidy_eval() # move to propalloc-package.R
devtools::document()

attachment::att_amend_desc()
attachment::create_dependencies_file()

# DESCRIPTION -------------------------------------------------------------

desc::desc_set(Title = "Generic Helpers",
               Description = "Generic Helpers for use by R developers.")

# package version
desc::desc_set_version("0.0.1")

#  R version
desc::desc_set("Depends", "R (>= 4.0)")

# license
usethis::use_mit_license("Jimmy Briggs")

# normalize
desc::desc_normalize() # usethis::use_tidy_description()

usethis::use_readme_md()

# Docs --------------------------------------------------------------------

usethis::use_news_md()
usethis::use_pkgdown_github_pages()

# README ------------------------------------------------------------------

# usethis::use_readme_rmd()
usethis::use_logo("inst/assets/rstudio.png")
usethis::use_lifecycle_badge("Experimental")
usethis::use_badge(
  "Project Status: WIP",
  href = "http://www.repostatus.org/#wip",
  src = "https://www.repostatus.org/badges/latest/wip.svg"
)
# knitr::knit("README.Rmd")

# Package Dependencies ----------------------------------------------------

c(
  "dplyr",
  "rlang",
  "tibble",
  "lubridate",
  "purrr",
  "stringr"
) |>
  purrr::walk(usethis::use_package)

usethis::use_dev_package("flipTime", remote = "Displayr/flipTime")

# Functions ---------------------------------------------------------------
usethis::use_testthat()
usethis::use_r("shiny-download_bttn")
usethis::use_test("shiny-download_bttn")
usethis::use_data_raw()
covr::package_coverage()
usethis::use_coverage()
usethis::use_build_ignore("dev")
usethis::use_pkgdown()
usethis::use_github_action("test-coverage")
usethis::use_github_action("pkgdown")
usethis::use_github_action("pr-commands")



# library(covr)
# covr::codecov()

codemeta::write_codemeta()


c(
  "zzz",
  "utils-data",
  "utils-dates",
  "utils-feedback",
  "utils-pipe",
  "utils-strings",
  "utils-tidyeval",
  "meta-package",
  "meta-data",
  "meta-docs",
  "meta-globals",
  "db-config",
  "db-connect",
  "actuary-triangles",
  "actuary-interpolation",
  "actuary-validation",
  "actuary-simulation",
  "actuary-loss_run",
  "actuary-loss_devt",
  "actuary-claim_history",
  "app-ui",
  "app-run",
  "app-config",
  "app-mod_triangles",
  "app-mod_ldf_modal"
) |>
  purrr::walk(usethis::use_r, open = FALSE)

usethis::use_r("simulate_claims")

# Tests -------------------------------------------------------------------

usethis::use_testthat()

c(
  "date-utils",
  "data-utils",
  "actuary-triangle",
  "actuary-validation",
  "actuary-loss_run",
  "actuary-simulate_claims"
) |>
  purrr::walk(usethis::use_test)

# Vignettes ---------------------------------------------------------------

usethis::use_vignette("A-actuarial-loss-reserving-overview",
                      "Actuarial Loss Reserving Overview")

usethis::use_vignette("A-actuarial-loss-reserving-overview",
                      "Actuarial Loss Reserving Overview")

usethis::use_vignette("Lossruns-and-Triangles",
                      "Lossruns and Triangles")

usethis::use_vignette(
  "Data-Overview"
)



# Data --------------------------------------------------------------------

usethis::use_data_raw("claims")
usethis::use_r("data-claims")

usethis::use_data_raw("claims_transactional")


usethis::use_test("loss_run")
usethis::use_test("interp")
