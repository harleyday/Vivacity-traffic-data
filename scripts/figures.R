## Timeseries for the different modes
library(ggplot2)
library(tidyr)
library(tidyquant)

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
  geom_ma(ma_fun = SMA, n = 7) + 
  ggtitle('Timecourse for each mode')
ggsave(here('img','timecourse.png'))

## Bar charts for average mode numbers at weekends
wkend_numbers %>%
  pivot_longer(transport_modes, names_to = "MODE", values_to = "COUNT") %>%
  ggplot(aes(MODE)) +
  geom_bar(aes(weight = COUNT, fill = DIRECTION)) +
  ggtitle('Average mode counts at weekends')
ggsave(here('img','weekends.png'))

## Bar charts for average mode numbers during the week
wkday_numbers %>%
  pivot_longer(transport_modes, names_to = "MODE", values_to = "COUNT") %>%
  ggplot(aes(MODE)) +
  geom_bar(aes(weight = COUNT, fill = DIRECTION)) + 
  ggtitle('Average mode counts on weekdays')
ggsave(here('img','weekdays.png'))

## Appledorn data

# TODO: clear up the x-axis labelling
library(scales)

total_counts_22Oct2021_Appledorn %>%
  pivot_longer(all_of(transport_modes), names_to = "MODE", values_to = "COUNT") %>%
  ggplot(aes(
    x = LOCAL.TIME..SENSOR.,
    y = COUNT,
    group = MODE,
    colour = MODE
  )) + geom_line() +
  #scale_x_datetime(breaks = breaks_pretty(24))
  geom_ma(ma_fun = SMA, n = 7) + 
  ggtitle('Timecourse for each mode')
ggsave(here('img','timecourse.png'))

##### Sutton-wide Vivacity data
sum_nonzero_either_direction_each_day %>%
  filter(COUNTLINENAME=="L12_LindberghRd_road_and_LHS_path_s140") %>%
  pivot_longer(all_of(transport_modes), names_to = "MODE", values_to = "COUNT") %>%
  ggplot(aes(
    x = DATE,
    y = COUNT,
    group = MODE,
    colour = MODE
  )) + geom_line() +
  labs(title = "L12_LindberghRd_road_and_LHS_path_s140")
