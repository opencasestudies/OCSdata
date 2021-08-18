#' Clone Case Study Repository
#'
#' Clone the specified case study repository and save it as a new R project in a local directory.
#' Need to have a personal access token (PAT) registered to work.
#'
#' @details This function clones the specified OCS case study repository
#' from GitHub and saves it as a new R project in a new folder in
#' the specified directory. This makes
#' it so the case study repository, including all of the code, data, and document
#' files, are cloned with git and downloaded in a single function.
#' Need to have a personal access token (PAT) to work.
#' Wrapper for the create_from_github function from usethis.
#'
#' @param casestudy character string, name of the case study to clone repository from.
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
#' repository folder should be saved to.
#'
#' @param fork_repo logical, FALSE will clone the repo, while TRUE will fork the repo and then clone the fork.
#' Default is NA, which will check if you are allowed to push to the repository or not. If you can, the repo
#' will be cloned. If you cannot push, the repo will be forked and cloned.
#'
#' @return If download is successful, the path to the downloaded data folder is
#' printed and the logical value TRUE is returned. Otherwise the appropriate error message is printed.
#'
#' @importFrom usethis create_from_github
#' @export
#'
#' @examples
#' \dontrun{
#' tmp = tempfile()
#' dir.create(tmp)
#' clone_ocs("ocs-bp-co2-emissions", outpath = tmp)
#' }
clone_ocs <- function(casestudy, outpath=NULL,fork_repo=NA){
  repo_names = c("ocs-bp-rural-and-urban-obesity", "ocs-bp-air-pollution",
                 "ocs-bp-vaping-case-study", "ocs-bp-opioid-rural-urban",
                 "ocs-bp-RTC-wrangling", "ocs-bp-RTC-analysis",
                 "ocs-bp-youth-disconnection", "ocs-bp-youth-mental-health",
                 "ocs-bp-school-shootings-dashboard", "ocs-bp-co2-emissions",
                 "ocs-bp-diet")
  if (casestudy %in% repo_names){
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
      create_from_github(paste0('opencasestudies/',casestudy), destdir = outpath,
                         fork = fork_repo, open = FALSE)

      cat(paste("The downloaded repository is in:", outpath, " "))
      return(TRUE)

    } else {
      return("The specified directory does not exist.")
    }
  } else {
    return(cat(paste("Not a valid case study name. Please use the name of the case study \nGitHub repository.",
                     "Use ?clone_ocs to view a list of valid names.")))
  }
}
