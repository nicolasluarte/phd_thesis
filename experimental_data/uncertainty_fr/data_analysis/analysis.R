library(tidyverse)
library(ggrepel)
library(gridExtra)

# load functions
source("lickMicroStructureFunctions.R")
# data from pc1
dataDir1 <- "~/phd_thesis/experimental_data/uncertainty_fr/data/data_raw/1"
# data from pc2
dataDir2 <- "~/phd_thesis/experimental_data/uncertainty_fr/data/data_raw/2"
csv1 <- fs::dir_ls(dataDir1, regexp = "\\.csv$")
csv2 <- fs::dir_ls(dataDir2, regexp = "\\.csv$")
data1 <- csv1 %>%
	map(read_csv)
data2 <- csv2 %>%
	map(read_csv)
# drop empty files
data1 <- purrr::keep(data1, ~ nrow(.x) > 0)
data2 <- purrr::keep(data2, ~ nrow(.x) > 0)
# set datatypes
data1 <- data1 %>%
	map(function (x){
		    x %>% mutate(
		   date = lubridate::ymd(date),
		   pcTime = strptime(pcTime, format = "%H%M%S"),
		   pcTime = lubridate::hms(paste(lubridate::hour(pcTime), lubridate::minute(pcTime),
			 lubridate::second(pcTime), sep = ":")),
		   ms = msFromStart - msFromStart[1],
	           PC = 1
		   )})
# set datatypes
data2 <- data2 %>%
	map(function (x){
		    x %>% mutate(
		   date = lubridate::ymd(date),
		   pcTime = strptime(pcTime, format = "%H%M%S"),
		   pcTime = lubridate::hms(paste(lubridate::hour(pcTime), lubridate::minute(pcTime),
			 lubridate::second(pcTime), sep = ":")),
		   ms = msFromStart - msFromStart[1],
		   PC = 2
		   )})
data1 <- bind_rows(data1)
data2 <- bind_rows(data2)
rawData <- bind_rows(data1, data2) %>% drop_na()
rawData <- rawData %>%
	group_by(PC, date, arduinoNumber, spoutNumber) %>%
		mutate(isEvent = getIsEvent(eventsCum),
		        msFromEvents = getmsFromEvent(isEvent, ms),
			isTimeout = getIsTimeout(msFromEvents, 20000, eventsCum),
			isTimeoutThreshold = if_else(msFromEvents >= 2000 & isTimeout == 1, 1, 0)) %>%
ungroup()
log <- read_csv("~/phd_thesis/experimental_data/uncertainty_fr/data/log/log.csv")
names(log) <- make.names(names(log), unique=TRUE)
log %>%
	mutate(date = lubridate::ymd(fecha),
	       hora_inicio = lubridate::hms(hora_inicio),
	       hora_termino = lubridate::hms(hora_termino),
	       error.tecnico = replace_na(error.tecnico, 0),
	       arduinoNumber = ARDUINO
	       ) %>% filter(date >= "2021-04-01") -> log
rawData %>% filter(date %in% log$date) -> data 
data <- data %>%
	left_join(log %>%
		  select(date,
			 arduinoNumber,
			 raton,
			 hora_inicio,
			 hora_termino,
			 PC,
			 error.tecnico), by = c('date', 'arduinoNumber', 'PC'))
data %>%
	filter(error.tecnico == "0") %>%
	group_by(raton, date) %>%
	filter(pcTime >= hora_inicio, pcTime <= hora_termino) %>%
	ungroup() -> data
# add groups
# licks, rewards and events should start at 0
data <- data %>%
	mutate(expGroup = if_else(raton %in% c(217, 219, 223, 224), 1, 0)) %>%
	group_by(date, raton, spoutNumber) %>%
	mutate(eventsCum = eventsCum - eventsCum[1],
		licksCum = licksCum - licksCum[1],
		rewardsCum = rewardsCum - rewardsCum[1])
# add condition  (pre - post)
data <- data %>%
	mutate(condition = if_else(date >= "2021-05-12", 1, 0))

# create nested data sets
nestedData <- data %>%
	group_by(date, raton, expGroup, condition, spoutNumber, randomSpout) %>%
	nest()
nestedData <- nestedData %>%
	mutate(
	       eventsPerSpout = map(data, function(x) x %>%
			summarise(eventsPerSpout = max(eventsCum))),
	       licksPerSpout = map(data, function(x) x %>%
			summarise(licksPerSpout = max(licksCum))),
	       rewardsPerSpout = map(data, function(x) x %>%
			summarise(rewardsPerSpout = max(rewardsCum)))
	       )
nestedData <- nestedData %>%
	unnest(cols = c(eventsPerSpout,
			licksPerSpout,
			rewardsPerSpout)) %>%
	group_by(date, expGroup, condition) %>%
	nest() %>%
	mutate(
	       meanEventsPerSession = map(data, function(x) x %>%
	       		summarise(meanEventsPerSession = mean(eventsPerSpout),
					 semEventsPerSession = sd(eventsPerSpout) / sqrt(4))),
	       meanLicksPerSession = map(data, function(x) x %>%
	       		summarise(meanLicksPerSession = mean(licksPerSpout),
					 semLicksPerSession = sd(licksPerSpout) / sqrt(4))),
	       meanRewardsPerSession = map(data, function(x) x %>%
	       		summarise(meanRewardsPerSession = mean(rewardsPerSpout),
					 semRewardsPerSession = sd(rewardsPerSpout) / sqrt(4)))
	       ) %>%
	unnest(cols = c(data,
			meanEventsPerSession,
			meanLicksPerSession,
			meanRewardsPerSession))

# example plot with nested data
nestedData %>%
	nest(data = c(-meanEventsPerSession,
		      -semEventsPerSession,
		      -date,
		      -condition,
		      -expGroup)) %>%
	ggplot(aes(date, meanEventsPerSession, color = as.factor(expGroup))) +
	geom_point() +
	geom_errorbar(aes(ymin = meanEventsPerSession - semEventsPerSession,
			  ymax = meanEventsPerSession + semEventsPerSession)) +
	geom_line(size = 3) +
	facet_wrap(~condition)

