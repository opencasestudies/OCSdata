#' Load CO2 Emissions Repository
#'
#' Download the CO2 Emissions case study repository and save it as a new R project in a local directory.
#' Need to have a personal access token (PAT) to work.
#'
#' @details This function downloads the OCS CO2 emissions case study repository
#' on GitHub and saves it as a new R project in a local directory. This makes
#' it so all of the raw and wrangled data is downloaded using one function.
#' Need to have a personal access token (PAT) to work.
#'
#' @param outpath character string, path to the directory where the downloaded
#' repository should be saved to.
#' @param fork_repo logical, FALSE will clone the repo, while TRUE will fork the repo and then clone the fork.
#' Default is NA, which will check if you are allowed to push to the repository or not. If you can, the repo
#' will be cloned. If you cannot push, the repo will be forked and cloned.
#'
#' @return nothing useful is returned, a new R project will be loaded in the
#' directory specified in outpath.
#'
#' @import usethis
#' @export
#'
#' @examples load_co2_repo('/Users/michael/Desktop/',TRUE)
#'
load_co2_repo <- function(outpath=NULL,fork_repo=NA){
  if (is.null(outpath)) {
    create_from_github('opencasestudies/ocs-bp-co2-emissions', fork = fork_repo)
  } else {
    create_from_github('opencasestudies/ocs-bp-co2-emissions', destdir = outpath, fork = fork_repo)
  }

}
