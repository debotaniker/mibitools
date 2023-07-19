#' Read single line of EGM5 data.
#'
#' This function reads one line of EGM
#'
#' @param filename Character that contains the data.
#' @return A data.frame that includes one row of EGM5 data with correct column names.
#' @keywords egm egm5 co2 setting
#' @export
#' @examples
#' # Example usage of the function
#' find_egm_line <- find_egm_setting(line)

find_egm_line <- function(line){

  line_unlisted <- unlist(strsplit(x = line, split = ","))
  setting <- line_unlisted[1]
  data_row <- as.data.frame(t(line_unlisted))

  if(setting == "Zero"){
    header <- "Setting"
  } else if(setting == "Start"){
    header <- "Setting"
  } else if(setting == "End"){
    header <- "Setting"
  } else if (setting == "M1") {
    header <-
      c(
        "Setting",
        "Date",
        "Time",
        "Plot_No",
        "Record_No",
        "CO2_ppm",
        "Air_pressure_mbar",
        "Flow_Rate_cc_min",
        "H2O_mbar",
        "H2O_temp_degC",
        "O2_percent",
        "System_error"
      )
  } else if (setting == "M2") {
    header <-
      c(
        "Setting",
        "CO2_ppm",
        "Air_pressure_mbar",
        "Flow_Rate_cc_min",
        "H2O_mbar",
        "H2O_temp_degC",
        "O2_percent",
        "System_error"
      )
  } else if (setting == "M3") {
    header <-
      c(
        "Setting",
        "Date",
        "Time",
        "Plot_No",
        "Record_No",
        "CO2_ppm",
        "Air_pressure_mbar",
        "Flow_Rate_cc_min",
        "H2O_mbar",
        "H2O_temp_degC",
        "O2_percent",
        "System_error",
        "Aux_voltage",
        "PAR_ppm",
        "Temp_soil_degC",
        "Temp_air_degC",
        "Relative_humidity_percent"
      )
  } else if (setting == "M4") {
    header <-
      c(
        "Setting",
        "CO2_ppm",
        "Air_pressure_mbar",
        "Flow_Rate_cc_min",
        "H2O_mbar",
        "H2O_temp_degC",
        "O2_percent",
        "System_error",
        "Aux_voltage",
        "PAR_ppm",
        "Temp_soil_degC",
        "Temp_air_degC",
        "Relative_humidity_percent"
      )
  } else if (setting == "M5") {
    header <-
      c(
        "Setting",
        "Date",
        "Time",
        "Plot_No",
        "Record_No",
        "CO2_ppm",
        "Air_pressure_mbar",
        "Flow_Rate_cc_min",
        "H2O_mbar",
        "H2O_temp_degC",
        "O2_percent",
        "System_error",
        "Aux_voltage",
        "PAR_ppm",
        "Temp_soil_degC",
        "Temp_air_degC",
        "Relative_humidity_percent",
        "Parameter_1",
        "Parameter_2",
        "Parameter_3",
        "Parameter_4",
        "Parameter_5"
      )
  } else if (setting == "R5") {
    header <-
      c(
        "Setting",
        "Date",
        "Time",
        "Plot_No",
        "Record_No",
        "CO2_ppm",
        "Air_pressure_mbar",
        "Flow_Rate_cc_min",
        "H2O_mbar",
        "H2O_temp_degC",
        "O2_percent",
        "System_error",
        "Aux_voltage",
        "PAR_ppm",
        "Temp_soil_degC",
        "Temp_air_degC",
        "Relative_humidity_percent",
        "Parameter_1",
        "Parameter_2",
        "Parameter_3",
        "Parameter_4",
        "Parameter_5"
      )
  } else if (setting == "M6") {
    header <-
      c(
        "Setting",
        "CO2__ad_counts",
        "Air_pressure_ad_counts",
        "Temperature_probe_1_ad_counts",
        "Temperature_probe_2_ad_counts",
        "Lamp_ad_counts",
        "Last_zero_CO2_ad_counts",
        "System_error"
      )
  }
  names(data_row) <- header

  return(data_row)
}
