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
#' @import httr
#' @importFrom readxl read_excel
#' @importFrom xlsx write.xlsx
#' @importFrom here here
#' @export
#'
#' @examples load_co2_data('/Users/michael/Desktop/')
#'
load_co2_data <- function(outpath=NULL){
  if (is.null(outpath)) {
    wdpath = getwd() # path to working directory
    datapath = file.path(wdpath,'data') # path to new data folder directory
  } else {
    datapath = file.path(outpath,'data') # path to new data folder in outpath directory
  }

  dir.create(datapath) # creating data folder
  # downloading .csv files
  download.file("https://raw.githubusercontent.com/opencasestudies/ocs-bp-co2-emissions/master/data/disasters.csv",
                destfile = file.path(datapath,'disasters.csv'), method = "curl")
  download.file("https://raw.githubusercontent.com/opencasestudies/ocs-bp-co2-emissions/master/data/mortality.csv",
                destfile = file.path(datapath,'mortality.csv'), method = "curl")
  download.file("https://raw.githubusercontent.com/opencasestudies/ocs-bp-co2-emissions/master/data/temperature.csv",
                destfile = file.path(datapath,'temperature.csv'), method = "curl")

  ## downloading energy_use_per_person.xlsx
  url = 'https://github.com/opencasestudies/ocs-bp-co2-emissions/blob/master/data/energy_use_per_person.xlsx?raw=true'

  GET(url, write_disk(tf <- tempfile(fileext = ".xlsx"))) # loading file from url
  energy <- read_excel(tf, sheet = 1)

  write.xlsx(energy, file = here("data", "energy_use_per_person.xlsx"), showNA=FALSE) # writing to .xlsx file

  ## downloading gdp_per_capita_yearly_growth.xlsx
  url = 'https://github.com/opencasestudies/ocs-bp-co2-emissions/blob/master/data/gdp_per_capita_yearly_growth.xlsx?raw=true'

  GET(url, write_disk(tf <- tempfile(fileext = ".xlsx"))) # loading file from url
  capita <- read_excel(tf, sheet = 1)

  write.xlsx(capita, file = here("data", "gdp_per_capita_yearly_growth.xlsx"), showNA=FALSE) # writing to .xlsx file

  ## downloading yearly_co2_emissions_1000_tonnes.xlsx
  url = 'https://github.com/opencasestudies/ocs-bp-co2-emissions/blob/master/data/yearly_co2_emissions_1000_tonnes.xlsx?raw=true'

  GET(url, write_disk(tf <- tempfile(fileext = ".xlsx"))) # loading file from url
  emissions <- read_excel(tf, sheet = 1)

  write.xlsx(emissions, file = here("data", "yearly_co2_emissions_1000_tonnes.xlsx"), showNA=FALSE) # writing to .xlsx file
}
