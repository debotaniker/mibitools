#' Function to read data from GC2 files
#'
#' This function can be used to read data GC template.
#'
#' @param filename Filename of the datafile.
#'
#' @return Clean datafile of the measurements.
#' @keywords co2 gc
#' @export
#' @examples
#' # Example usage of the function
#' read_gc(filename = "path\\to\\file.txt")
#'
#' @importFrom readxl read_excel

read_gc <- function(filename) {
  dat <-
    readxl::read_excel(filename,
               sheet = "concentration",
               skip = 7,
               col_names = FALSE)

  header <- c(
    "Position",
    "Sample_id",
    "Temperature_equilibration",
    "Datetime",
    "CH4_?mol_l",
    "N2O_?mol_l",
    "CO2_corrected_?mol_l",
    "O2_?mol_l",
    "CO2_simple_?mol_l",
    "CO1_simple_r_?mol_l",
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
    readxl::read_excel(filename,
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
