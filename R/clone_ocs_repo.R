#' Internal Function
#'
#' This is not to be used directly by the users.
#'
#' @export
#' @importFrom usethis create_from_github
#' @keywords internal
#'
clone_ocs_repo <- function(casestudy, outpath=NULL,fork_repo=NA){
  if (is.null(outpath)) {
    outpath = getwd()
  }
    create_from_github(paste0('opencasestudies/',casestudy), destdir = outpath,
                       fork = fork_repo, open = FALSE)
}
