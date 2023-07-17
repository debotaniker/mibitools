#' Function to read measurement setting of EGM 5
#'
#' EGM 5 datafiles are different between 6 types of measurement setting. This function reads the setting from the datafile.
#'
#' @param filename Filename of the datafile.
#' @return "M1" - "M6"
#' @keywords egm setting
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