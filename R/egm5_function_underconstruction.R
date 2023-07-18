




filename <-
  "C:\\Users\\aurichp\\Nextcloud\\Cloud\\repos\\mediwa_project\\membrane_equilibration_unit\\2023_experiment\\Hermeckes_Kiesloch\\EGM_data\\EGM5\\23052210.TXT"



dat = readLines(filename)
egm_model <- "5"
test_un <- unlist(strsplit(x = dat[5], split = ","))

all_headers <-
  unique(
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
      "Setting",
      "CO2_ppm",
      "Air_pressure_mbar",
      "Flow_Rate_cc_min",
      "H2O_mbar",
      "H2O_temp_degC",
      "O2_percent",
      "System_error",
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
      "Setting",
      "CO2__ad_counts",
      "Air_pressure_ad_counts",
      "Temperature_probe_1_ad_counts",
      "Temperature_probe_2_ad_counts",
      "Lamp_ad_counts",
      "Last_zero_CO2_ad_counts",
      "System_error"
    )
  )

result <-
  as.data.frame(matrix(NA, length(dat), length(all_headers)))

names(result) <- all_headers

for (i in 1:length(dat)) {
  my_line_data <- find_egm_line(dat[i])

  # Apply the trimws function to each element to remove leading/trailing spaces
  my_line_data[] <- lapply(my_line_data, trimws)

  # Try converting all columns to numeric, those that fail will be left as character
  my_line_data[] <- lapply(my_line_data, function(x) {
    num <- as.numeric(x)
    ifelse(is.na(num), x, num)
  })
  print(i)
  for (j in 1:length(names(my_line_data))) {
    if (names(my_line_data)[j] %in% names(result)) {
      result[i, names(my_line_data)[j]] <-
        my_line_data[, names(my_line_data)[j]]
    }
  }
}

dt <- as.POSIXct(paste(result$Date, result$Time), format = "%d/%m/%y %H:%M:%S")

result <- data.frame(
  Datetime = dt,
  Probe = paste("EGM",egm_model, sep = "_"),
  result[, !names(result) %in% c("Date", "Time")],
  row.names = NULL
)

###################################
#this works too
for (i in 1:length(dat)) {
  my_line_data <- find_egm_line(dat[i])

  #here delete whitespace, formate your date etc etc etc

  for (j in 1:length(names(my_line_data))) {
    if (names(my_line_data)[j] %in% names(result)) {
      result[i, names(my_line_data)[j]] <-
        my_line_data[, names(my_line_data)[j]]
    }
  }
}

# dont change this part, it works
test_data <- dat[1:3140]

test_df <-
  as.data.frame(matrix(NA, length(test_data), length(all_headers)))

names(test_df) <- all_headers

for (i in 1:length(test_data)) {
  my_line_data <- find_egm_line(test_data[i])

  #here delete whitespace, formate your date etc etc etc

  for (j in 1:length(names(my_line_data))) {
    if (names(my_line_data)[j] %in% names(test_df)) {
      test_df[i, names(my_line_data)[j]] <-
        my_line_data[, names(my_line_data)[j]]
    }
  }
}
