#' Download Open Case Study Imported Data
#'
#' Load the specified case study imported data into your global environment
#' to use as you follow along the case study.
#'
#' @details This function downloads the Open Case Study imported data
#' from GitHub and loads it into your global environment as variables.
#' This makes it so all the imported data are immediately available to be wrangled and analzed.
#'
#' @param casestudy character string, name of the case study to pull data from.
#' The input name should follow the same naming scheme as the repository on GitHub:
#'
#' ocs-bp-rural-and-urban-obesity
#'
#' ocs-bp-air-pollution
#'
#' ocs-bp-vaping-case-study
#'
#' ocs-bp-opioid-rural-urban
#'
#' ocs-bp-RTC-wrangling
#'
#' ocs-bp-RTC-analysis
#'
#' ocs-bp-youth-disconnection
#'
#' ocs-bp-youth-mental-health
#'
#' ocs-bp-school-shootings-dashboard
#'
#' ocs-bp-co2-emissions
#'
#' ocs-bp-diet
#'
#' @return Nothing useful is returned, R objects will be loaded into the global environment.
#'
#' @import httr
#' @importFrom purrr map
#' @export
#'
#' @examples load_imported_data('ocs-bp-co2-emissions')
#'
load_imported_data <- function(casestudy){

  # getting repo webpage data
  repo_url = paste0("https://api.github.com/repos/opencasestudies/",
                    casestudy, "/git/trees/master?recursive=1") # creating repo url string
  repo = GET(url=repo_url)
  repocont = content(repo)
  repounlist = unlist(repocont, recursive = FALSE)
  paths = map(repounlist,'path') # creating list of just the file paths in the repo
  paths = paths[!sapply(paths,is.null)] # removing null values

  for (fname in paths){
    if (grepl('data/', fname, fixed = TRUE)) { # if file is in the data directory
      if (grepl('/imported/', fname, fixed = TRUE)) {

        githuburl = paste0('https://github.com/opencasestudies/', casestudy, '/blob/master/',fname,'?raw=true') # github file link

        if (grepl('.rda', fname, fixed = TRUE)) { # if .rda file

          # load the r object into the global environment from the .rda file link
          load(url(githuburl), envir = globalenv())
        }
      }
    }
  }
}

