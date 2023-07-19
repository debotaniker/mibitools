#' Find setting of EGM5
#'
#' This function reads out the setting of EGM5 for a specific line.
#'
#' @param filename Character that contains the data.
#' @return A character representing the measurement setting of EGM in a specific line.
#' @keywords egm egm5 co2 setting
#' @export
#' @examples
#' # Example usage of the function
#' setting_line_1 <- find_egm_setting(filename)

find_egm_setting <- function(filename) {
  data <- read.csv(filename, sep = ",", header = FALSE, stringsAsFactors = FALSE)
  nrows <- nrow(data)

  # Search for the first non-"Zero" value in the appropriate column
  for (i in 1:nrows) {
    if (data[i, 1] != "Zero") {
      setting <- substr(data[i, 1], 1, 2)
      break
    }
  }

  if (exists("setting")) {
    return(setting)
  } else {
    print("No setting found")
    return("Default setting")
  }
}
