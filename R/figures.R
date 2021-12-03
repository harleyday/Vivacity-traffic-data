## Timeseries for the different modes
library(ggplot2)
library(tidyr)

## define the modes of transport we're interested in analyzing
transport_modes <-
  c("CAR",
    "PEDESTRIAN",
    "CYCLIST",
    "MOTORBIKE",
    "BUS",
    "OGV1",
    "OGV2",
    "LGV")

total_counts %>%
  pivot_longer(transport_modes, names_to = "MODE", values_to = "COUNT") %>%
  ggplot(aes(
    x = DATE,
    y = COUNT,
    group = MODE,
    colour = MODE
  )) + geom_line() +
  ggtitle('Timecourse for each mode')

## Bar charts for average mode numbers at weekends
wkend_numbers %>%
  pivot_longer(transport_modes, names_to = "MODE", values_to = "COUNT") %>%
  ggplot(aes(MODE)) +
  geom_bar(aes(weight = COUNT, fill = DIRECTION)) +
  ggtitle('Average mode counts at weekends')

## Bar charts for average mode numbers during the week
wkday_numbers %>%
  pivot_longer(transport_modes, names_to = "MODE", values_to = "COUNT") %>%
  ggplot(aes(MODE)) +
  geom_bar(aes(weight = COUNT, fill = DIRECTION)) + 
  ggtitle('Average mode counts on weekdays')
