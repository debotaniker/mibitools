#' Read data from Hobo logger.
#'
#' This function reads data files of hobo loggers.
#'
#' @param filename Filename of the datafile.
#' @param logger_id Character, Logger ID, or custom name.
#' @return Clean datafile of the measurements.
#' @keywords hobo temperature
#' @export

read_hobo <- function(filename, logger_id) {
  names(dat) <- c(
    "Record_number",
    "Datetime",
    "Temperature",
    "Koppler_getrennt",
    "Koppler_verbunden",
    "Angehalten",
    "Dateiende"
  )

  for (i in 4:7) {
    dat[[i]][dat[[i]] == ""] <- NA
  }

  dt <- as.POSIXct(dat$Datetime, format = "%d.%m.%y %I:%M:%S %p")

  result <- data.frame(
    Datetime = dt,
    Sonde = paste("hobo", logger_id, sep = "_"),
    dat[,!names(dat) %in% "Datetime"],
    row.names = NULL
  )

  return(result)
}
