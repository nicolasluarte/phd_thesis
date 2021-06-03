library(tidyverse)
library(lme4)
library(lmerTest)

df <- readRDS("data.rds")

# data imputation

# model 1: treatment vs control, experimental phase, number of events
model.0 <- lmer(data = df %>% filter(condition == "post"),
		sumEvents ~ (1 | raton))
model.1 <- lmer(data = df %>% filter(condition == "post"),
		sumEvents ~ expGroup + (1 | raton))
model.2 <- lmer(data = df %>% filter(condition == "post"),
		sumLicks ~ expGroup + as.numeric(date) + (1 | raton))
model.3 <- lmer(data = df %>% filter(condition == "post"),
		sumEvents ~ expGroup * as.numeric(date) + (expGroup | raton),
		control = lmerControl(optimizer ="Nelder_Mead"))

anova(model.0, model.1, model.2)


model.4 <- lmer(data = df %>% filter(date >= "2021-05-05"),
		sumEvents ~ expGroup * condition + (1 | raton),
		control = lmerControl(optimizer = "Nelder_Mead"))
model.4 %>% summary()
