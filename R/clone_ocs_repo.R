#' Clone Case Study Repository
#'
#' Clone the specified case study repository and save it as a new R project in a local directory.
#' Need to have a personal access token (PAT) registered to work.
#'
#' @details This function clones the specified OCS case study repository
#' from GitHub and saves it as a new R project in a local directory. This makes
#' it so the case study repository, including all of the code, data, and document
#' files, are cloned in git and downloaded with a single function.
#' Need to have a personal access token (PAT) to work.
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
#' repository should be saved to. If NULL, the repo will be saved to your working directory.
#'
#' @param fork_repo logical, FALSE will clone the repo, while TRUE will fork the repo and then clone the fork.
#' Default is NA, which will check if you are allowed to push to the repository or not. If you can, the repo
#' will be cloned. If you cannot push, the repo will be forked and cloned.
#'
#' @return nothing useful is returned, a new R project will be saved to the
#' directory specified in the parameter called outpath.
#'
#' @importFrom usethis create_from_github
#' @export
#'
#' @examples clone_ocs_repo('ocs-bp-co2-emissions', fork_repo = TRUE)
#'
clone_ocs_repo <- function(casestudy, outpath=NULL,fork_repo=NA){
  if (is.null(outpath)) {
    outpath = getwd()
  }
    create_from_github(paste0('opencasestudies/',casestudy), destdir = outpath,
                       fork = fork_repo)
}
