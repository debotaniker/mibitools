#' Function to read data from EGM CO2 Analyzer files
#'
#' This function can be used to read data from EGM4 and EGM5 CO2 Analyzers.
#'
#' @param filename Filename of the datafile.
#' @param egm_model Character, which contains the model number of the EGM CO2 analyzer.
#' @return Clean datafile of the measurements.
#' @keywords egm co2
#' @export
#' @examples
#' # Example usage of the function
#' read_egm(filename = "path\\to\\file.txt", egm_model = "4")
#'
#' @importFrom package_name function1 function2
#' @import package_name
#' @importFrom package_name2 function3
#' @import package_name2
#' @importFrom package_name3 function4
#' @import package_name3

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
    setting <- find_egm_setting(filename)

    if (setting == "M1") {
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



    # Read the data from a text file
    data <- readLines(filename)

    # Initialize variables
    max_columns <- 0
    cleaned_data <- matrix(NA, nrow = length(data), ncol = 0)

    # Iterate through each line of the data
    for (i in 1:length(data)) {
      line <- data[i]

      # Check if the line contains "Zero"
      if (line != "Zero") {
        # Split the line by comma
        row_data <- strsplit(line, ",")[[1]]

        # Update the maximum number of columns if necessary
        if (length(row_data) > max_columns) {
          max_columns <- length(row_data)

          # Resize the matrix to accommodate the maximum number of columns
          cleaned_data <- matrix(NA, nrow = length(data), ncol = max_columns)
        }

        # Assign the row data to the cleaned_data matrix
        cleaned_data[i, 1:length(row_data)] <- row_data
      }
    }

    # Convert the cleaned_data matrix to a data frame
    cleaned_data <- as.data.frame(cleaned_data)

    # Print the cleaned data
    print(cleaned_data)



    names(dat) <- header

    dt <-
      as.POSIXct(paste(dat$Date, dat$Time),
                 format = "%d/%m/%y %H:%M:%S")

    result <- data.frame(
      Datetime = dt,
      Sonde = paste("EGM", egm_model, sep = "_"),
      dat[, !names(dat) %in% c("Date", "Time")],
      row.names = NULL
    )
  }
  return(result)
}
