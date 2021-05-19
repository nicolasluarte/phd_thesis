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
rawData <- bind_rows(data1, data2)


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
	       ) %>% filter(date <= "2021-05-13") -> log

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
	       bins = binsMs(ms, 600000)$msBins,
	       expGroup = if_else(raton %in% c(217, 219, 223, 224), 1, 0)) -> data

# basic plots
data %>%
	ggplot(aes(date, maxLicks, color = as.factor(expGroup))) +
	geom_point() +
	geom_line() +
	geom_vline(xintercept = as.numeric(as.Date("2021-05-12"))) +
	facet_wrap(~raton)

# experimental plots
# arreglar los colores
data %>%
	filter(date >= "2021-05-13") %>%
	ggplot(aes(ms, licksCum, color = as.factor(randomSpout))) +
	geom_line(aes(linetype = as.factor(spoutNumber))) +
	labs(color = "Spout random reward", linetype = "Spout number") +
	facet_grid(raton ~ date ~ expGroup) +
	xlab("Milliseconds from start") +
	ylab("Cummulative Licks") +
	ggtitle("0 = control, 1 = experimental")

# choice by bins
p1 <- data %>%
	filter(raton %in% c(217, 219, 223, 224)) %>%
	group_by(raton, date, bins) %>%
	mutate(choice = mean(randomSpout)) %>%
	filter(date >= "2021-05-13") %>%
	ggplot(aes(bins, choice)) +
	geom_point() +
	geom_line() +
	geom_smooth() +
	facet_wrap(~raton)
p2 <- data %>%
	filter(!(raton %in% c(217, 219, 223, 224))) %>%
	group_by(raton, date, bins) %>%
	mutate(choice = mean(choiceSpout)) %>%
	filter(date >= "2021-05-13") %>%
	ggplot(aes(bins, choice)) +
	geom_point() +
	geom_line() +
	geom_smooth() +
	facet_wrap(~raton)
grid.arrange(p1, p2)

data %>%
	filter(date >= "2021-05-12") %>%
	ggplot(aes(as.factor(expGroup), maxLicks)) +
	geom_point() +
	facet_wrap(~date)

# Events per group
pointSumm <- data %>%
	filter(date >= "2021-05-12") %>%
	group_by(date, expGroup, raton) %>%
	summarise(meanLicks = unique(maxEvents))
meanSumm <- data %>%
	filter(date >= "2021-05-12") %>%
	group_by(expGroup) %>%
	summarise(meanLicks = mean(maxEvents),
	sdLicks = sd(maxEvents))
pointSumm %>%
	ggplot(aes(as.factor(expGroup), meanLicks)) +
	geom_point() +
	geom_col(data = meanSumm, alpha = 0.3) +
	geom_errorbar(data = meanSumm, aes(ymin = meanLicks - sdLicks, ymax = meanLicks + sdLicks)) +
	scale_x_discrete(labels = c("1/1", "0.5/1")) +
	xlab("Experimental groups") +
	ylab("Mean events")

# Rewards per group
pointSumm <- data %>%
	filter(date >= "2021-05-12") %>%
	group_by(date, expGroup, raton) %>%
	summarise(meanLicks = unique(maxRewards))
meanSumm <- data %>%
	filter(date >= "2021-05-12") %>%
	group_by(expGroup) %>%
	summarise(meanLicks = mean(maxRewards),
	sdLicks = sd(maxRewards))
pointSumm %>%
	ggplot(aes(as.factor(expGroup), meanLicks)) +
	geom_point() +
	geom_col(data = meanSumm, alpha = 0.3) +
	geom_errorbar(data = meanSumm, aes(ymin = meanLicks - sdLicks, ymax = meanLicks + sdLicks)) +
	scale_x_discrete(labels = c("1/1", "0.5/1")) +
	xlab("Experimental groups") +
	ylab("Mean rewards")

# Licks per group
pointSumm <- data %>%
	filter(date >= "2021-05-12") %>%
	group_by(date, expGroup, raton) %>%
	summarise(meanLicks = unique(maxLicks))
meanSumm <- data %>%
	filter(date >= "2021-05-12") %>%
	group_by(expGroup) %>%
	summarise(meanLicks = mean(maxLicks),
	sdLicks = sd(maxLicks))
pointSumm %>%
	ggplot(aes(as.factor(expGroup), meanLicks)) +
	geom_point() +
	geom_col(data = meanSumm, alpha = 0.3) +
	geom_errorbar(data = meanSumm, aes(ymin = meanLicks - sdLicks, ymax = meanLicks + sdLicks)) +
	scale_x_discrete(labels = c("1/1", "0.5/1")) +
	xlab("Experimental groups") +
	ylab("Mean number of licks")


## important
trials <- data %>%
	mutate(antiSpout = !randomSpout) %>%
	group_by(raton, date) %>%
	mutate(cEvent = cumsum(isEvent),
	       cRandom = cumsum(!randomSpout)) %>%
	ungroup() %>%
	group_by(cRandom, raton, date) %>%
	mutate(interTrial = min(ms)) %>%
	ungroup() %>%
	group_by(raton, date) %>%
	mutate(randomToFixed = (interTrial - cummax(interTrial * randomSpout)) * cummax(randomSpout),
	randomToFixed = na_if(randomToFixed, 0))

## important
trials1 <- data %>%
	mutate(antiSpout = !randomSpout) %>%
	group_by(raton, date) %>%
	mutate(cEvent = cumsum(isEvent),
	       cRandom = cumsum(!antiSpout)) %>%
	ungroup() %>%
	group_by(cRandom, raton, date) %>%
	mutate(interTrial = min(ms)) %>%
	ungroup() %>%
	group_by(raton, date) %>%
	mutate(fixedToRandom = (interTrial - cummax(interTrial * antiSpout)) * cummax(antiSpout),
	fixedToRandom = na_if(fixedToRandom, 0))

trials %>%
	ggplot(aes(randomToFixed)) +
	geom_density(aes(color = "random to fixed", y = ..scaled..)) +
	geom_density(data = trials1, aes(fixedToRandom, color = "fixed to random", y = ..scaled..))




