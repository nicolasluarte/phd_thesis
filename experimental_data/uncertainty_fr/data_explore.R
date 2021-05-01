library(purrr)
library(ggrepel)
library(ggplot2)
library(tidyverse)
library(readxl)
library(markovchain)

rawData <- read_excel("/home/nicoluarte/phd_thesis/experimental_data/Resultados/FR Abril 2021/FR5\ SAC／FR5\ SAC\ ABRIL\ 2021.xlsx")
rawData <- rawData %>%
        mutate(
                eventosSpout0 = (eventos_fin_sacarosa_beb_0 - eventos_inicio_sacarosa_beb_0),
                eventosSpout2 = (eventos_fin_sacarosa_beb_2 - eventos_inicio_sacarosa_beb_2),
                licksSpout0 = (licks_fin_sacarosa_beb_0 - licks_inicio_sacarosa_beb_0),
                licksSpout2 = (licks_fin_sacarosa_beb_2 - licks_inicio_sacarosa_beb_2),
                mL_sacarosa_consumidos_beb_0 = as.numeric(gsub(",", ".", mL_sacarosa_consumidos_beb_0)),
                mL_sacarosa_consumidos_beb_2 = as.numeric(gsub(",", ".", mL_sacarosa_consumidos_beb_2))
        ) %>%
        select(dia, ARDUINO, raton, eventosSpout0, eventosSpout2, licksSpout0, licksSpout2, mL_sacarosa_consumidos_beb_0, mL_sacarosa_consumidos_beb_2, COM) %>%
        drop_na()

## check problems
rawData %>% ggplot(aes(mL_sacarosa_consumidos_beb_0, eventosSpout0)) + geom_point() + facet_wrap(~COM)
rawData %>% ggplot(aes(mL_sacarosa_consumidos_beb_2, eventosSpout2)) + geom_point() + facet_wrap(~COM)

rawData %>% ggplot(aes(mL_sacarosa_consumidos_beb_0)) + geom_bar() + facet_wrap(~raton)
rawData %>% ggplot(aes(mL_sacarosa_consumidos_beb_2, eventosSpout2)) + geom_point() + facet_wrap(~raton)

rawData %>% ggplot(aes(COM, ARDUINO)) + geom_point()

rawData %>%
        group_by(raton) %>% 
        summarise(total = sum(mL_sacarosa_consumidos_beb_0) + sum(mL_sacarosa_consumidos_beb_2)) %>%
        ggplot(aes(as.factor(raton), total)) +
        geom_point()



# events
longDataEvents <- rawData %>%
        gather("key", "value", c(eventosSpout0, eventosSpout2, licksSpout0, licksSpout2))

p1 <- longDataEvents %>%
        filter(key == "eventosSpout2" | key == "eventosSpout0") %>%
        ggplot(aes(key, value, color = as.factor(raton))) +
        geom_point() +
        geom_label_repel(aes(label = raton)) +
        theme_bw() +
        facet_wrap(~dia) +
        ggtitle("Eventos por estacion")

p2 <- longDataEvents %>%
        filter(key == "eventosSpout2" | key == "eventosSpout0") %>%
        ggplot(aes(dia, value, color = as.factor(key))) +
        geom_point() +
        geom_line() +
        theme_bw() +
        facet_wrap(~raton) +
        ggtitle("Eventos por estacion")

p3 <- longDataEvents %>%
        filter(key == "eventosSpout2" | key == "eventosSpout0") %>%
        ggplot(aes(key, value, color = as.factor(dia))) +
        geom_jitter(width = 0.1) +
        theme_bw() +
        facet_wrap(~raton) +
        ggtitle("Eventos por estacion por raton por dia")

# licks
p4 <- longDataEvents %>%
        filter(key == "licksSpout0" | key == "licksSpout2") %>%
        ggplot(aes(key, value, color = as.factor(raton))) +
        geom_point() +
        geom_label_repel(aes(label = raton)) +
        theme_bw() +
        facet_wrap(~dia) +
        ggtitle("licks por estacion")

p5 <- longDataEvents %>%
        filter(key == "licksSpout0" | key == "licksSpout2") %>%
        ggplot(aes(dia, value, color = as.factor(key))) +
        geom_point() +
        geom_line() +
        theme_bw() +
        facet_wrap(~raton) +
        ggtitle("licks por estacion")

p6 <- longDataEvents %>%
        filter(key == "licksSpout0" | key == "licksSpout2") %>%
        ggplot(aes(key, value, color = as.factor(dia))) +
        geom_jitter(width = 0.1) +
        theme_bw() +
        facet_wrap(~raton) +
        ggtitle("licks por estacion por raton por dia")

p1
p2
p3
p4
p5
p6
plots <- list(p1, p2, p3, p4, p5, p6)
pdf("exploratory_plots.pdf")
plots
dev.off()

#################################################################
##                        Markov chains                        ##
#################################################################

path <- "/home/nicoluarte/phd_thesis/experimental_data/Resultados/FR Abril 2021/"
files <- dir(path, pattern = "*.csv")
markovDf <- files %>% map(~ read_csv(file.path(path, .)))
head(markovDf)

spoutSequences <- markovDf[[6]] %>%
        split(.$arduinoNumber) %>%
        map(pull, spoutNumber)

# null hypothesis is the markov property
map(spoutSequences, verifyMarkovProperty)

transitionMat <- spoutSequences %>%
	map(function(x) createSequenceMatrix(x, toRowProbs = TRUE))

markovChain  <- new("markovchain", transitionMatrix = transitionMat[[1]], name = "X")
plot(markovChain)

steadyStates(markovChain)

