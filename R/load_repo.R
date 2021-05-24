#' Download Case Study Repository Folder
#'
#' Download the specified case study repository and save it as a new folder
#' and R project in a local directory.
#'
#'
#' @details This function downloads the specified OCS case study repository
#' from GitHub as a zip file. The function unzips the folder and saves it as
#' a new R project in a local directory. This makes it so the case study
#' repository, including all of the code, data, and document files, are downloaded
#' with a single function.
#'
#'
#' @param casestudy character string, name of the case study to download repository folder from.
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
#' repository should be saved to. If NULL, the default, the repo will be saved
#' to your working directory.
#'
#' @return nothing useful is returned, a new folder will be saved to the
#' directory specified in the parameter called outpath.
#'
#' @importFrom usethis use_zip
#' @export
#'
#' @examples load_repo('ocs-bp-co2-emissions')
#'
load_repo <- function(casestudy, outpath=NULL){
  if (is.null(outpath)) {
    outpath = getwd()
  }
  use_zip(paste0('opencasestudies/',casestudy), destdir = outpath,
                     cleanup = TRUE)
}
