# Helper Functions
# ------------------------------------------------------------------------
# returns the number of column names containing a substring
ncol_with_name <- function(data_stack, substring) {
  data_stack %>%
    tibble::as_tibble() %>%
    dplyr::select(dplyr::contains(!!substring)) %>%
    ncol()
}

# copied from utils
check_inherits <- function(x, what) {
  cl <- match.call()
  
  if (!inherits(x, what)) {
    glue_stop("Element `{list(cl$x)}` needs to inherit from `{what}`, but its ",
              "class is `{list(class(x))}`.")
  }
  
  invisible(TRUE)
}

# Helper Data 
# -----------------------------------------------------------------------
# the `helper_data.Rda` contains data objects for use in unit testing.
# due to its size, it's not included in the built package.
# * when running locally, use the local helper_data. 
# * when testing on github, download the hard-linked file from the relevant branch.
# * when on cran, only run the tests in test_cran that don't require the data.

get_current_branch <- function() {
  gh_ref <- Sys.getenv("GITHUB_REF")
  
  if (!identical(gh_ref, "")) {
    gsub("refs/heads/", "", gh_ref)
  } else {
    NA
  }
}

on_github <- function() {
  !is.na(get_current_branch())
}

on_cran <- function() {
  !identical(Sys.getenv("NOT_CRAN"), "true")
}

dl_mode <- if (identical(.Platform$OS.type, "windows")) {"wb"} else {"w"}

if (on_github()) {
  download.file(
    paste0(
      "https://github.com/tidymodels/stacks/blob/", 
      get_current_branch(), 
      "/tests/testthat/helper_data.Rda?raw=true"
    ),
    destfile = paste0(test_path(), "/helper_data.Rda"),
    mode = dl_mode
  )
}
