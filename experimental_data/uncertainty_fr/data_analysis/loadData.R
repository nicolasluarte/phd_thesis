library(tidyverse)
library(ggrepel)
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
data <- data %>%
	mutate(expGroup = if_else(raton %in% c(217, 219, 223, 224), 1, 0)) %>%
	group_by(date, raton, spoutNumber) %>%
	mutate(eventsCum = eventsCum - eventsCum[1],
		licksCum = licksCum - licksCum[1],
		rewardsCum = rewardsCum - rewardsCum[1])


dataExp <- data %>% filter(date > "2021-05-12")

dataNest <- dataExp %>%
	group_by(raton) %>%
	nest()
eventData <- dataNest %>%
	mutate(
	       events = map(data, function(x) x %>%
			    select(spoutNumber, eventsCum) %>%
			    group_by(spoutNumber) %>%
			    summarise(eventsPerSpout = max(eventsCum)) %>%
			    summarise(totalEventsPerDay = sum(eventsPerSpout))
			    ))

eventData %>%
	unnest(events) %>%
	ggplot(aes(as.factor(expGroup), totalEventsPerDay, color = as.factor(raton))) +
	geom_point()

eventData <- dataNest %>%
	mutate(
	       events = map(data, function(x) x %>%
			    select(date, spoutNumber, eventsCum) %>%
			    group_by(date, spoutNumber) %>%
			    summarise(eventsPerSpout = max(eventsCum)) %>%
			    summarise(totalEventsPerDay = sum(eventsPerSpout))
			    ),
	       eventsPerSpout = map(data, function(x) x %>%
			    select(date, spoutNumber, randomSpout, eventsCum, expGroup) %>%
			    group_by(date, spoutNumber, randomSpout, expGroup) %>%
			    summarise(eventsPerSpout = max(eventsCum))
			    ),
		meanEvents = map(events, function(x) x %>%
				 summarise(meanEvents = mean(totalEventsPerDay))),
		experimentalGroup = map(data, function(x) x %>%
					select(expGroup) %>% unique()))

miceEvents <- eventData %>%
	select(meanEvents, experimentalGroup) %>%
	unnest(cols = c(meanEvents, experimentalGroup))
groupEvents <- eventData %>%
	select(meanEvents, experimentalGroup) %>%
	unnest(cols = c(meanEvents, experimentalGroup)) %>%
	group_by(expGroup) %>%
	summarise(groupEvents = mean(meanEvents),
	semEvents = sd(meanEvents) / sqrt(4))

# plot 1
groupEvents %>%
	ggplot(aes(as.factor(expGroup), groupEvents)) +
	geom_col() +
	geom_errorbar(aes(ymin = groupEvents - semEvents,
			  ymax = groupEvents + semEvents)) +
	geom_point(data = miceEvents,
		   aes(as.factor(expGroup), meanEvents)) +
	geom_label_repel(data = miceEvents, aes(as.factor(expGroup), meanEvents, label = raton)) +
	theme_bw() +
	xlab("Group") +
	ylab("Mean events") +
	scale_x_discrete(labels = c("Control", "Random"))
ggsave("plot1.png")

miceSpout <- eventData %>%
	select(eventsPerSpout) %>%
	unnest(cols = c(eventsPerSpout))

miceSpout2 <- eventData %>%
	select(eventsPerSpout) %>%
	unnest(cols = c(eventsPerSpout)) %>%
	group_by(raton, randomSpout, spoutNumber, expGroup) %>%
	summarise(eventsPerSpout = mean(eventsPerSpout))
miceSpout3 <- eventData %>%
	select(eventsPerSpout) %>%
	unnest(cols = c(eventsPerSpout)) %>%
	group_by(raton, randomSpout, expGroup) %>%
	summarise(eventsPerSpout = mean(eventsPerSpout))

miceSpoutControl <- miceSpout %>%
	filter(expGroup == 0) %>%
	group_by(spoutNumber) %>%
	summarise(meanEvents = mean(eventsPerSpout), 
	semEvents = sd(eventsPerSpout) / sqrt(4))
miceSpoutExp <- miceSpout %>%
	filter(expGroup == 1) %>%
	group_by(randomSpout) %>%
	summarise(meanEvents = mean(eventsPerSpout), 
	semEvents = sd(eventsPerSpout) / sqrt(4))

miceSpoutExp2 <- miceSpout %>%
	filter(expGroup == 1) %>%
	group_by(spoutNumber) %>%
	summarise(meanEvents = mean(eventsPerSpout), 
	semEvents = sd(eventsPerSpout) / sqrt(4))

spoutNames <- list('0' = 'left', '1' = 'right')

# plot 2
c1 <- miceSpoutControl %>%
	ggplot(aes(as.factor(spoutNumber), meanEvents, fill = as.factor(spoutNumber))) +
	geom_col() +
	geom_errorbar(aes(ymin = meanEvents - semEvents,
			  ymax = meanEvents + semEvents)) +
	geom_point(data = miceSpout2 %>% filter(expGroup == 0),
		   aes(as.factor(spoutNumber), eventsPerSpout)) +
	geom_label_repel(data = miceSpout2 %>% filter(expGroup == 0),
		aes(as.factor(spoutNumber), eventsPerSpout, label = raton)) +
	ylim(c(0, 50)) +
	theme_bw() +
	xlab("Spout number") +
	ylab("Mean events per Session") +
	ggtitle("Control group events per spout")
c2 <- miceSpoutExp %>%
	ggplot(aes(as.factor(randomSpout), meanEvents, fill = as.factor(randomSpout))) +
	geom_col() +
	geom_errorbar(aes(ymin = meanEvents - semEvents,
			  ymax = meanEvents + semEvents)) +
	geom_point(data = miceSpout3 %>% filter(expGroup == 1),
		   aes(as.factor(randomSpout), eventsPerSpout)) +
	geom_label_repel(data = miceSpout3 %>% filter(expGroup == 1),
		aes(as.factor(randomSpout), eventsPerSpout, label = raton)) +
	ylim(c(0, 50)) +
	theme_bw() +
	scale_x_discrete(labels = c("P = 1", "P = 0.5")) +
	xlab("Spout type") +
	ylab("Mean events per Session") +
	ggtitle("Random reward group events per spout type") 
c3 <- miceSpoutExp2 %>%
	ggplot(aes(as.factor(spoutNumber), meanEvents, fill = as.factor(spoutNumber))) +
	geom_col() +
	geom_errorbar(aes(ymin = meanEvents - semEvents,
			  ymax = meanEvents + semEvents)) +
	geom_point(data = miceSpout2 %>% filter(expGroup == 1),
		   aes(as.factor(spoutNumber), eventsPerSpout)) +
	geom_label_repel(data = miceSpout2 %>% filter(expGroup == 1),
		aes(as.factor(spoutNumber), eventsPerSpout, label = raton)) +
	ylim(c(0, 50)) +
	theme_bw() +
	xlab("Spout number") +
	ylab("Mean events per Session") +
	ggtitle("Random reward group events per spout")
c4 <- miceSpoutExp %>%
	ggplot(aes(as.factor(randomSpout), meanEvents, fill = as.factor(randomSpout))) +
	geom_col() +
	geom_errorbar(aes(ymin = meanEvents - semEvents,
			  ymax = meanEvents + semEvents)) +
	geom_point(data = miceSpout2 %>% filter(expGroup == 1),
		   aes(as.factor(randomSpout), eventsPerSpout)) +
	geom_label_repel(data = miceSpout2 %>% filter(expGroup == 1),
		aes(as.factor(randomSpout), eventsPerSpout, label = raton)) +
	ylim(c(0, 50)) +
	theme_bw() +
	scale_x_discrete(labels = c("P = 1", "P = 0.5")) +
	xlab("Spout type") +
	ylab("Mean events per Session") +
	ggtitle("Random reward group events per spout x spout type") +
	facet_grid(~as.factor(spoutNumber))
g <- grid.arrange(c1, c2, c4, ncol = 2)
ggsave("plot2.png", g, width = 20)




data <- data %>%
	mutate(condition = if_else(date >= "2021-05-12", 1, 0))
dataNestAll <- data %>%
	filter(date >= "2021-05-05", date < "2021-05-24") %>%
	group_by(condition, expGroup) %>%
	nest()
eventDataAll <- dataNestAll %>%
	mutate(
	       events = map(data, function(x) x %>%
			    select(raton, date, spoutNumber, eventsCum) %>%
			    group_by(raton, date, spoutNumber) %>%
			    summarise(eventsPerSpout = max(eventsCum)) %>%
			    summarise(totalEventsPerDay = sum(eventsPerSpout))),
		meanEvents = map(events, function(x) x %>%
				 summarise(meanEvents = mean(totalEventsPerDay),
					   semEvents = sd(totalEventsPerDay) / sqrt(4))),
	        licks = map(data, function(x) x %>%
			select(raton, date, spoutNumber, licksCum) %>%
			group_by(raton, date, spoutNumber) %>%
			summarise(licksPerSpout = max(licksCum)) %>%
			summarise(totalLicksPerDay = sum(licksPerSpout))),
		meanLicks = map(licks, function(x) x %>%
			summarise(meanLicks = mean(totalLicksPerDay),
				  semLicks = sd(totalLicksPerDay) / sqrt(4)))
		)


miceEventsAll <- eventDataAll %>%
	select(meanEvents) %>%
	unnest(cols = c(meanEvents))
groupEventsAll <- miceEventsAll %>%
	group_by(condition, expGroup) %>%
	summarise(groupEvents = mean(meanEvents),
	semEvents = sd(meanEvents) / sqrt(4))

miceLicksAll <- eventDataAll %>%
	select(meanLicks) %>%
	unnest(cols = c(meanLicks))
groupLicksAll <- miceLicksAll %>%
	group_by(condition, expGroup) %>%
	summarise(groupLicks = mean(meanLicks),
	semEvents = sd(meanLicks) / sqrt(4))

miceEventsAll %>%
	ggplot(aes(condition,
		   meanEvents)) +
	geom_point() +
	geom_line(aes(color = as.factor(raton))) +
	geom_label_repel(aes(label = raton)) +
	scale_x_continuous("Control (0) / Random (1) groups",
			   breaks = c(0, 1),
			   label = c("Pre", "Post")) +
	ylab("Mean number of events") +
	facet_wrap(~as.factor(expGroup)) 
ggsave("plot3.png")


groupEventsAll %>%
	ggplot(aes(condition,
		   groupEvents)) +
	geom_point() +
	geom_line() +
	geom_errorbar(aes(ymin = groupEvents - semEvents,
			  ymax = groupEvents + semEvents)) +
	facet_wrap(~expGroup)


eventData %>%
	unnest(cols = c(events)) %>%
	select(raton, date, totalEventsPerDay) %>%
	ggplot(aes(date, totalEventsPerDay)) +
	geom_line() +
	facet_wrap(~raton)


dataNest2 <- data %>%
	group_by(raton, date, expGroup, condition) %>%
	nest()

EVENT <- dataNest2 %>%
	mutate(
	       events = map(data, function(x) x %>%
			    select(spoutNumber, eventsCum) %>%
			    group_by(spoutNumber) %>%
			    summarise(eventsPerSpout = max(eventsCum)) %>%
			    summarise(totalEventsPerDay = sum(eventsPerSpout))
			    ))

EVENT %>%
	unnest(cols = c(events)) %>%
	ggplot(aes(condition, totalEventsPerDay)) +
	geom_point() +
	facet_wrap(~expGroup)


dataNest <- dataExp %>%
	group_by(raton, date, expGroup) %>%
	nest()
perDay <- dataNest %>%
	mutate(
	       events = map(data, function(x) x %>%
			    select(spoutNumber, eventsCum) %>%
			    group_by(spoutNumber) %>%
			    summarise(eventsPerSpout = max(eventsCum)) %>%
			    summarise(totalEventsPerDay = sum(eventsPerSpout))),
	       )

perDay <- perDay %>%
	unnest(events) %>%
	group_by(expGroup, date) %>%
	nest()

perDay <- perDay %>%
	mutate(
	       meanEvents = map(data, function(x) x %>%
	       summarise(meanEvents = mean(totalEventsPerDay),
			 semEvents = sd(totalEventsPerDay)/sqrt(4)))
	       )

perDay %>%
	unnest(meanEvents) %>%
	ggplot(aes(date, meanEvents, color = as.factor(expGroup))) +
	geom_point() +
	geom_errorbar(aes(ymin = meanEvents - semEvents,
			  ymax = meanEvents + semEvents)) +
	geom_line() +
	scale_color_manual(labels = c("Control", "Random reward"), values = c("blue", "red"))
ggsave("plot4.png")


