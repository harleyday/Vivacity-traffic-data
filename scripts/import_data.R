library(tidyverse)
library(readxl)
library(lubridate)
library(here)

## import the traffic data from the excel spreadsheet, and write a csv version of the cleaned-up version
butter_hill_traffic <-
  read_excel(
    here("data",
         "raw_data",
         "Butter Hill Traffic Sensor.xlsx"),
    sheet = "Butter Hill Traffic Sensor",
    .name_repair = "universal"
  ) %>%
  rename_with(toupper) %>% # Modify all names to uppercase
  rename(DATE = UTC.TIME) %>% # rename the clunky date column to "DATE" for simplicity
  mutate(DAY = wday(DATE, label = TRUE)) %>% # add a "day of the week" column
  write_csv(here("data", "processed_data", "traffic_data.csv"))

appledorn_traffic <-
  read_csv(
    here(
      "data",
      "raw_data",
      "Apeldoorn Drive trafffic sensor data far end.csv"
    ),
    name_repair = "universal"
  ) %>%
  rename_with(toupper) %>% # Modify all names to uppercase
  rename(DATE = UTC.TIME) %>% # rename the clunky date column to "DATE" for simplicity
  mutate(DAY = wday(DATE, label = TRUE))

appledorn_15_minute_22Oct2021_traffic <-
  read_csv(
    here(
      "data",
      "raw_data",
      "Apeldoorn Drive far end traffic sensor data 24 October 2021.csv"
    ),
    name_repair = "universal"
  ) %>%
  rename_with(toupper) %>% # Modify all names to uppercase
  rename(DATE = UTC.TIME) %>% # rename the clunky date column to "DATE" for simplicity
  mutate(DAY = wday(DATE, label = TRUE))
