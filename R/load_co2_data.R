#' Download CO2 Emissions Data
#'
#' Download the CO2 Emissions case study data into a new folder in your current working directory.
#'
#' @details This function downloads the OCS CO2 emissions case study data
#' from GitHub and saves it in a new '/data' folder in your current working directory. This makes
#' it so all of the relevant data needed to follow along the lesson is easily available in a local folder.
#'
#' @param outpath character string, path to the directory where the downloaded
#' data folder should be saved to.
#'
#' @return nothing useful is returned, a new data folder will be downloaded
#'
#' @export
#'
#' @examples load_co2_data('/Users/michael/Desktop/')
#'
load_co2_data <- function(outpath=NULL){
  if (is.null(outpath)) {
    wdpath = getwd() # path to working directory
    datapath = file.path(wdpath,'data') # path to new data folder directory
    dir.create(datapath)

  } else {
    datapath = file.path(outpath,'data') # path to new data folder in outpath directory
    dir.create(datapath)
  }
  download.file("https://raw.githubusercontent.com/opencasestudies/ocs-bp-co2-emissions/master/data/disasters.csv",
                destfile = file.path(datapath,'disasters.csv'), method = "curl")
  download.file("https://raw.githubusercontent.com/opencasestudies/ocs-bp-co2-emissions/master/data/mortality.csv",
                destfile = file.path(datapath,'mortality.csv'), method = "curl")
  download.file("https://raw.githubusercontent.com/opencasestudies/ocs-bp-co2-emissions/master/data/temperature.csv",
                destfile = file.path(datapath,'temperature.csv'), method = "curl")
}
