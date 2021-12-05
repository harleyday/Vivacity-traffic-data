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