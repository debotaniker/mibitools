#' Highlight Night Function
#'
#' This function highlights night periods in a ggplot.
#' @param data Data frame containing a datetime column.
#' @param lat Latitude for calculating day/night.
#' @param datetime_name Name of the datetime column, defaults to "datetime"
#' @param hcolor Color for highlighting, defaults to "blue"
#' @param halpha Alpha transparency for highlighting, defaults to 0.2
#' @import ggplot2 dplyr LakeMetabolizer lubridate
#' @export
#' @examples
#' library(ggplot2) # Ensure ggplot2 is available
#' # Define the start and end date
#' start_date <- as.POSIXct("2024-03-01 00:00:00")
#' end_date <- as.POSIXct("2024-03-04 23:00:00")
#'
#' # Create a sequence of hourly timestamps
#' timestamp <- seq(from = start_date, to = end_date, by = "hour")
#'
#' # Generate corresponding temperature values ranging between 10 and 25
#' temperature <- seq(from = 10, to = 25, length.out = length(timestamp))
#'
#' # Create a data frame with timestamp and temperature columns
#' temperature_data <- data.frame(timestamp = timestamp, temperature = temperature)
#'
#' # Plot the data with night highlights
#' ggplot(temperature_data) +
#' highlight_night(data = temperature_data, 52, datetime_name = "timestamp") +
#' geom_line(aes(timestamp, temperature))
#' @note Requires the ggplot2, LakeMetabolizer, lubridate and dplyr packages.

highlight_night <- function(data = "data", lat = "lat", datetime_name = "datetime", hcolor = "blue", halpha = 0.2) {

  library(dplyr)
  library(lubridate)
  library(LakeMetabolizer)

  # Dynamically check for datetime column
  if(!"datetime" %in% names(data) && !datetime_name %in% names(data)) {
    stop("The specified datetime column does not exist in the dataframe. Please specify the correct column name.")
  }

  # If the default "datetime" column exists and no alternative name is specified, use "datetime"
  # Otherwise, use the specified datetime_name
  datetime_col <- if("datetime" %in% names(data) && datetime_name == "datetime") {
    "datetime"
  } else {
    datetime_name
  }

  # Identify nights
  data <- data %>%
    mutate(
      day_night = ifelse(is.day(.data[[datetime_col]], lat), "day", "night"),
      change = day_night != lag(day_night, default = first(day_night)),
      id_number  = cumsum(change),
      id = paste0(ifelse(day_night == "day", "D", "N"), id_number)
    )

  # Identify sunset and sunrise, for start and end of hightlights, respectively
  night_highlights <- data %>%
    filter(
      day_night == "night" & change == TRUE
    ) %>%
    select(
      datetime_col,
      "id"
    ) %>%
    mutate(
      start = sun.rise.set(.data[[datetime_col]], 52)[,2],
      end = sun.rise.set(.data[[datetime_col]] + days(1), 52)[,1]
    )

  # Create a ggplot layer
  night_layer <- geom_rect(data = night_highlights, inherit.aes = FALSE,
            aes(xmin = start, xmax = end, ymin = -Inf, ymax = Inf),
            fill = hcolor, alpha = halpha)

  # Return the ggplot layer
  return(night_layer)
}
