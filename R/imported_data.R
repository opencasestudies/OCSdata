#' Download Open Case Study Imported Data
#'
#' Download the specified case study imported data to use as you follow along the case study.
#'
#' @details This function downloads the Open Case Study imported data
#' from GitHub and saves it in a new 'OCSdata/data/imported/' folder in
#' the specified directory. This makes it so all the imported data
#' are easily available in a local folder.
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
#' @param outpath character string, path to the directory where the downloaded
#' data folder should be saved to.
#'
#' @return If download is successful, the path to the downloaded data folder is
#' returned. Otherwise the appropriate error message is returned.
#'
#' @importFrom httr GET write_disk
#' @importFrom purrr map
#' @export
#'
#' @examples imported_data('ocs-bp-opioid-rural-urban', outpath = tempfile())
#'
imported_data <- function(casestudy, outpath = NULL){

  # check outpath input
  if (is.null(outpath)) {
    if (interactive()){
      wd = getwd()
      cat(paste("No destination directory specified. Would you like to save the",
                "data files to your current working directory?\n"))
      cat(paste("Current working directory:\n", wd, "\n"))
      cat(paste("Responses:", "1. Yes, save to my current working directory.",
                "2. Specify a different directory", "3. Cancel ", sep = "\n"))
      response = readline(prompt = "Answer with a number 1-3: ")

      if (response == '1'){
        outpath = wd # path to working directory

      } else if (response == '2'){
        cat(paste("Enter the file path of the desired directory\n"))
        outpath = readline(prompt = "File path: ")

      } else {
        return("Canceled.")
      }

    } else{ # if not interactive
      msg = paste("Error: No destination directory specified. Please enter the file path for where the data files should be downloaded in the 'outpath' argument.")
      return(msg)
    }
  }

  if (dir.exists(outpath)) {
    outpath = file.path(outpath,'OCS_data') # creating new clean directory
    dir.create(outpath, showWarnings = FALSE)

    datapath = file.path(outpath,'data') # path to new data folder directory
    dir.create(datapath, showWarnings = FALSE) # creating data folder

    importpath = file.path(datapath,'imported') # path to imported data subfolder
    dir.create(importpath, showWarnings = FALSE)

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
        if (grepl('/imported/', fname, fixed = TRUE)) { # if in imported
          if (grepl('.', fname, fixed = TRUE)) { # if a file name

            githuburl = paste0('https://github.com/opencasestudies/', casestudy, '/blob/master/',fname,'?raw=true') # github file link

            # download the file
            GET(githuburl, write_disk(file.path(outpath, fname))) # loading file from url and writing to disk

          } else { # if a directory name
            # create sub-folder
            subpath = file.path(outpath, fname)
            dir.create(subpath)

          }
        }
      }
    }
    return(cat(paste("The downloaded files are in:", importpath)))

  } else {
    return("The specified directory does not exist.")
  }
}
