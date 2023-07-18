#' Function to read data from the GC2 template.
#'
#' This function can be used to read data from the GC2 template file. It takes sample information from the "results" sheet
#' and measurement data from "concentration" sheet. Parameter for the function is only the files name.
#'
#' @param filename Filename of the datafile.
#' @param egm_model Character, which contains the model number of the EGM CO2 analyzer.
#' @return Clean datafile of the measurements.
#' @keywords gc co2 ch4 n2o o2 headspace
#' @export
#' @examples
#' # Example usage of the function
#' read_gc(filename = "path\\to\\file.txt")
#'
#' @importFrom readxl read_excel
#' @import readxl

library(readxl)

read_gc <- function(filename) {
  dat <-
    read_excel(filename,
               sheet = "concentration",
               skip = 7,
               col_names = FALSE)

  header <- c(
    "Position",
    "Sample_id",
    "Temperature_equilibration",
    "Datetime",
    "CH4_µmol_l",
    "N2O_µmol_l",
    "CO2_corrected_µmol_l",
    "O2_µmol_l",
    "CO2_simple_µmol_l",
    "CO1_simple_r_µmol_l",
    "empty",
    "Bunsen_CH4",
    "Bunsen_CO2",
    "Bunsen_N2O",
    "Bunsen_O2",
    "Air_CH4_ppm",
    "Air_N2O_ppm",
    "Air_CO2_ppm",
    "Air_O2_percent"
  )

  colnames(dat) <- header

  dat <- dat[dat$Sample_id != 0, ]

  dt <- dat$Datetime

  results <-
    read_excel(filename,
               sheet = "results",
               skip = 7,
               col_names = FALSE)[, c(1:13)]

  header_results <- c(
    "Position",
    "Label",
    "Sample_id",
    "Temperature_equilibration",
    "Air_pressure_mbar",
    "Temperature_insitu",
    "pH",
    "Datetime",
    "GC_file_name",
    "Headspace_CH4_ppm",
    "Headspace_CO2_ppm",
    "Headspace_N2O_ppm",
    "Headspace_O2_percent"
  )

  colnames(results) <- header_results

  results <- results[!is.na(results$Sample_id), ]

  result <- data.frame(
    Datetime = dt,
    Method = "Headspace_equilibration",
    results[, !names(results) %in% c("Datetime")],
    dat[, !names(dat) %in% c("Position",
                             "Sample_id",
                             "Temperature_equilibration",
                             "Datetime",
                             "empty")],
    row.names = NULL
  )

  return(result)
}
