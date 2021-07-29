#' Download Case Study Repository Zip File
#'
#' Download the specified case study repository zip file and unzip it to a local directory.
#'
#' @details This function downloads the specified OCS case study repository
#' from GitHub as a zip file. The function unzips the folder and saves it as
#' a new R project in a local directory. This makes it so the case study
#' repository, including all of the code, data, and document files, are downloaded
#' with a single function. Wrapper for the use_zip function from usethis.
#'
#'
#' @param casestudy character string, name of the case study to download zip file from.
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
#' data folder should be saved.
#'
#' @return If download is successful, the path to the downloaded data folder is
#' returned. Otherwise the appropriate error message is returned.
#'
#' @importFrom usethis use_zip
#' @export
#'
#' @examples
#' zip_ocs('ocs-bp-co2-emissions', outpath = tempfile())
#'
zip_ocs <- function(casestudy, outpath=NULL){
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

    if (dir.exists(outpath)){
      use_zip(paste0('opencasestudies/',casestudy), destdir = outpath,
              cleanup = TRUE)
      return(cat(paste("The downloaded repository is in:", outpath)))
    } else {
      return("The specified directory does not exist.")
    }
  } else {
    return(cat(paste("Not a valid case study name. Please use the name of the case study \nGitHub repository.",
                     "Use ?zip_ocs to view a list of valid names.")))
  }
}
