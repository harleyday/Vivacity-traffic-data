library(tidyverse)
library(readxl)
library(lubridate)
library(here)

## import the traffic data from the excel spreadsheet, and write a csv version of the cleaned-up version
traffic <-
  read_excel(here("data", "raw_data", "Butter Hill Traffic Sensor.xlsx"),
             sheet = "Butter Hill Traffic Sensor",
             .name_repair = "universal") %>%
  rename_with(toupper) %>% # Modify all names to uppercase
  rename(DATE = UTC.TIME) %>% # rename the clunky date column to "DATE" for simplicity
  mutate(DAY = wday(DATE, label = TRUE)) %>% # add a "day of the week" column
  write_csv("traffic_data.csv")
