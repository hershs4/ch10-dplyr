# Exercise 6: DPLYR join introduction

# Install the nycflights13 package and read it in. Require the dplyr package.
install.packages("nycflights13")
library(nycflights13)
library(dplyr)


# Create a dataframe of the average arrival delay for each destination, then use left_join
# to join on the "airports" dataframe, which has the airport info
avg.arr.delay.dest <- flights %>% 
  group_by(dest) %>% 
  summarise(avg_arr_del = mean(arr_delay, na.rm = TRUE)) %>% 
  mutate(faa = dest) %>% 
  left_join(airports, by = "faa") %>% 
  arrange(-avg_arr_del)

# Create a dataframe of the average arrival delay for each airline, then use left_join
# to join on the "airlines" dataframe, which has the airline info
avg.arr.delay.carr <- flights %>% 
  group_by(carrier) %>% 
  summarise(avg_arr_del = mean(arr_delay, na.rm = TRUE)) %>% 
  left_join(airlines, by = "carrier") %>% 
  arrange(-avg_arr_del)


### Bonus ###
# Calculate the average delay by city AND airline, then merge on the city and airline information
avg.arr.delay.dest.and.carr <- flights %>% 
  group_by(dest & carrier) %>% 
  summarise(avg_arr_del = mean(arr_delay, na.rm = TRUE)) %>% 
  mutate(faa = dest) %>% 
  left_join(airports, by = "faa") %>% 
  left_join(airlines, by = "carrier") %>% 
  arrange(-avg_arr_del)

# If you're running into sorting issues:
# http://stackoverflow.com/questions/26555297/dplyr-arrange-a-grouped-df-by-group-variable-not-working