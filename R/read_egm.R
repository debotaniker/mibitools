#' Function to read data from EGM CO2 Analyzer files
#'
#' This function can be used to read data from EGM4 and EGM5 CO2 Analyzers.
#'
#' @param filename Filename of the datafile.
#' @param egm_model Character, which contains the model number of the EGM CO2 analyzer.
#' #' @param year Character, which contains the year of the measurements, because EGM4 does not record year. Parameter will be discarded of EGM5 was used.
#' @return Clean datafile of the measurements.
#' @keywords egm co2
#' @export
#' @examples
#' # Example usage of the function
#' read_egm(filename = "path\\to\\file.txt", egm_model = "4", year = "2015")


read_egm <- function(filename, egm_model, year) {
  if (egm_model == "4") {
    top <-
      readLines(con = filename, n = 5) # read the top 5 lines of the file
    header <-
      unlist(strsplit(x = top[3], split = "\t")) # assume line 1 is header

    for (i in 1:length(header)) {
      header[i] <-
        sub(pattern = "#[0-9]\\(",
            replacement = "",
            x = header[i]) # remove silly hash headings
      header[i] <-
        sub(pattern = "\\)",
            replacement = "",
            x = header[i]) # remove silly parentheses
      header[i] <-
        sub(pattern = "\\.",
            replacement = "",
            x = header[i]) # remove silly dots
      header[i] <-
        sub(pattern = " ",
            replacement = "_",
            x = header[i]) # replace spaces between words with "_"
      header[i] <-
        sub(pattern = " ",
            replacement = "_",
            x = header[i]) # replace spaces between words with "_"
    }

    dat <- read.csv(filename,
                    sep = "\t",
                    skip = 3)

    names(dat) <- header

    dt <-
      as.POSIXct(paste(year,
                       dat$Month,
                       dat$Day,
                       dat$Hour,
                       dat$Min),
                 format = "%Y %m %d %H %M")

    result <- data.frame(
      Datetime = dt,
      Sonde = paste("EGM", egm_model, sep = "_"),
      dat[, !names(dat) %in% c("Day", "Month", "Hour", "Min")],
      row.names = NULL
    )

  }
  else if (egm_model == "5") {
    dat = readLines(filename)

    all_headers <- c(
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
      "Parameter_5",
      "CO2__ad_counts",
      "Air_pressure_ad_counts",
      "Temperature_probe_1_ad_counts",
      "Temperature_probe_2_ad_counts",
      "Lamp_ad_counts",
      "Last_zero_CO2_ad_counts"
    )

    result <-
      as.data.frame(matrix(NA, length(dat), length(all_headers)))

    names(result) <- all_headers

    for (i in 1:length(dat)) {
      my_line_data <- find_egm_line(dat[i])

      # Remove leading/trailing spaces from lines
      my_line_data[] <- lapply(my_line_data, trimws)

      # Convert numeric columns from chr to num
      my_line_data[] <- lapply(my_line_data, function(x) {
        num <- suppressWarnings(as.numeric(x))
        ifelse(is.na(num), x, num)
      })

      for (j in 1:length(names(my_line_data))) {
        if (names(my_line_data)[j] %in% names(result)) {
          result[i, names(my_line_data)[j]] <-
            my_line_data[, names(my_line_data)[j]]
        }
      }
    }

    dt <-
      as.POSIXct(paste(result$Date, result$Time), format = "%d/%m/%y %H:%M:%S")

    result <- data.frame(
      Datetime = dt,
      Probe = paste("EGM", egm_model, sep = "_"),
      result[, !names(result) %in% c("Date", "Time")],
      row.names = NULL
    )
  }
  return(result)
}
