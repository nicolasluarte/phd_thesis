library(tidyverse)

# load files
dataDir1 <- "~/phd_thesis/experimental_data/uncertainty_fr/data/data_raw/1"
dataDir2 <- "~/phd_thesis/experimental_data/uncertainty_fr/data/data_raw/2"
csv1 <- fs::dir_ls(dataDir1, regexp = "\\.csv$")
csv2 <- fs::dir_ls(dataDir2, regexp = "\\.csv$")
data1 <- csv1 %>%
	map(read_csv)
data2 <- csv2 %>%
	map(read_csv)

# drop empty files add column to tell from which pc data comes from
data1 <- purrr::keep(data1, ~ nrow(.x) > 0) %>% map(function(x) x %>% mutate(PC = 1))
data2 <- purrr::keep(data2, ~ nrow(.x) > 0) %>% map(function(x) x %>% mutate(PC = 2))

df <- c(data1, data2) %>% 
	map(function(x) x %>%
	mutate(
	       date = lubridate::ymd(date),
	       pcTime = strptime(pcTime, format = "%H%M%S"),
	       pcTime = lubridate::hms(paste(lubridate::hour(pcTime),
					     lubridate::minute(pcTime),
					     lubridate::second(pcTime), sep = ":"))
	       )
	) %>%
	bind_rows()

# clean out test trials
log <- read_csv("~/phd_thesis/experimental_data/uncertainty_fr/data/log/log.csv")
names(log) <- make.names(names(log), unique=TRUE)
log %>%
	mutate(date = lubridate::ymd(fecha),
	       hora_inicio = lubridate::hms(hora_inicio),
	       hora_termino = lubridate::hms(hora_termino),
	       error.tecnico = replace_na(error.tecnico, 0),
	       arduinoNumber = ARDUINO
	       ) %>%
	filter(date >= "2021-04-01") -> log

df %>% filter(date %in% log$date) -> df

df %>%
	left_join(log %>%
		  select(date,
			 arduinoNumber,
			 raton,
			 hora_inicio,
			 hora_termino,
			 PC,
			 error.tecnico), by = c('date', 'arduinoNumber', 'PC')) -> df

df %>%
	filter(error.tecnico == "0") %>%
	group_by(raton, date) %>%
	filter(pcTime >= hora_inicio, pcTime <= hora_termino) %>%
	ungroup() -> df

# add groups
df %>%
	mutate(expGroup = if_else(raton %in% c(217, 219, 223, 224), 1, 0)) %>%
	group_by(date, raton, spoutNumber) %>%
	mutate(eventsCum = eventsCum - eventsCum[1],
		licksCum = licksCum - licksCum[1],
		rewardsCum = rewardsCum - rewardsCum[1]) %>%
	ungroup() %>%
	group_by(date, raton) %>%
	mutate(
	       msFromStart = msFromStart - msFromStart[1]
	       ) %>%
	ungroup() -> df

# add is event, reward, events per spout, rewards per spout
df %>%
	group_by(date, raton, spoutNumber) %>%
	mutate(
	       isEvent = diff(c(0, eventsCum)),
	       isReward = diff(c(0, rewardsCum)),
	       eventsPerSpout = sum(isEvent),
	       rewardsPerSpout = sum(isReward),
	       licksPerSpout = n()
	       ) %>%
	ungroup() %>%
	group_by(date, raton) %>%
	mutate(
	       sumEvents = sum(isEvent),
	       sumRewards = sum(isReward),
	       sumLicks = n()
	       ) -> df

# ms from events
df %>%
	group_by(date, raton, spoutNumber, eventsCum) %>%
	mutate(msFromEvents = msFromStart - min(msFromStart)) -> df

# rewarded a non-rewarded events
df %>%
	group_by(date, raton, spoutNumber, eventsCum) %>%
	mutate(rewardedTrial = max(isReward)) -> df

# ILI
df %>%
	group_by(date, raton, spoutNumber) %>%
	mutate(ILI = diff(c(0, msFromStart))) %>%
	ungroup() -> df

# time out
df %>% group_by(date, raton, spoutNumber) %>%
	mutate(isTimeout = if_else(msFromEvents < 20000, "impulsive", "not_impulsive"),
		isTimeoutThreshold = if_else(msFromEvents <= 1000 | msFromEvents >= 20000, "not_impulsive", "impulsive")) -> df

# re-encode variables
df %>%
	mutate(
	condition = if_else(date >= "2021-05-12", 1, 0),
	condition = recode_factor(as.factor(condition), `0` = "pre", `1` = "post"), 
	expGroup = recode_factor(as.factor(expGroup), `0` = "control", `1` = "treatment"),
	spoutNumber = recode_factor(as.factor(spoutNumber), `0` = "left", `2` = "right"),
	randomSpout = recode_factor(as.factor(randomSpout), `0` = "fixed", `1` = "variable"),
	PC = as.factor(PC),
	isTimeout = as.factor(isTimeout),
	isTimeoutThreshold = as.factor(isTimeoutThreshold),
	raton = as.factor(raton),
	) -> df

# function to transform date to sessions
date2s <- function(date.vec) {
sort(date.vec) %>%
	diff() %>%
	{ if_else(. > 0, 1, 0) } %>%
	cumsum() -> session
session <- c(1,session + 1)
return(session)
}
df <- df[order(df$date),]
df$session <- date2s(df$date)

df %>% saveRDS(., "data.rds")
