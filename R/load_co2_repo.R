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
#'
#' @return nothing useful is returned, a new R project will be loaded in the
#' directory specified in outpath.
#'
#' @import usethis
#' @export
#'
#' @examples load_co2_repo('/Users/michael/Desktop/')
#'
load_co2_repo <- function(outpath=NULL){
  if (is.null(outpath)) {
    create_from_github('opencasestudies/ocs-bp-co2-emissions')
  } else {
    create_from_github('opencasestudies/ocs-bp-co2-emissions',destdir=outpath)
  }

}
