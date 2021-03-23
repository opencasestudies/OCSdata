#' Download Open Case Study Extra Data
#'
#' Download the specified case study extra data to use as you wish.
#'
#' @details This function downloads the Open Case Study extra data
#' from GitHub and saves it in a new 'data/extra/' folder in
#' the specified directory. This makes it so all the extra data
#' are easily available in a local folder for your use.
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
#' ocs-bp-RTC-wrangling (Right-to-Carry Part 1)
#'
#' ocs-bp-RTC-analysis (Right-to-Carry Part 2)
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
#' @param outpath character string, path to the directory where the downloaded
#' data folder should be saved to.
#'
#' @return Nothing useful is returned, a data/extra folder will be downloaded and
#' appear in your directory.
#'
#' @import httr
#' @importFrom purrr map
#' @export
#'
#' @examples load_extra_data('ocs-bp-co2-emissions')
#'
load_extra_data <- function(casestudy, outpath = NULL){
  if (is.null(outpath)) {
    outpath = getwd() # path to working directory
  }
  datapath = file.path(outpath,'data') # path to new data folder directory
  dir.create(datapath) # creating data folder

  extrapath = file.path(datapath,'extra') # path to extra data subfolder
  dir.create(extrapath)

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
      if (grepl('/extra/', fname, fixed = TRUE)) {

        githuburl = paste0('https://github.com/opencasestudies/', casestudy, '/blob/master/',fname,'?raw=true') # github file link

        if (grepl('.csv', fname, fixed = TRUE)) { # if .csv file

          # download the .csv file
          download.file(paste0("https://raw.githubusercontent.com/opencasestudies/",casestudy,"/master/",fname),
                        destfile = file.path(outpath,fname), method = "curl")

        } else if (grepl('.xls', fname, fixed = TRUE)) { # if .xls(x) file

          # download the .xls(x) file
          GET(githuburl, write_disk(file.path(outpath, fname))) # loading file from url and writing to disk

        } else if (grepl('.rda', fname, fixed = TRUE)) { # if .rda file

          # load the r object into the global environment from the .rda file link
          load(url(githuburl), envir = globalenv())

        } else if (grepl('.pdf',fname, fixed = TRUE)) {

          # download the .pdf file
          GET(githuburl, write_disk(file.path(outpath, fname))) # loading file from url and writing to disk

        }
      }
    }
  }
}

