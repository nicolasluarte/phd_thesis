library(tidyverse)
library(ggrepel)
library(gridExtra)
library(rstatix)
library(ggpubr)

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

nestedData <- nestedData %>%
	unnest(cols = c(eventsPerSpout,
			licksPerSpout,
			rewardsPerSpout)) %>%
	group_by(date, raton) %>%
	nest() %>%
	mutate(
	       sumEvents = map(data, function(x) x %>%
	       summarise(sumEvents = sum(eventsPerSpout))),
	       sumLicks = map(data, function(x) x %>%
	       summarise(sumLicks = sum(licksPerSpout))),
	       sumRewards = map(data, function(x) x %>%
	       summarise(sumRewards = sum(rewardsPerSpout))),
	       ) %>%
	unnest(cols = c(data,
			sumEvents,
			sumLicks,
			sumRewards))

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

nestedData %>%
	filter(condition == 1) %>%
	aov(eventsPerSpout ~ expGroup, .) %>%
	tidy()

plotData <- nestedData %>%
	filter(condition == 1) %>%
	nest(data = c(-sumEvents,
		      -sumLicks,
		      -sumRewards,
		      -expGroup,
		      -date))
p1 <- ggerrorplot(plotData,
	  x = "expGroup",
	  y = "sumEvents",
          color = "expGroup",
	  palette = "jco",
          add = "jitter",
	  desc_stat = "mean_sd",
	  add.params = list(color = "darkgray")) +
	stat_compare_means(method = "t.test") +
	scale_x_discrete(labels = c("control", "treatment")) +
	xlab("") +
	ylab("Total events per session") +
	theme(legend.position = "none")
p2 <- ggerrorplot(plotData,
	  x = "expGroup",
	  y = "sumLicks",
          color = "expGroup",
	  palette = "jco",
          add = "jitter",
	  desc_stat = "mean_sd",
	  add.params = list(color = "darkgray")) +
	stat_compare_means(method = "t.test") +
	scale_x_discrete(labels = c("control", "treatment")) +
	xlab("") +
	ylab("Total licks per session") +
	theme(legend.position = "none")
p3 <- ggerrorplot(plotData,
	  x = "expGroup",
	  y = "sumRewards",
          color = "expGroup",
	  palette = "jco",
          add = "jitter",
	  desc_stat = "mean_sd",
	  add.params = list(color = "darkgray")) +
	stat_compare_means(method = "t.test") +
	scale_x_discrete(labels = c("control", "treatment")) +
	xlab("") +
	ylab("Total rewards per session") +
	theme(legend.position = "none")
g1 <- grid.arrange(p1, p2, p3)
ggsave("grid1.png", g1)

plotData %>% aov(sumEvents ~ as.factor(expGroup) * as.factor(date), .) %>% summary()
plotData %>% aov(sumLicks ~ as.factor(expGroup) * as.factor(date), .) %>% tidy()
plotData %>% aov(sumLicks ~ as.factor(expGroup), .) %>% TukeyHSD()
plotData %>% aov(sumRewards ~ as.factor(expGroup), .) %>% TukeyHSD()

nestedData %>% filter(condition == 1,
		      date > "2021-05-24") %>%
aov(sumEvents ~ as.factor(expGroup) * as.factor(date), .) %>% TukeyHSD()

plotData <- nestedData %>%
	filter(condition == 1) %>%
	group_by(raton, expGroup) %>%
	nest() %>%
	mutate(
	       meanEvents = map(data, function(x) x %>%
	       summarise(meanEvents = mean(sumEvents))),
	       meanLicks = map(data, function(x) x %>%
	       summarise(meanLicks = mean(sumLicks))),
	       meanRewards = map(data, function(x) x %>%
	       summarise(meanRewards = mean(sumRewards))),
	       ) %>%
	unnest(c(meanEvents, meanLicks, meanRewards))
p1 <- ggerrorplot(plotData,
	  x = "expGroup",
	  y = "meanEvents",
          color = "expGroup",
          add = "jitter",
	  palette = "jco",
	  desc_stat = "mean_sd",
	  add.params = list(color = "darkgray")) +
	stat_compare_means(method = "t.test") +
	scale_x_discrete(labels = c("control", "treatment")) +
	xlab("") +
	ylab("Total events per session") +
	theme(legend.position = "none")
p2 <- ggerrorplot(plotData,
	  x = "expGroup",
	  y = "meanLicks",
          color = "expGroup",
	  palette = "jco",
          add = "jitter",
	  desc_stat = "mean_sd",
	  add.params = list(color = "darkgray")) +
	stat_compare_means(method = "t.test") +
	scale_x_discrete(labels = c("control", "treatment")) +
	xlab("") +
	ylab("Total licks per session") +
	theme(legend.position = "none")
p3 <- ggerrorplot(plotData,
	  x = "expGroup",
	  y = "meanRewards",
          color = "expGroup",
	  palette = "jco",
          add = "jitter",
	  desc_stat = "mean_sd",
	  add.params = list(color = "darkgray")) +
	stat_compare_means(method = "t.test") +
	scale_x_discrete(labels = c("control", "treatment")) +
	xlab("") +
	ylab("Total rewards per session") +
	theme(legend.position = "none")
g2 <- grid.arrange(p1, p2, p3)
ggsave("grid2.png", g2)


ggerrorplot(nestedData %>% filter(expGroup == 0,
				  condition == 1) %>%
	    mutate(spoutNumber = as.factor(spoutNumber)),
	  x = "spoutNumber",
	  y = "eventsPerSpout",
          color = "spoutNumber",
	  palette = "jco",
          add = "jitter",
	  desc_stat = "mean_sd",
	  add.params = list(color = "darkgray")) +
	stat_compare_means(method = "t.test", paired = TRUE) +
	scale_x_discrete(labels = c("Left", "Right")) +
	xlab("") +
	ylab("Total events per session") +
	theme(legend.position = "none")

ggerrorplot(nestedData %>% filter(expGroup == 1,
				  condition == 1) %>%
	    mutate(randomSpout = as.factor(randomSpout)),
	  x = "randomSpout",
	  y = "eventsPerSpout",
          color = "randomSpout",
	  palette = "jco",
          add = "jitter",
	  desc_stat = "mean_sd",
	  add.params = list(color = "darkgray")) +
	stat_compare_means(method = "t.test", paired = TRUE) +
	scale_x_discrete(labels = c("p = 1", "p = 0.5")) +
	xlab("") +
	ylab("Total events per session") +
	theme(legend.position = "none")

variable <- nestedData %>% filter(expGroup == 1, randomSpout == 0, condition == 1) %>% select(eventsPerSpout)
fixed <- nestedData %>% filter(expGroup == 1, randomSpout == 1, condition == 1) %>% select(eventsPerSpout)
t.test(variable$eventsPerSpout, fixed$eventsPerSpout, paired = TRUE)

ggerrorplot(nestedData %>% filter(expGroup == 1,
				  condition == 1) %>%
	    mutate(randomSpout = as.factor(randomSpout)),
	  x = "randomSpout",
	  y = "eventsPerSpout",
          color = "randomSpout",
	  palette = "jco",
          add = "jitter",
	  desc_stat = "mean_sd",
	  add.params = list(color = "darkgray")) +
	scale_x_discrete(labels = c("p = 1", "p = 0.5")) +
	xlab("") +
	ylab("Total events per session") +
	theme(legend.position = "none") +
	facet_wrap(~spoutNumber)

nestedData %>% filter(expGroup == 1, condition == 1) %>%
	mutate(
	       randomSpout = recode_factor(as.factor(randomSpout),
	       `0` = "fixed", `1` = "variable"),
	       spoutNumber = recode_factor(as.factor(spoutNumber),
	       `0` = "left", `2` = "right")
	       ) %>%
	aov(eventsPerSpout ~ as.factor(randomSpout) * as.factor(spoutNumber), .) %>%
	TukeyHSD()

ggpaired(nestedData %>%
	    filter(date > "2021-05-05") %>%
	    mutate(condition = as.factor(condition),
		   expGroup = recode_factor(as.factor(expGroup),
					    `0` = "control",
					    `1` = "treatment"),
		   raton = as.factor(raton)) %>%
	    group_by(condition, raton, expGroup) %>%
	    summarise(sumEvents = mean(sumEvents)),
	  x = "condition",
	  y = "sumEvents",
	  fill = "condition", 
	  palette = "jco",
	  label = "raton",
          add = "jitter",
	  desc_stat = "mean_sd",
	  add.params = list(color = "darkgray")) +
	stat_compare_means(method = "t.test") +
	scale_x_discrete(labels = c("pre", "post")) +
	xlab("") +
	ylab("Total events per session") +
	theme(legend.position = "none") +
	facet_wrap(~expGroup)

prePostData <- nestedData %>%
	filter(
	       date >= "2021-05-05" & date < "2021-05-12" | date >= "2021-05-20"
	       ) %>%
	group_by(date, raton, sumEvents, expGroup, condition) %>%
	nest() %>%
	mutate(
	       expGroup = recode_factor(as.factor(expGroup),
					    `0` = "control",
					    `1` = "treatment"),
	       condition = recode_factor(as.factor(condition), `0` = "pre", `1` = "post"))
ggerrorplot(
	  prePostData,
	  x = "condition",
	  y = "sumEvents",
	  palette = "jco",
	  add.params = list(color = "gray"),
	  add = "jitter",
	  desc_stat = "mean_sd",
	  line.color = "gray",
	  facet.by = "expGroup"
	  ) +
	scale_x_discrete(labels = c("pre", "post")) +
	xlab("") +
	ylab("Total events per session") +
	theme(legend.position = "none")

prePostData %>%
	aov(sumEvents ~ condition * expGroup, .) %>%
	TukeyHSD()

prePostData %>% 
	aov(sumEvents ~ expGroup * condition, .) %>%
	TukeyHSD() %>%
	tidy()

nestedData2 <- nestedData %>%
	filter(
	       date >= "2021-05-05" & date < "2021-05-12" | date >= "2021-05-20"
	       ) %>%
	mutate(
	       expGroup = recode_factor(as.factor(expGroup),
					    `0` = "control",
					    `1` = "treatment"),
	       condition = recode_factor(as.factor(condition), `0` = "pre", `1` = "post"))

ggpaired(nestedData2 %>%
	    filter(date > "2021-05-05") %>%
	    mutate(condition = as.factor(condition),
		   expGroup = recode_factor(as.factor(expGroup),
					    `0` = "control",
					    `1` = "treatment"),
		   raton = as.factor(raton)) %>%
	    group_by(condition, raton, expGroup) %>%
	    summarise(sumEvents = mean(sumEvents)),
	  x = "condition",
	  y = "sumEvents",
	  fill = "condition", 
	  palette = "jco",
	  label = "raton",
          add = "jitter",
	  desc_stat = "mean_sd",
	  add.params = list(color = "darkgray")) +
	scale_x_discrete(labels = c("pre", "post")) +
	xlab("") +
	ylab("Total events per session") +
	theme(legend.position = "none") +
	facet_wrap(~expGroup)


ll <- data %>%
	group_by(raton, expGroup, condition, date, randomSpout, spoutNumber) %>%
	mutate(
	       randomSpout = recode_factor(as.factor(randomSpout), `0` = "fixed", `1` = "random"),
	       spoutNumber = recode_factor(as.factor(spoutNumber), `0` = "left", `2` = "right")
	       ) %>%
	nest() %>%
	mutate(
	       nonValidLick =
	       map(data, function(x) x %>%
	       summarise(nonValidLick = mean(isTimeoutThreshold)))
	       ) %>%
	unnest(nonValidLick)
ggerrorplot(
	  ll %>% filter(condition == 1, expGroup == 1),
	  x = "randomSpout",
	  y = "nonValidLick",
	  palette = "jco",
	  add.params = list(color = "gray"),
	  add = "jitter",
	  desc_stat = "mean_sd",
	  line.color = "gray"
	  ) +
	scale_x_discrete(labels = c("p = 1", "p = 0.5")) +
	xlab("") +
	ylab("Probability of making licks in time out") +
	theme(legend.position = "none")

ll %>%
	filter(condition == 1, expGroup == 1) %>%
	aov(nonValidLick ~ as.factor(randomSpout), .) %>%
	TukeyHSD()

ll %>%
	filter(condition == 1) %>%
	aov(nonValidLick ~ as.factor(expGroup), .) %>%
	TukeyHSD()

ll %>%
	filter(condition == 1, expGroup == 1) %>%
	aov(nonValidLick ~ as.factor(randomSpout) * as.factor(spoutNumber), .) %>%
	TukeyHSD()
