library(lme4)
library(lmerTest)
library(sjPlot)
library(sjmisc)
library(ggsci)
library(ggpubr)
library(gridExtra)
library(emmeans)
library(tidyverse)

df <- readRDS("data.rds")

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

# raw data plots

df %>%
	filter(
	       date < "2021-06-04",
	       date >= "2021-05-05"
	       ) %>%
	group_by(session, expGroup) %>%
	summarise(sumLicks = mean(sumLicks)) %>%
	ggplot(aes(session, sumLicks, color = expGroup)) +
	geom_line()


df %>%
	filter(
	       date < "2021-06-04",
	       date >= "2021-05-05",
	       session != 12
	       ) %>%
	group_by(raton) %>%
	nest() %>%
	mutate(
	       baseline = map(
			      data, ~mean(.x %>%
			      filter(session <= 13, session >= 10) %>%
			      select(sumLicks) %>%
			      unlist()
			      )
			      )
	       ) %>%
	unnest(c(data, baseline)) %>%
	group_by(raton, session, expGroup, condition, sumLicks, baseline) %>%
	nest() %>%
	select(-c(data)) -> deltas

deltas %>%
	mutate(mat = if_else(
			       condition == "post",
			       1,
			       0),
	       delta = sumLicks - (baseline * mat)
	) %>%
	group_by(raton, expGroup, condition, session) %>%
	summarise(delta_mean = unique(delta)) %>%
	group_by(expGroup, condition, session) %>%
	mutate(group_mean = mean(delta_mean), sem = sd(delta_mean) / sqrt(4)) %>%
	filter(condition == "post") %>%
	ggplot(aes(session, delta_mean, color = raton)) +
	geom_point(alpha = 0.3) +
	geom_line(alpha = 0.3) +
	geom_line(aes(session, group_mean), color = "black") +
	geom_errorbar(aes(ymin = group_mean - sem, ymax = group_mean + sem), color = "black") +
	geom_hline(yintercept = 0, color = "grey70") +
	facet_grid(~expGroup) +
	theme_pubr()





# licks
df %>%
	filter(
	       date < "2021-06-04",
	       session != 12
	       ) %>%
	group_by(raton) %>%
	group_by(session, expGroup) %>%
	summarise(mean_licks = mean(sumLicks) / mean(sumEvents), sem_licks = sd(sumLicks) / sqrt(4)) %>%
	filter(sem_licks > 0) %>%
	ggplot(aes(session, mean_licks, color = expGroup)) +
	geom_point() +
	geom_line() +
	geom_vline(xintercept = 13) +
	theme_bw() +
	ylab("Promedio de licks") +
	xlab("Sesiones") +
	labs(color = "Grupo experimental") +
	scale_colour_discrete(labels = c("Tratamiento", "Control"))


# licks in or out of time

model.1.v <- glmer(isTimeoutThreshold ~ (1 | raton) + condition * expGroup,
	   family = "binomial",
	data = df %>% 
		filter(
		       rewardedTrial == 1,
			date >= "2021-05-05",
			date < "2021-06-04")
)

emmeans(model.1.v, pairwise ~ condition * expGroup, type = "response")

# raw data

df %>%
	filter(
	       rewardedTrial == 1,
	       date >= "2021-05-05",
	       date < "2021-06-04"
	       ) %>%
	group_by(session, raton, expGroup, condition, isTimeoutThreshold) %>%
	summarise(n = n()) %>%
	pivot_wider(names_from = isTimeoutThreshold, values_from = n) %>%
	summarise(sum.val = impulsive + not_impulsive, percent.impulsive = impulsive / sum.val,
		  percent.not_impulsive = not_impulsive / sum.val,
		  percent.diff = (percent.impulsive)) %>%
	ungroup() %>%
	group_by(raton, expGroup, condition) %>%
	summarise(mean.impulsive = mean(percent.diff), sd = sd(percent.diff) ) -> impulsive.licks
impulsive.licks %>%
	ggplot(aes(condition, mean.impulsive, group = 1, color = expGroup)) +
	geom_point() +
	geom_errorbar(aes(ymin = mean.impulsive - sd, ymax = mean.impulsive + sd)) +
	geom_line() +
	facet_grid(~raton)

a %>%
	ggplot(aes(session, percent.impulsive, color = expGroup)) +
	geom_point() +
	geom_line() +
	geom_vline(xintercept = 13) +
	geom_smooth() +
	facet_grid(~raton)




# prepare data for licks
df %>%
	filter(date < "2021-06-04") %>%
	group_by(raton, expGroup, condition, session, date) %>%
	summarise(sumLicks = unique(sumLicks)) -> df.licks
df.licks %>%
	group_by(raton, condition) %>%
	mutate(baselineLicks = mean(sumLicks)) %>%
	pivot_wider(names_prefix = c("pre", "post"),
		    values_from = baselineLicks) %>%
	mutate(baselineLicks = zoo::na.locf(pre)) -> df.licks
df.licks %>%
	group_by(raton) %>%
	mutate(baselineLicks = scale(baselineLicks, center = TRUE, scale = TRUE),
	       scaledTime = (session-min(session))/(max(session)-min(session))) -> df.licks

# prepare data for events
df %>%
	filter(date < "2021-06-04") %>%
	group_by(raton, expGroup, condition, session, date) %>%
	summarise(sumEvents = unique(sumEvents)) -> df.events
df.events %>%
	group_by(raton, condition) %>%
	mutate(baselineEvents = mean(sumEvents)) %>%
	pivot_wider(names_prefix = c("pre", "post"),
		    values_from = baselineEvents) %>%
	mutate(baselineEvents = zoo::na.locf(pre)) -> df.events
df.events %>%
	group_by(raton) %>%
	mutate(baselineEvents = scale(baselineEvents, center = TRUE, scale = TRUE),
	       scaledTime = (session-min(session))/(max(session)-min(session))) -> df.events

# licks models
m.restricted.1 <- glmer.nb(sumLicks ~ 1 + (1 | raton), data = df.licks)
m.restricted.2 <- glmer.nb(sumLicks ~ 1 + (1 | raton) + condition, data = df.licks)
m.restricted.3 <- glmer.nb(sumLicks ~ 1 + (1 | raton) + condition * expGroup, data = df.licks)
m.restricted.4 <- glmer.nb(sumLicks ~ 1 + (1 | raton) + condition * expGroup * scaledTime, data = df.licks)
model.0.l <- glmer.nb(sumLicks ~ (1 | raton) + condition + expGroup + scaledTime + baselineLicks 
		+ condition:expGroup + condition:scaledTime + expGroup:scaledTime + expGroup:condition:scaledTime,
	data = df.licks)
summary(m.l)

drop1(m.l)

AIC(m.restricted.1,
    m.restricted.2,
    m.restricted.3,
    m.restricted.4,
    model.0.l
) 

modelsummary::get_gof(m.restricted)

# timeout model
df %>%
	filter(isEvent >= 0) -> df.valid
model.0.v <- glmer(isEvent ~ (1 | raton) + condition + expGroup,
	data = df.valid,
	family = "binomial")
summary(m.l)

df.valid %>%
	filter(date < "2021-06-04") %>%
	group_by(raton) %>%
	mutate(sumLicksScaled = scale(sumLicks, center = TRUE, scale = TRUE)) %>%
	ungroup() %>%
	group_by(expGroup,raton, session, isTimeOutThreshold) %>%
	summarise(valid = n() / sumLicks, sumLicks = sumLicksScaled) %>%
	ggplot(aes(sumLicks, valid, color = isTimeOutThreshold)) +
	geom_point() +
	geom_smooth(method = "lm") +
	facet_grid(expGroup~raton)

df.valid %>%
	filter(date < "2021-06-04") %>%
	filter(randomSpout =="fixed") %>%
	group_by(raton) %>%
	mutate(sumLicksScaled = scale(sumLicks, center = TRUE, scale = TRUE)) %>%
	ungroup() %>%
	group_by(raton, spoutNumber) %>%
	mutate(licksPerSpoutScaled = scale(licksPerSpout, center = TRUE, scale = TRUE)) %>%
	ungroup() %>%
	group_by(expGroup,raton, session, isTimeOutThreshold) %>%
	summarise(valid = n() / sumLicks, sumLicks = sumLicksScaled) %>%
	ggplot(aes(session, valid, color = isTimeOutThreshold)) +
	geom_point() +
	geom_vline(xintercept = 13) +
	geom_smooth(method = "gam") +
	facet_grid(expGroup~raton)

df.valid %>%
	filter(date < "2021-06-04") %>%
	mutate() %>%
	group_by(raton) %>%
	mutate(sumLicksScaled = scale(sumLicks, center = TRUE, scale = TRUE)) %>%
	ungroup() %>%
	group_by(raton, spoutNumber) %>%
	mutate(licksPerSpoutScaled = scale(licksPerSpout, center = TRUE, scale = TRUE)) %>%
	ungroup() %>%
	group_by(expGroup,raton, session, isTimeOutThreshold, condition, randomSpout) %>%
	summarise(valid = n() / sumLicks, sumLicks = sumLicksScaled) -> df.valid.licks

df.valid %>%
	mutate(scaledTime = (session-min(session))/(max(session)-min(session))) -> df.valid

df %>%
	mutate(scaledTime = (session-min(session))/(max(session)-min(session))) -> df

model.1.v <- lmer(valid ~ (1 | raton) + condition * expGroup * session + sumLicks,
		data = df.valid.licks %>% filter(isTimeOutThreshold == "valid"))



df %>%
	group_by(raton, condition) %>%
	mutate(baselineLicks = mean(sumLicks)) %>%
	pivot_wider(names_prefix = c("pre", "post"),
		    values_from = baselineLicks) %>%
	mutate(baselineLicks = zoo::na.locf(pre)) -> df

df %>%
	filter(randomSpout == "fixed") %>%
	group_by(raton, expGroup, condition, isTimeOutThreshold) %>%
	summarise(n = n()) %>%
	nest() %>%
	mutate(ratio.valid = map(data, function(x) x %>% summarise(sum.valid = sum(x$n)))) %>%
	unnest(cols = c(data, sum.valid)) %>%
	filter(isTimeOutThreshold == "notValid") %>%
	summarise(percent.invalid = (n)) -> valid.licks
valid.licks %>%
	ggplot(aes(condition, percent.invalid, group = 1, color = expGroup)) +
	geom_point() +
	geom_line() +
	facet_grid(~raton)

df %>%
	filter(randomSpout == "fixed",
	       date >= "2021-05-05",
	       date < "2021-06-04"
	       ) %>%
	group_by(session, raton, expGroup, condition, isTimeOutThreshold, baselineLicks) %>%
	summarise(n = n()) %>%
	pivot_wider(names_from = isTimeOutThreshold, values_from = n) %>%
	summarise(sum.val = valid + notValid, percent.valid = notValid / sum.val) %>%
	ungroup() %>%
	group_by(raton, expGroup, condition) %>%
	summarise(mean.valid = mean(percent.valid), sd = sd(percent.valid) ) -> valid.licks

valid.licks %>%
	ggplot(aes(condition, mean.valid, group = 1, color = expGroup)) +
	geom_point() +
	geom_errorbar(aes(ymin = mean.valid - sd, ymax = mean.valid + sd))
	geom_line() +
	facet_grid(~raton)

valid.licks %>%
	ggplot(aes(b, ratio.valid)) +
	geom_point() +
	facet_wrap(~condition)

model.1.v <- glmer(isTimeOutThreshold ~ (1 | raton) + condition * expGroup + baselineLicks,
		   family = "binomial",
		data = df %>% 
			group_by(raton, condition) %>%
			mutate(baselineLicks = scale(baselineLicks, center = TRUE, scale = TRUE)) %>%
			ungroup() %>%
			filter(
			       randomSpout == "fixed",
			       spoutNumber == "right",
				date >= "2021-05-05",
				date < "2021-06-04")
)

summary(model.1.v)




df %>%
	filter(expGroup == "treatment", date >= "2021-05-05", date < "2021-06-05") %>%
	group_by(isTimeOutThreshold, condition) %>%
	summarise(m = mean(as.numeric(isTimeOutThreshold)))

plot_model(model.1.v, type = "eff", term = c("sumLicks", "condition", "expGroup"))
plot_model(model.1.v, type = "eff", term = c("sumLicks", "expGroup", "condition"))
emmeans(model.1.v, pairwise ~ condition * expGroup + baselineLicks, type = "response")

ggeffects::ggpredict(model.1.v, c("scaledTime [all]", "condition", "sumLicks")) -> pr.v
plot.df.v <- data.frame(
		      time = pr.v$x * 29,
		      preds = pr.v$predicted,
		      lwr = pr.v$conf.low,
		      upr = pr.v$conf.high,
		      condition = pr.v$group,
		      group = pr.v$facet
		      )

pre.plot.v <- plot.df.v %>%
	filter(condition == "pre", time < 13) %>%
	ggplot(aes(time, preds, color = group)) +
	geom_ribbon(aes(ymin = lwr, ymax = upr, fill = group), alpha = 0.3, colour = NA) +
	geom_line() +
	ylab("Licks in time") +
	xlab("Session") +
	theme_pubr() +
	guides(color = FALSE) +
	labs(fill = "Standarized Licks") +
	ggtitle("Model predictions for baseline condition") +
	theme(plot.title = element_text(hjust = 0.5)) +
	scale_color_uchicago() +
	scale_fill_uchicago()
post.plot.v <- plot.df.v %>%
filter(condition == "post", time >= 13) %>%
	ggplot(aes(time, preds, color = group)) +
	geom_ribbon(aes(ymin = lwr, ymax = upr, fill = group), alpha = 0.3, colour = NA) +
	geom_line() +
	ylab("Licks") +
	xlab("Session") +
	theme_pubr() +
	guides(color = FALSE) +
	labs(fill = "Experimental group") +
	ggtitle("Model predictions for uncertainty condition") +
	theme(plot.title = element_text(hjust = 0.5)) +
	scale_color_uchicago() +
	scale_fill_uchicago()
licks.plot <- grid.arrange(pre.plot.v, post.plot.v, nrow = 1)

ggsave("licks.plot.png", licks.plot, height = 8, width = 12)

emmeans(model.0.v, pairwise ~expGroup, type = "response")

# model 0
model.0.l <- glmer.nb(sumLicks ~ (1 | raton) +
		      condition * expGroup * scaledTime + baselineLicks,
	  data = df.licks)
summary(model.0.l)
# model 0
model.0.e <- glmer.nb(sumEvents ~ (1 | raton) +
		      condition * expGroup * scaledTime,
	  data = df.events)
summary(model.0.e)

ggeffects::ggpredict(model.0.l, c("scaledTime", "condition", "expGroup")) -> pr
plot.df <- data.frame(
		      time = pr$x * 29,
		      preds = pr$predicted,
		      lwr = pr$conf.low,
		      upr = pr$conf.high,
		      condition = pr$group,
		      group = pr$facet
		      )
ggeffects::ggpredict(model.0.e, c("scaledTime", "condition", "expGroup")) -> pr.events
plot.df.e <- data.frame(
		      time = pr.events$x * 29,
		      preds = pr.events$predicted,
		      lwr = pr.events$conf.low,
		      upr = pr.events$conf.high,
		      condition = pr.events$group,
		      group = pr.events$facet
		      )

pre.plot.l <- plot.df %>%
	filter(condition == "pre", time < 13) %>%
	ggplot(aes(time, preds, color = group)) +
	geom_ribbon(aes(ymin = lwr, ymax = upr, fill = group), alpha = 0.3, colour = NA) +
	geom_line() +
	ylab("Licks") +
	xlab("Session") +
	theme_pubr() +
	guides(color = FALSE) +
	labs(fill = "Experimental group") +
	ggtitle("Model predictions for baseline condition") +
	theme(plot.title = element_text(hjust = 0.5)) +
	ylim(c(400, 2000)) +
	scale_color_uchicago() +
	scale_fill_uchicago()
post.plot.l <- plot.df %>%
	filter(condition == "post", time >= 13) %>%
	ggplot(aes(time, preds, color = group)) +
	geom_ribbon(aes(ymin = lwr, ymax = upr, fill = group), alpha = 0.3, colour = NA) +
	geom_line() +
	ylab("Licks") +
	xlab("Session") +
	theme_pubr() +
	guides(color = FALSE) +
	labs(fill = "Experimental group") +
	ggtitle("Model predictions for uncertainty condition") +
	theme(plot.title = element_text(hjust = 0.5)) +
	ylim(c(400, 2000)) +
	scale_color_uchicago() +
	scale_fill_uchicago()
licks.plot <- grid.arrange(pre.plot.l, post.plot.l, nrow = 1)
ggsave("licks.plot.png", licks.plot, height = 8, width = 12)


pre.plot.e <- plot.df.e %>%
	filter(condition == "pre", time < 13) %>%
	ggplot(aes(time, preds, color = group)) +
	geom_ribbon(aes(ymin = lwr, ymax = upr, fill = group), alpha = 0.3, colour = NA) +
	geom_line() +
	ylab("Events") +
	xlab("Session") +
	theme_pubr() +
	guides(color = FALSE) +
	labs(fill = "Experimental group") +
	ggtitle("Model predictions for baseline condition") +
	theme(plot.title = element_text(hjust = 0.5)) +
	scale_color_uchicago() +
	scale_fill_uchicago()
post.plot.e <- plot.df.e %>%
	filter(condition == "post", time >= 13) %>%
	ggplot(aes(time, preds, color = group)) +
	geom_ribbon(aes(ymin = lwr, ymax = upr, fill = group), alpha = 0.3, colour = NA) +
	geom_line() +
	ylab("Events") +
	xlab("Session") +
	theme_pubr() +
	guides(color = FALSE) +
	labs(fill = "Experimental group") +
	ggtitle("Model predictions for uncertainty condition") +
	theme(plot.title = element_text(hjust = 0.5)) +
	scale_color_uchicago() +
	scale_fill_uchicago()
events.plot <- grid.arrange(pre.plot.e, post.plot.e, nrow = 1)
ggsave("events.plot.png", events.plot, height = 8, width = 12)


b <- parameters::bootstrap_model(model.0.l, iterations = 1000)
e <- emmeans(b, consec ~ expGroup * condition)
parameters::model_parameters(e)
emmeans(model.0.l, pairwise ~expGroup * condition, type = "response", adjust = "none")$contrasts %>% confint()
emmeans(model.0.l, pairwise ~expGroup * condition, type = "response", adjust = "none")

df.licks %>%
	ggplot(aes(session, sumLicks, color = expGroup)) +
	geom_point() +
	geom_vline(xintercept = 13) +
	geom_smooth() +
	facet_grid(expGroup~raton)

df.events %>%
	ggplot(aes(session, sumEvents, color = expGroup)) +
	geom_point() +
	geom_vline(xintercept = 13) +
	geom_smooth() +
	facet_grid(expGroup~raton)

model.0.l %>% 
	emmeans(~ expGroup * condition, ratios = TRUE) %>%
	contrast(., method = "pairwise", by = "condition")





df.licks$preds <- predictInterval(model.0.l, which = "fixed")$fit
df.licks$upr <- predictInterval(model.0.l)$upr
df.licks$lwr <- predictInterval(model.0.l)$lwr

df.licks %>%
	ggplot(aes(session, preds)) +
	geom_line() +
	facet_grid(raton~condition)

df.licks %>%
	ggplot(aes(session, preds, color = expGroup)) +
	geom_line() +
	geom_ribbon(aes(ymin = lwr, ymax = upr)) +
	geom_vline(xintercept = 13) +
	facet_wrap(~raton)


plot(resid(model.0.l))
plot(model.0.l)

car::leveneTest(residuals(model.0.l) ~ df.licks$raton)
boxplot(residuals(model.0.l) ~ as.factor(df.licks$session))

plot_model(model.0.l, type = "eff", term = c("scaledTime", "expGroup", "condition [post]"))
	

model.licks.1.fit <- lmer(data = df.licks,
		log(sumLicks) ~ (1 | raton) + condition * session + log(baselineLicks))
summary(model.licks.1.fit)

model.licks.null <- lmer(data = df.licks %>% filter(condition == "pre", date >= "2021-05-05"),
		sumLicks ~ (1  | raton) + expGroup)
plot_model(model.licks.null)
summary(model.licks.null)
emmeans(model.licks.null, ~expGroup)


emmip(model.licks.1.fit, ~condition, CIs = TRUE)

(emmeans(model.licks.1.fit, pairwise~condition))
test(emmeans(model.licks.1.fit, ~condition*expGroup))

# model 1 plots
plot_model(model.licks.1.fit, show.values = TRUE,
	   vline.color = "black",
	   value.offset = .4,
	   line.size = 0.25)

plot_model(model.licks.1.fit, type = "eff", term = c("session", "condition"))


# events
model.null.events <- lmer(data = df %>% filter(date >= "2021-05-05"),
	sumEvents ~ (1 | raton) + expGroup)
model.0.events <- lmer(data = df %>% filter(date >= "2021-05-05"),
	sumEvents ~ (1 | raton) + expGroup * condition)
model.1.events <- lmer(data = df %>% filter(date >= "2021-05-05"),
	sumEvents ~ (condition | raton) + expGroup * condition)
model.2.events <- lmer(data = df,
	sumEvents ~ (condition | raton) + expGroup * condition * session)
summary(model.2.events)

model.2.events <- lmer(data = df ,
	sumLicks ~ (condition | raton) + expGroup * condition * session)
summary(model.2.events)

# comparison
model.2.events.null <- lmer(data = df %>% filter(date >= "2021-05-05"),
	sumEvents ~ (condition | raton) + expGroup * session, REML = TRUE)
model.2.events.alt <- lmer(data = df %>% filter(date < "2021-06-04"),
	sumEvents ~ (condition | raton) + expGroup * condition * session, REML = TRUE)
model.2.licks.alt <- lmer(data = df %>% filter(date < "2021-06-04"),
	sumLicks ~ (condition | raton) + expGroup * condition * session, REML = TRUE)
model.2.events.full <- lmer(data = df,
	sumEvents ~ (condition | raton) + expGroup * condition * session, REML = TRUE)

model.3.events.alt <- lmer(data = df %>% filter(date >= "2021-05-10", date <= "2021-05-14"),
	sumEvents ~ (condition | raton) + expGroup * condition * session, REML = TRUE)
summary(model.3.events.alt)
plot_model(model.3.events.alt, type = "pred", term = c("expGroup", "condition"))

model.3.events.alt <- lmer(data = df %>% filter(date >= "2021-05-10", date <= "2021-05-14"),
	sumEvents ~ (condition | raton) + expGroup * condition * session * sumLicksScaled, REML = TRUE)
summary(model.3.events.alt)
plot_model(model.3.events.alt, type = "pred", term = c("expGroup", "condition", "sumLicksScaled"))


model.5.events.alt <- lmer(data = df %>% filter(date < "2021-06-04",
						expGroup == "treatment",
						condition == "post"),
	licksPerSpout ~ (1 | raton) + randomSpout, REML = TRUE)
anova(model.5.events.alt)
summary(model.5.events.alt)

model.5.events.alt <- lmer(data = df %>% filter(date < "2021-06-04",
						expGroup == "treatment",
						condition == "post"
						),
	rewardsPerSpout ~ (1 | raton) + randomSpout * spoutNumber)
summary(model.5.events.alt)
anova(model.5.events.alt)
plot_model(model.5.events.alt, type = "pred", term = c("spoutNumber", "randomSpout"))

df %>% filter(expGroup == "treatment", condition == "post") %>%
	group_by(spoutNumber, randomSpout) %>%
	summarise(b = mean(eventsPerSpout))


options(browser = 'brave')
tab_model(model.2.events.alt)

options(browser = 'brave')
tab_model(model.3.events.alt)

plot(model.2.events.alt)

options(browser = 'brave')
tab_model(model.2.licks.alt)

plot_model(model.2.licks.alt, type = "pred", term = c("session", "expGroup", "condition"))
anova(model.2.licks.alt)


model.2.plot <- plot_model(model.2, type = "int", term = c("condition", "expGroup"))

plot_model(model.2.events.alt, type = "pred", term = c("session", "expGroup", "condition")) +
	theme_bw()

df.model <- df %>% filter(date < "2021-06-04")
df.model$model.2.fit <- predict(model.2.licks.alt)
df.model %>%
	ggplot(aes(session, model.2.fit, color = expGroup)) +
	geom_line() +
	geom_point(aes(session, sumLicks)) +
	facet_grid(condition ~ raton)

df.model <- df %>% filter(date < "2021-06-04", condition == "post", expGroup == "treatment")
df.model$model.2.fit <- predict(model.5.events.alt)
df.model %>%
	ggplot(aes(session, model.2.fit, color = randomSpout)) +
	geom_line() +
	geom_point(aes(session, licksPerSpout, color = randomSpout)) +
	facet_grid(spoutNumber~raton)


plot_model(model.2.events, type = "re")

fixef(model.2.events)

fixef(model.2.events)

model.2.events <- lmer(data = df %>% filter(condition == "post"),
	sumEvents ~ (1 | raton) + expGroup * session)
summary(model.2.events)

# licks
model.null.licks <- lmer(data = df %>% filter(date >= "2021-05-05"),
	sumLicks ~ (1 | raton) + expGroup)
model.0.licks <- lmer(data = df %>% filter(date >= "2021-05-05"),
	sumLicks ~ (1 | raton) + expGroup * condition)
model.1.licks <- lmer(data = df %>% filter(date >= "2021-05-05"),
	sumLicks ~ (condition | raton) + expGroup * condition)
model.2.licks <- lmer(data = df %>% filter(date >= "2021-05-05"),
	sumLicks ~ (condition | raton) + expGroup * condition * date)
summary(model.2.licks)
anova(model.null, model.0, model.1, model.2)
model.2.plot <- plot_model(model.2, type = "int", term = c("condition", "expGroup"))
plot_model(model.2, type = "pred", term = c("session[1:29]", "expGroup", "condition"))
plot_model(model.2, type = "pred", term = c("session", "condition", "expGroup"))

plot(model.2)

options(browser = 'brave')
tab_model(model.2.events)


df %>%
	ggplot(aes(as.factor(session), sumEvents, color = expGroup)) +
	geom_boxplot()

# lick density
df %>%
	filter(msFromEvents < 5000, msFromEvents > 0, randomSpout == "fixed") %>%
	ggplot(aes(msFromEvents)) +
	geom_density(aes(y = ..scaled.., color = condition)) +
	facet_grid(raton~expGroup, scales = "free")

df %>% filter(raton == 219, condition == "post", randomSpout == "variable") %>%
	select(isEvent, isReward, rewardedTrial, eventsCum) %>%
	View()
