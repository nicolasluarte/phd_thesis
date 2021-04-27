library(ggplot2)
library(tidyverse)

df <- read.csv("/home/nicoluarte/phd_thesis/experimental_data/uncertainty_fr/experimental_log_2642021_135836.csv")

df %>% ggplot(aes(msFromStart, licksCum, color = as.factor(spoutNumber))) +
	geom_point() +
	geom_line() +
	facet_wrap(~arduinoNumber)
