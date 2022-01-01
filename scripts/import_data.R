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
      "Apeldoorn Drive far end traffic sensor data 22 October 2021.csv"
    ),
    name_repair = "universal"
  ) %>%
  rename_with(toupper) %>% # Modify all names to uppercase
  rename(DATE = UTC.TIME) %>% # rename the clunky date column to "DATE" for simplicity
  mutate(DAY = wday(DATE, label = TRUE))

Sutton_wide_traffic_data <-
  read_excel(
    here("data", "raw_data", "Vivacity data.xlsx"),
    sheet = "all LBS 26 July to 19 Dec",
    col_types = c(
      "date",
      "date",
      "text",
      "text",
      "numeric",
      "numeric",
      "numeric",
      "numeric",
      "numeric",
      "numeric",
      "numeric",
      "numeric",
      "skip",
      "skip",
      "skip",
      "skip",
      "skip"
    ),
    .name_repair = "universal"
  ) %>%
  rename_with(toupper) %>% # Modify all names to uppercase
  rename(DATE = UTC.TIME) %>% # rename the clunky date column to "DATE" for simplicity
  mutate(DAY = wday(DATE, label = TRUE)) %>% # add a "day of the week" column
  write_csv(here("data", "processed_data", "sutton_wide_traffic_data.csv"))
