##################################################################
##                             Libs                             ##
##################################################################

library(ggplot2)
library(dplyr)
library(tidyverse)
library(zoo)

##########################################################################
##                           IMPORT FUNCTIONS                           ##
##########################################################################

source("functions.R")

##########################################################################
##                    LOAD FILES INTO DATAFRAME LIST                    ##
##########################################################################

# define path asking user
path <- rstudioapi::selectDirectory(caption = "Select folder with txt files")
# if this doesn't work assign it manually
path <- "/home/nicoluarte/phd_thesis/experimental_data/Resultados/FR Abril 2021"

# load all text files into memory
# ! make sure only relevant .txt files are present
files <- list.files(path, pattern = "*.csv", recursive = TRUE)
files

# all text files are read as tibbles, if files are already proper csv load
# file with next function
tibbleListRaw <- files %>%
        map(~ getTextIntoTibble(file.path(path, .)))

# if files are already proper csv
tibbleListRaw <- files %>% map(~ read_csv(file.path(path, .)))
tibbleListRaw

# add a column that indicates the filename
numbers <- seq(from = 1, to = length(tibbleListRaw), by = 1)
tibbleListRaw <- map2(tibbleListRaw, numbers, function(.x, .y) {
        .x %>% mutate(
                fileName = rep(files[.y], dim(.x)[1])
        )
})

# load look up table
# change this path to the correct one
lookUptablePath <- "/home/nicoluarte/phd_thesis/experimental_data/uncertainty_fr/lookUpTable.csv"
lookUpTable <- read_delim(lookUptablePath, col_names = TRUE, delim = ":")
lookUpTable

# function to filter based on filename
# keep only files that are considered in the lookUpTable
tibbleListRaw <- purrr::keep(
        tibbleListRaw,
        function(x) all(x$fileName %in% lookUpTable$fileName)
)

##################################################################
##                    Initial pre-processing                    ##
##################################################################

# remove empty tibbles
tibbleListRaw <- purrr::keep(tibbleListRaw, ~ nrow(.x) > 0)
tibbleListRaw <- map(tibbleListRaw, ~ drop_na(.))
length(tibbleListRaw)

# change headers and datatypes, skip this if data is already on proper format
headers <- c(
        "date", "pc_time", "secStart", "msStart",
        "arduino", "spout", "licksCum", "eventsCum", "fileName"
)
dataTypes <- c(
        "character", "character", "integer", "integer",
        "factor", "factor", "integer", "integer", "character"
)
tibbleListRaw <- tibbleListRaw %>%
        map(~ headersIntoList(headers, .x))
# set variables data types
tibbleListRaw <- tibbleListRaw %>% map(function(x) {
        x %>% mutate(
                secStart = as.integer(secStart),
                msStart = as.integer(msStart),
                arduino = as.factor(arduino),
                spout = as.factor(spout),
                licksCum = as.integer(licksCum),
                eventsCum = as.integer(eventsCum)
        )
})

# get animal names corresponding to each arduino
# WARNING!: code 999 means that no corresponding value was found in the lookUpTable
tibbleListRaw <- map(tibbleListRaw, function(x) {
        r <- c()
        for (i in 1:dim(x)[1]) {
                if (length(compareReturn(
                        x$fileName[i], as.integer(as.character(x$arduinoNumber[i])),
                        lookUpTable$fileName, lookUpTable$arduino,
                        lookUpTable$animalCode
                )) == 0) {
                        r[i] <- 999
                }
                else {
                        r[i] <- compareReturn(
                                x$fileName[i], as.integer(as.character(x$arduinoNumber[i])),
                                lookUpTable$fileName, lookUpTable$arduino,
                                lookUpTable$animalCode
                        )
                }
        }
        x %>% mutate(
                animalCode = r
        )
})

##################################################################
##                      Feature extraction                      ##
##################################################################

# add basic features
tibbleList <- tibbleListRaw %>%
        map(function(x) {
                x %>%
                        group_by(arduinoNumber, spoutNumber) %>%
                        mutate(
                                ms = msFromStart - msFromStart[1],
                                isEvent = getIsEvent(eventsCum),
                                isLick = getIsLick(licksCum),
                                msFromEvent = getmsFromEvent(isEvent, ms),
                                isTimeout = getIsTimeout(msFromEvent, 20000, eventsCum)
                        ) %>%
                        ungroup()
        })

# add main features to new file format
tibbleList <- tibbleList %>%
        map(function(x) {
                x %>%
                        group_by(arduinoNumber, spoutNumber, isLick) %>%
                        mutate(
                                ILI = getILI(ms)
                        ) %>%
                        ungroup()
        })

##################################################################
##                      Data visualization                      ##
##################################################################

a <- bind_rows(tibbleList)

a$fileName[which(a$animalCode == 999)]

# visualize events done by day
licks <- bind_rows(tibbleList) %>%
        filter(isLick == 1) %>%
        group_by(animalCode, fileName) %>%
        summarise(
                Licks = max(licksCum)
        ) %>%
        ungroup() %>%
        ggplot(aes(fileName, Licks, group = 1)) +
        geom_line() +
        theme(text = element_text(size = 10), axis.text.x = element_text(angle = 90, hjust = 1)) +
	ggtitle("Licks por dia por raton") +
        facet_wrap(~ as.factor(animalCode)) 

# visualize events done by day
events <- bind_rows(tibbleList) %>%
        filter(isLick == 1) %>%
        group_by(animalCode, fileName) %>%
        summarise(
                Rewards = max(eventsCum)
        ) %>%
        ungroup() %>%
        ggplot(aes(fileName, Rewards, group = 1)) +
        geom_line() +
        theme(text = element_text(size = 10), axis.text.x = element_text(angle = 90, hjust = 1)) +
	ggtitle("Eventos por dia por raton") +
        facet_wrap(~ as.factor(animalCode)) 

# visualize events done by day
rollEvents <- bind_rows(tibbleList) %>%
        filter(isLick == 1) %>%
        group_by(fileName) %>%
        summarise(
                Rewards = max(eventsCum)
        ) %>%
        ungroup() %>%
        ggplot(aes(fileName, rollmean(Rewards, 3, fill = NA), group = 1)) +
        geom_line() +
	geom_line(aes(fileName, rollapply(Rewards, width = 3, FUN = sd, fill = NA), color = "red")) +
        theme(text = element_text(size = 10), axis.text.x = element_text(angle = 90, hjust = 1)) +
	ggtitle("Roll mean: negro, Roll SD: rojo para eventos")

# visualize events done by day
rollLicks <- bind_rows(tibbleList) %>%
        filter(isLick == 1) %>%
        group_by(fileName) %>%
        summarise(
                Licks = max(licksCum)
        ) %>%
        ungroup() %>%
        ggplot(aes(fileName, rollmean(Licks, 3, fill = NA), group = 1)) +
        geom_line() +
	geom_line(aes(fileName, rollapply(Licks, width = 3, FUN = sd, fill = NA), color = "red")) +
        theme(text = element_text(size = 10), axis.text.x = element_text(angle = 90, hjust = 1)) +
	ggtitle("Roll mean: negro, Roll SD: rojo para licks")

plots <- list(licks, events, rollLicks, rollEvents)
pdf("plots.pdf")
plots
dev.off()


# visulize licks over time and if they were done in timeout or not
bind_rows(tibbleList) %>%
        filter(isLick == 1) %>%
        ggplot(aes(ms, as.factor(isLick), color = as.factor(isTimeout))) +
        geom_point(
                shape = "|",
                size = 25,
                alpha = 1 / 2,
                stroke = 0.001
        ) +
        theme_bw() +
        facet_wrap(~animalCode)

# the same but summarised
bind_rows(tibbleList) %>%
        filter(isLick == 1) %>%
        group_by(animalCode) %>%
        summarise(
                Timeout = sum(isLick & isTimeout),
                NotTimeOut = sum(isLick & !isTimeout),
                TotalLicks = sum(isLick)
        ) %>%
        ungroup() %>%
        gather("key", "value", -animalCode) %>%
        ggplot(aes(key, value, fill = key)) +
        geom_bar(stat = "identity", position = "dodge") +
        facet_wrap(~animalCode)

# visulize inter lick interval
bind_rows(tibbleList) %>%
        ggplot(aes(ms, ILI, color = as.factor(isTimeout))) +
        geom_point() +
        theme_bw() +
        facet_wrap(~animalCode)

##################################################################
##                          Statistics                          ##
##################################################################

