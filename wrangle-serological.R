library(tidyverse)
library(lubridate)
library(readxl)

day_received <- make_date(2020, 7, 14)

fn <- "data/Bioportal\ tests\ by\ collected\ date_Refresh.xlsx"
dat <- read_xlsx(fn, sheet = 2) 

dat <- mutate(dat, date = mdy(sampleCollectedDate))

## Remove inconsistent dates
dat <- dat %>% 
  filter(year(date) == 2020) %>%
  arrange(date)

if(FALSE){
  dat %>% 
    group_by(date) %>%
    summarize(n=n()) %>% 
    arrange(date) %>%
    View()
}

first_day <- make_date(2020, 3, 16)
last_day <- make_date(2020, 7, 14)
print(data.frame(first_day= first_day, last_day = last_day))
dat <- filter(dat, date<= last_day & date >= first_day) %>%
  filter(serological.positives > 0)

tests <- dat %>%
  mutate(sero_rate = serological.positives / serological.total)

bioportal_serodata <- dat

save(bioportal_serodata, tests, file = "rdas/bioportal-serodata-2020-07-14.rda")
