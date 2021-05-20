library(tidyverse)
library(fs)
library(ggplot2)
library(gridExtra)

# load files
dataDir1 <- "~/phd_thesis/experimental_data/uncertainty_fr/data/data_raw/1"
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
		   PC = 2
		   )})

data1 <- bind_rows(data1)
data2 <- bind_rows(data2)
rawData <- bind_rows(data1, data2) %>% drop_na()


# read log data
log <- read_csv("~/phd_thesis/experimental_data/uncertainty_fr/data/log/log.csv")
# fix col names
names(log) <- make.names(names(log), unique=TRUE)
log %>%
	mutate(date = lubridate::ymd(fecha),
	       hora_inicio = lubridate::hms(hora_inicio),
	       hora_termino = lubridate::hms(hora_termino),
	       error.tecnico = replace_na(error.tecnico, 0),
	       arduinoNumber = ARDUINO
	       ) %>% filter(date >= "2021-05-13") -> log

rawData %>% filter(date %in% log$date) -> data

data %>%
	left_join(log %>%
		  select(date,
			 arduinoNumber,
			 raton,
			 hora_inicio,
			 hora_termino,
			 PC,
			 error.tecnico), by = c('date', 'arduinoNumber', 'PC')) -> data

data %>%
	filter(error.tecnico == "0") %>%
	group_by(raton, date) %>%
	filter(pcTime >= hora_inicio, pcTime <= hora_termino) %>%
	ungroup() -> data

source("~/nbolab_LICKMS/lickMicroStructureFunctions.R")
data %>%
	group_by(raton, date, spoutNumber) %>%
	mutate(isReward = getIsEvent(rewardsCum),
	       isEvent = getIsEvent(eventsCum)) %>%
	ungroup()-> data

data %>%
	drop_na() %>%
	group_by(raton, date) %>%
	mutate(ms = msFromStart - msFromStart[1],
	       maxLicks = max(licksCum),
	       maxEvents = max(eventsCum),
	       maxRewards = max(rewardsCum),
	       choiceSpout = if_else(spoutNumber == 2, 1, 0),
	       msFromRandom = getmsFromEvent(randomSpout, ms),
	       msFromFixed = getmsFromEvent(!randomSpout, ms),
	       msFromReward = getmsFromEvent(isReward, ms),
	       msFromNonReward = getmsFromEvent(!isReward, ms),
	       msFromEvent = getmsFromEvent(isEvent, ms),
	       bins = cut(ms, c(seq(0, 3600000, 600000)), include.lowest = TRUE),
	       expGroup = if_else(raton %in% c(217, 219, 223, 224), 1, 0)) -> data

# basic plots
data %>%
	ggplot(aes(date, maxLicks, color = as.factor(expGroup))) +
	geom_point() +
	geom_line() +
	geom_vline(xintercept = as.numeric(as.Date("2021-05-12"))) +
	facet_wrap(~raton)

# cumlicks per day
data %>%
	filter(date >= "2021-05-13") %>%
	ggplot(aes(ms, licksCum, color = as.factor(randomSpout))) +
	geom_line(aes(linetype = as.factor(spoutNumber))) +
	labs(color = "Spout random reward", linetype = "Spout number") +
	facet_grid(raton ~ date) +
	xlab("Milliseconds from start") +
	ylab("Cummulative Licks") +
	ggtitle("0 = control, 1 = experimental")

# bin per day
data %>%
	filter(date >= "2021-05-13") %>%
	group_by(date, raton, bins, spoutNumber, randomSpout) %>%
	summarise(meanLicks = mean(licksCum),
		  sdLicks = sd(licksCum)) %>%
	ggplot(aes(as.numeric(bins), meanLicks, color = as.factor(randomSpout))) +
	geom_point() +
	geom_line(aes(linetype = as.factor(spoutNumber))) +
	facet_grid(raton ~ date)

# bins mean
data %>%
	filter(date >= "2021-05-13") %>%
	group_by(raton, bins, randomSpout) %>%
	summarise(meanLicks = mean(licksCum),
		  sdLicks = sd(licksCum)) %>%
	ggplot(aes(as.numeric(bins), meanLicks, color = as.factor(randomSpout))) +
	geom_point() +
	geom_line() +
	geom_errorbar(aes(ymin = meanLicks - sdLicks, ymax = meanLicks + sdLicks)) +
	facet_grid(~raton)

# bins choice
data %>%
	filter(date >= "2021-05-13") %>%
	filter(raton %in% c(217, 219, 223, 224)) %>%
	group_by(raton, bins) %>%
	summarise(meanChoice = mean(randomSpout),
		  sdChoice = sd(randomSpout)) %>%
	ggplot(aes(as.numeric(bins), meanChoice)) +
	geom_point() +
	geom_line() +
	geom_errorbar(aes(ymin = meanChoice - sdChoice, ymax = meanChoice + sdChoice)) +
	facet_grid(~raton)

# bins choice
data %>%
	filter(date >= "2021-05-13") %>%
	filter(raton %in% c(217, 219, 223, 224)) %>%
	group_by(raton, bins, date) %>%
	summarise(meanChoice = mean(randomSpout),
		  sdChoice = sd(randomSpout)) %>%
	ggplot(aes(as.numeric(bins), meanChoice)) +
	geom_point() +
	geom_line() +
	geom_errorbar(aes(ymin = meanChoice - sdChoice, ymax = meanChoice + sdChoice)) +
	facet_grid(raton ~ date)

# bins choice
c1 <- data %>%
	filter(date >= "2021-05-13") %>%
	filter(raton %in% c(217, 219, 223, 224)) %>%
	group_by(raton) %>%
	ggplot(aes(ms, randomSpout)) +
	geom_point() +
	geom_smooth() +
	facet_grid(~raton)
# bins choice
c2 <- data %>%
	filter(date >= "2021-05-13") %>%
	filter(!(raton %in% c(217, 219, 223, 224))) %>%
	group_by(raton) %>%
	ggplot(aes(ms, choiceSpout)) +
	geom_point() +
	geom_smooth() +
	facet_grid(~raton)
grid.arrange(c1, c2)

# events from uncertainty group
avg <-data %>%
	filter(date >= "2021-05-12") %>%
	filter(raton %in% c(217, 219, 223, 224)) %>%
	group_by(randomSpout) %>%
	summarise(meanEvents = mean(maxEvents), sdEvents = sd(maxEvents))
point <- data %>%
	filter(date >= "2021-05-12") %>%
	filter(raton %in% c(217, 219, 223, 224)) %>%
	group_by(randomSpout, raton) %>%
	summarise(meanEvents = mean(maxEvents))
point %>%
	ggplot(aes(as.factor(randomSpout), meanEvents)) +
	geom_point() +
	geom_col(data = avg, alpha = 0.3) +
	geom_errorbar(data = avg, aes(ymin = meanEvents - sdEvents, ymax = meanEvents + sdEvents))

# licks for uncertainty group
avg <-data %>%
	filter(date >= "2021-05-12") %>%
	filter(raton %in% c(217, 219, 223, 224)) %>%
	group_by(randomSpout) %>%
	summarise(meanLicks = mean(maxLicks), sdLicks = sd(maxLicks))
point <- data %>%
	filter(date >= "2021-05-12") %>%
	filter(raton %in% c(217, 219, 223, 224)) %>%
	group_by(randomSpout, raton) %>%
	summarise(meanLicks = mean(maxLicks))
point %>%
	ggplot(aes(as.factor(randomSpout), meanLicks)) +
	geom_point() +
	geom_col(data = avg, alpha = 0.3) +
	geom_errorbar(data = avg, aes(ymin = meanLicks - sdLicks, ymax = meanLicks + sdLicks))

# rewards for uncertainty group
avg <-data %>%
	filter(date >= "2021-05-12") %>%
	filter(raton %in% c(217, 219, 223, 224)) %>%
	group_by(randomSpout) %>%
	summarise(meanRewards = mean(maxRewards), sdRewards = sd(maxRewards))
point <- data %>%
	filter(date >= "2021-05-12") %>%
	filter(raton %in% c(217, 219, 223, 224)) %>%
	group_by(randomSpout, raton) %>%
	summarise(meanRewards = mean(maxRewards))
point %>%
	ggplot(aes(as.factor(randomSpout), meanRewards)) +
	geom_point() +
	geom_col(data = avg, alpha = 0.3) +
	geom_errorbar(data = avg, aes(ymin = meanRewards - sdRewards, ymax = meanRewards + sdRewards))

# group versus rewards
avg <-data %>%
	filter(date >= "2021-05-12") %>%
	group_by(expGroup) %>%
	summarise(meanRewards = mean(maxRewards), sdEvents = sd(maxRewards))
point <- data %>%
	filter(date >= "2021-05-12") %>%
		group_by(expGroup, raton) %>%
	summarise(meanRewards = mean(maxRewards))
point %>%
	ggplot(aes(as.factor(expGroup), meanRewards)) +
	geom_point() +
	geom_col(data = avg, alpha = 0.3) +
	geom_errorbar(data = avg, aes(ymin = meanRewards - sdEvents, ymax = meanRewards + sdEvents))

# group versus licks
avg <-data %>%
	filter(date >= "2021-05-12") %>%
	group_by(expGroup) %>%
	summarise(meanLicks = mean(maxLicks), sdLicks = sd(maxLicks))
point <- data %>%
	filter(date >= "2021-05-12") %>%
		group_by(expGroup, raton) %>%
	summarise(meanLicks = mean(maxLicks))
point %>%
	ggplot(aes(as.factor(expGroup), meanLicks)) +
	geom_point() +
	geom_col(data = avg, alpha = 0.3) +
	geom_errorbar(data = avg, aes(ymin = meanLicks - sdLicks, ymax = meanLicks + sdLicks))

# group versus events
avg <-data %>%
	filter(date >= "2021-05-12") %>%
	group_by(expGroup) %>%
	summarise(meanEvents = mean(maxEvents), sdEvents = sd(maxEvents))
point <- data %>%
	filter(date >= "2021-05-12") %>%
		group_by(expGroup, raton) %>%
	summarise(meanEvents = mean(maxEvents))
point %>%
	ggplot(aes(as.factor(expGroup), meanEvents)) +
	geom_point() +
	geom_col(data = avg, alpha = 0.3) +
	geom_errorbar(data = avg, aes(ymin = meanEvents - sdEvents, ymax = meanEvents + sdEvents))

