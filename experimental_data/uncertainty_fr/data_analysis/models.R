library(tidymodels)
library(lme4)
library(lmerTest)
library(sjPlot)
library(sjmisc)

df <- readRDS("data.rds")

# function to transform date to sessions
date2s <- function(date.vec) {
	sort(date.vec) %>%
		as.numeric() %>%
		diff() %>%
		{ if_else(. > 0, 1, 0) } %>%
		cumsum() -> sessions
	return(c(1, sessions + 1))
}
df %>%
	mutate(session = date2s(date)) -> df

model.0 <- lmer(data = df %>% filter(date >= "2021-05-05"),
	sumEvents ~ expGroup * condition + (1 | raton))
summary(model.0)

model.1 <- lmer(data = df %>% filter(date >= "2021-05-05"),
	sumEvents ~ expGroup * condition + (session | raton))
summary(model.1)

model.2 <- lmer(data = df %>% filter(date >= "2021-05-05"),
	sumEvents ~ expGroup * condition * session + (1 | raton))

model.3 <- lmer(data = df %>% filter(date >= "2021-05-05"),
	sumLicks ~ expGroup * condition * session + (session | raton),
control = lmerControl(optimizer = "Nelder_Mead"))

model.4 <- lmer(data = df %>% filter(date >= "2021-05-05"),
	sumEvents ~ expGroup * condition  + (1 | raton),
control = lmerControl(optimizer = "Nelder_Mead"))

model.5 <- lmer(data = df %>% filter(date >= "2021-05-05"),
	sumLicks ~ expGroup * condition  + (1 | raton) + (1 | condition),
control = lmerControl(optimizer = "Nelder_Mead"))



plot_model(model.1, type = "pred", terms = c("session", "expGroup", "condition"))
plot_model(model.3, type = "pred", terms = c("session", "expGroup", "condition"))
plot_model(model.4, type = "eff", terms = c("expGroup", "condition"))
plot_model(model.5, type = "eff", terms = c("expGroup", "condition"))
