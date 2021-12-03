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

## calculates the average number of each model at each location and direction over the entire duration
average <- traffic %>%
  group_by(COUNTLINENAME, DIRECTION) %>%
  summarise_at(transport_modes, list(mean = mean, sd = sd))

## compare average numbers for each mode in each direction on weekdays and weekends
wkday_numbers <- traffic %>%
  filter(!DAY %in% c("Sat", "Sun")) %>% # filter for just working week
  group_by(DIRECTION) %>%
  summarise(across(transport_modes, mean))

wkend_numbers <- traffic %>%
  filter(DAY %in% c("Sat", "Sun")) %>% # filter for just weekends
  group_by(DIRECTION) %>%
  summarise(across(transport_modes, mean))

## totals for each mode on each day
total_counts <- traffic %>%
  group_by(DATE) %>%
  summarise_at(transport_modes, sum)