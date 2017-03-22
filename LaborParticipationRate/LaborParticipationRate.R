library(readr); library(dplyr); library(ggplot2)
library(tidyr)

# Data Source: https://data.bls.gov/timeseries/LNS11300000

lpr_data <- read_csv("~/../Downloads/lpr.csv") %>% filter(Year < 2017)


lpr_data2 <- 
  lpr_data %>% 
  gather(month, lpr, Jan:Dec) %>%
  mutate(president = as.character(cut(Year, breaks = c(1944, 1952, 1960, 1962, 1968, 
                                          1973, 1976, 1980, 1988, 1992, 2000, 2008, 2016), 
                         labels = c("Truman", "Eisenhower", "JFK", "LBJ", "Nixon", "Ford", "Carter", "Reagan", "Bush Sr.", 
                                    "Clinton", "Bush Jr.", "Obama")))) %>% 
  left_join(data.frame(
    president = c("Truman", "Eisenhower", "JFK", "LBJ", "Nixon", "Ford", "Carter", "Reagan", 
                  "Bush Sr.", "Clinton", "Bush Jr.", "Obama"), 
    president_party = c("Democrat", "Republican", "Democrat", "Democrat", 
                        "Republican", "Republican", "Democrat", "Republican", "Republican", "Democrat", 
                        "Republican", "Democrat"), 
    stringsAsFactors = F), 
    by = "president")

lpr_data2 %>% group_by(president) %>% summarise(term_start = min(Year), term_end = max(Year)) %>% arrange(term_start)

  ggplot(lpr_data2) + 
  geom_line(aes(month_num, lpr, color = president_party, group = Year)) + 
  facet_wrap(~president_party)
  
  ggplot(lpr_data2) + 
    geom_smooth(aes(Year, lpr)) +
    geom_point(aes(Year, lpr, color = president_party)) + 
    scale_color_manual(values = c("Democrat" = "dodgerblue", "Republican" = "red"),
                       name = "President's Party") +
    geom_label(data = lpr_data2 %>% group_by(president) %>% summarise(term_mid = mean(Year), lpr_mid = ((max(lpr) + min(lpr)) / 2)), 
               aes(x = term_mid, y = lpr_mid, label = president), size = 3) +
    ggtitle("Labor Participation Rate in the US") +
    ylab(NULL) +
    scale_x_continuous(breaks = seq(1950, 2020, by = 10))