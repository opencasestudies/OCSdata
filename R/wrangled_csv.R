#' Download Open Case Study Wrangled Data - CSVs
#'
#' Download the specified case study wrangled data to use as you follow along the case study.
#'
#' @details This function downloads the Open Case Study wrangled data from GitHub
#' and saves it in a new 'OCSdata/data/wrangled/' folder in
#' the specified directory. This makes it so all the wrangled data
#' are easily available in a local folder. The data will be in .csv format.
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
#' printed and the logical value TRUE is returned. Otherwise the appropriate error message is printed.
#'
#' @importFrom httr GET write_disk content
#' @importFrom purrr map
#' @export
#'
#' @examples
#' tmp = tempfile()
#' dir.create(tmp)
#' wrangled_csv('ocs-bp-opioid-rural-urban', outpath = tmp)
#'
wrangled_csv <- function(casestudy, outpath = NULL){
  repo_names = c("ocs-bp-rural-and-urban-obesity", "ocs-bp-air-pollution",
                 "ocs-bp-vaping-case-study", "ocs-bp-opioid-rural-urban",
                 "ocs-bp-RTC-wrangling", "ocs-bp-RTC-analysis",
                 "ocs-bp-youth-disconnection", "ocs-bp-youth-mental-health",
                 "ocs-bp-school-shootings-dashboard", "ocs-bp-co2-emissions",
                 "ocs-bp-diet")
  if (casestudy %in% repo_names){
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

      wrangledpath = file.path(datapath,'wrangled') # path to wrangled data subfolder
      dir.create(wrangledpath, showWarnings = FALSE)

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
          if (grepl('/wrangled/', fname, fixed = TRUE)) { # if in wrangled
            if (grepl('.', fname, fixed = TRUE)) { # if a file name
              if (grepl('.csv',fname, fixed = TRUE)) { # if .csv
                # github file url
                githuburl = paste0('https://github.com/opencasestudies/', casestudy, '/blob/master/',fname,'?raw=true')
                # download the file
                GET(githuburl, write_disk(file.path(outpath, fname))) # loading file from url and writing to disk
              }
            } else { # if a directory name
              # create sub-folder
              subpath = file.path(outpath, fname)
              dir.create(subpath)

            }
          }
        }
      }
      cat(paste("The downloaded files are in:", wrangledpath, " "))
      return(TRUE)

    } else {
      return("The specified directory does not exist.")
    }
  } else {
    return(cat(paste("Not a valid case study name. Please use the name of the case study \nGitHub repository.",
                     "Use ?wrangled_data to view a list of valid names.")))
  }
}
