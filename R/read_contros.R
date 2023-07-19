#' Read data of Contros probes
#'
#' This function can be used to read Contros probe data from SD data files
#' This can span multiple lines if needed.
#'
#' @param filename Character, the SD_datafile that contains the data
#' @param probeid Character, the ID of the probe, e.g. "CO2T-0721-001"
#' @return A dataframe of the contros data
#' @keywords contros CO2
#' @export
#' @examples
#' # Example usage of the function
#' my_function(arg1 = "value1", arg2 = 10)

read_contros <- function(filename, tz) {
  result <- NULL
  probeid <- as.character(read.table(filename, header = FALSE, sep = ";")[2,1])
  print(paste("probe ID: ", probeid))

  probeid %in% c("CO2T-0721-001", "CO2T-1021-002")
    header_line <- readLines(filename, n = 3)[3]
    header <- strsplit(header_line, split = ";", fixed = TRUE)[[1]]

    dat <- read.table(filename, header = FALSE, skip = 6,  sep = ";", dec = ",")[, -(length(header) + 1)]

    names(dat) <- header

    dt <- as.POSIXct(paste(dat$Date, dat$Time), tz = tz)

    result <- data.frame(
      Datetime = dt,
      Sonde = probeid,
      dat[, !names(dat) %in% c("Date", "Time")],
      row.names = NULL
    )
    return(result)
}
