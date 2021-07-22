#' Internal Function
#'
#' This is not to be used directly by the users.
#'
#' @export
#' @importFrom usethis use_zip
#' @keywords internal
#'
load_repo <- function(casestudy, outpath=NULL){
  if (is.null(outpath)) {
    outpath = getwd()
  }
  use_zip(paste0('opencasestudies/',casestudy), destdir = outpath,
                     cleanup = TRUE)
}
