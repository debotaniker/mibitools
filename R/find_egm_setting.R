#' Find setting of EGM5
#'
#' This function reads out the setting of EGM5 for a specific line.
#'
#' @param filename Character that contains the data.
#' @return A character representing the measurement setting of EGM in a specific line.
#' @keywords egm egm5 co2 setting
#' @export
#' @examples
#' # Create a temporary file with example EGM5 data
#' temp_file <- tempfile()
#' writeLines(c("Zero", "M1,2024-03-05,12:00,Plot1,1,400,1013,200,10,25,21,0"), temp_file)
#'
#' # Use the temporary file as input
#' setting_line_1 <- find_egm_setting(temp_file)
#'
#' # Print the setting
#' print(setting_line_1)
#'
#' # Clean up
#' unlink(temp_file)

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
