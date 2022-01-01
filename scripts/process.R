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
  summarise(across(all_of(transport_modes), list(mean = mean, sd = sd)))

## compare average numbers for each mode in each direction on weekdays and weekends
wkday_numbers <- traffic %>%
  filter(!DAY %in% c("Sat", "Sun")) %>% # filter for just working week
  group_by(DIRECTION) %>%
  summarise(across(all_of(transport_modes), mean))

wkend_numbers <- traffic %>%
  filter(DAY %in% c("Sat", "Sun")) %>% # filter for just weekends
  group_by(DIRECTION) %>%
  summarise(across(all_of(transport_modes), mean))

## totals for each mode on each day
total_counts <- traffic %>%
  group_by(DATE) %>%
  summarise(across(all_of(transport_modes), sum))

## totals for each mode over 22nd Oct 2021 for Appledorn
total_counts_22Oct2021_Appledorn <- appledorn_15_minute_22Oct2021_traffic %>%
  group_by(LOCAL.TIME..SENSOR.) %>%
  summarise(across(all_of(transport_modes), sum))

##### Sutton-wide data
## compare average numbers for each mode in each direction on weekdays and weekends
wkday_numbers <- Sutton_wide_traffic_data %>%
  filter(!DAY %in% c("Sat", "Sun")) %>% # filter for just working week
  group_by(COUNTLINENAME, DIRECTION) %>%
  summarise(across(all_of(transport_modes), mean))

wkend_numbers <- Sutton_wide_traffic_data %>%
  filter(DAY %in% c("Sat", "Sun")) %>% # filter for just weekends
  group_by(COUNTLINENAME, DIRECTION) %>%
  summarise(across(all_of(transport_modes), mean))

## calculates the average number of each model at each location and direction over the entire duration
summary_stats_either_direction <- Sutton_wide_traffic_data %>%
  group_by(COUNTLINENAME) %>%
  summarise_at(all_of(transport_modes), list(total = sum, mean = mean, sd = sd))

sum_either_direction_each_day <- Sutton_wide_traffic_data %>%
  group_by(DATE, COUNTLINENAME) %>%
  summarise(across(all_of(transport_modes), sum)) %>%
  group_by(DATE, COUNTLINENAME) %>%
  mutate(TOTAL = sum(c_across(cols = all_of(transport_modes))))

number_days_with_zero_observations <- sum_either_direction_each_day %>%
  filter(TOTAL==0) %>%
  group_by(COUNTLINENAME) %>%
  summarise(n = n())

## filter out those days with zero observations as they're probably days when the sensor was inactive
sum_nonzero_either_direction_each_day <- sum_either_direction_each_day %>%
  filter(TOTAL>0)

## filter summary statistics by date
summary_stats_26Jul2021_to_19Dec2021 <- sum_nonzero_either_direction_each_day %>%
  group_by(COUNTLINENAME) %>%
  filter(DATE <= as_date("2021-12-29") && DATE >= as_date("2021-07-26")) %>%
  summarise(across(all_of(transport_modes), list(total = sum, mean = mean)))
