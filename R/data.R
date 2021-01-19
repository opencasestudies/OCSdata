#' Global CO2 and GDP Wrangled Data
#'
#' A dataset containing the amount of CO2 emitted by each country
#' as well as GDP growth per year since 1949. CO2 emissions value
#' reported in thousands of tonnes.
#' Source: https://github.com/opencasestudies/ocs-bp-co2-emissions/blob/master/data/wrangled_data.csv
#'
#' @format A data frame with 63,095 rows and 6 variables:
#' \describe{
#'   \item{Country}{name of the country}
#'   \item{Year}{the year data is from}
#'   \item{Label}{type of data, either CO2 Emissions or GDP Growth}
#'   \item{Indicator}{data indicator, either Emissions or GDP}
#'   \item{Value}{number value of the data, in thousands of tons for CO2 emissions, in GDP for GDP growth}
#'   \item{Region}{indicates if the country is the United States or in the Rest of the World}
#'   ...
#' }
#' @source \url{https://github.com/opencasestudies/ocs-bp-co2-emissions/blob/master/data/wrangled_data.csv}
"data_long"

#' United States Environment and Economy Wrangled Data
#'
#' A dataset containing data on CO2 emissions, GDP growth, energy useage,
#' natural disasters and average temperature in the United States since 1980.
#' Source: https://github.com/opencasestudies/ocs-bp-co2-emissions/blob/master/data/wrangled_US_data.csv
#'
#' @format A data frame with 35 rows and 8 variables:
#' \describe{
#'   \item{Country}{name of the country}
#'   \item{Year}{the year data is from}
#'   \item{Region}{region the data comes from, always United States in this case}
#'   \item{Emissions}{co2 emitted that year, in thousands of tonnes}
#'   \item{GDP}{GDP growth that year, in GDP}
#'   \item{Energy}{energy use per person, in kg of oil (or equivalent)}
#'   \item{Disasters}{number of natural disasters that year, integer}
#'   \item{Temperature}{average temperature across the contiguous U.S. from Jan-Dec, in degrees Fahrenheit}
#'   ...
#' }
#' @source \url{https://github.com/opencasestudies/ocs-bp-co2-emissions/blob/master/data/wrangled_US_data.csv}
"wide_US"
