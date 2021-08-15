# libs
library(lme4)
library(lmerTest)
library(sjPlot)
library(sjmisc)
library(ggsci)
library(ggpubr)
library(ggridges)
library(gridExtra)
library(emmeans)
library(tidymodels)

# load data
df_raw <- readRDS("data.rds")

# prepare data
df_raw %>%
	filter(
	       date < "2021-06-04",
	       date >= "2021-05-05",
	       session != 12,
	       msFromStart <= 3600000
	       ) -> df
df %>%
	select(
	       msFromStart,
	       msFromEvents,
	       date,
	       session,
	       condition,
	       expGroup,
	       rewardedTrial,
	       raton,
	       licksCum,
	       isEvent,
	       isReward,
	       ILI,
	       spoutNumber,
	       randomSpout,
	       isTimeout,
	       isTimeoutThreshold
	       ) %>% ungroup() -> df

# data exploration
# licksCum over time per mice, binned every 10 minutes
# normalize between 0 and 1
scale01 <- function(x){(x-min(x))/(max(x)-min(x))}
df %>%
	group_by(
		 session
		 ) %>%
	mutate(
	       time_bin_10  = cut(msFromStart,
				  seq(0, 3600000, 600000),
				  include.lowest = TRUE) %>%
		       as.numeric()
	       ) %>%
	ungroup() %>%
	group_by(raton, session) %>%
	mutate(
		licks = row_number(),
		scaled_licks = scale01(licks)
		) %>%
	ungroup() %>%
	group_by(session) %>%
	mutate(
	       scaled_time = scale01(msFromStart),
	       time_bin_scaled = cut(scaled_time,
	       seq(0, 1, 1/6),
	       include.lowest = TRUE) %>% as.numeric()
	       ) -> df

# licks over time
df %>%
	group_by(time_bin_10, expGroup, condition) %>%
	summarise(
		  mean_licks = mean(licks),
		  sem_licks = sd(licks) / sqrt(4)
		  ) -> licks.over.time
licks.over.time %>%
	ggplot(aes(time_bin_10,
		   mean_licks,
		   ymin = mean_licks - sem_licks,
		   ymax = mean_licks + sem_licks,
		   color = condition)) +
	geom_line() +
	geom_point() +
	geom_errorbar(width = 0.3) +
	facet_grid(~expGroup) +
	theme_pubr()

# licks over time scaled
df %>%
	group_by(time_bin_scaled, expGroup, condition) %>%
	summarise(
		  mean_licks = mean(scaled_licks),
		  sem_licks = sd(scaled_licks) / sqrt(4)
		  ) -> licks.over.time
licks.over.time %>%
	ggplot(aes(time_bin_scaled,
		   mean_licks,
		   ymin = mean_licks - sem_licks,
		   ymax = mean_licks + sem_licks,
		   color = condition)) +
	geom_line() +
	geom_point() +
	geom_errorbar(width = 0.3) +
	facet_grid(~expGroup) +
	theme_pubr()

# ILI over time
df %>% 
	group_by(time_bin_10, expGroup, condition) %>%
	summarise(
		  mean_ILI = mean(ILI),
		  sem_ILI = sd(ILI) / sqrt(4)
		  ) %>% ungroup() -> ili.over.time
ili.over.time %>%
	ggplot(aes(time_bin_10,
		   mean_ILI,
		   ymin = mean_ILI - sem_ILI,
		   ymax = mean_ILI + sem_ILI,
		   color = condition)) +
	geom_line() +
	geom_point() +
	geom_errorbar(width = 0.3) +
	facet_grid(~expGroup) +
	theme_pubr()

# ILI ridge
df %>% 
	filter(ILI <= 1000) %>%
	ggplot(aes(x = ILI, y = time_bin_10, fill = as.factor(time_bin_10))) +
	geom_density_ridges(stat = "binline", bins = 60) +
	facet_grid(expGroup~condition) +
	theme_ridges() +
	theme(legend.position = "none")

# ILI ridge
df %>% 
	filter(ILI <= 1000) %>%
	ggplot(aes(x = ILI, y = condition, fill = condition)) +
	geom_density_ridges(stat = "binline", bins = 60) +
	facet_grid(~expGroup) +
	theme_ridges() +
	theme(legend.position = "none")

# ILI ecdf
ggecdf(
     data = df %>% filter(ILI <= 750),
     x = "ILI",
     color = "condition",
     linetype = "condition",
     facet.by = "expGroup"
     )

# BURSTS
df %>%
	group_by(raton, session) %>%
	mutate(burst_500 = if_else(ILI > 1000, 0, 1)) %>%
	mutate(burst_500_cluster = if_else(c(0, diff(burst_500))  < 1, 0, 1) %>%
					   cumsum * burst_500) %>%
	ungroup() -> df
df %>%
	filter(randomSpout == "fixed") %>%
	group_by(raton, session, burst_500_cluster, condition, expGroup) %>%
	filter(burst_500 != 0) %>%
	summarise(b = length(burst_500_cluster * burst_500)) %>%
	ungroup() %>%
	select(-burst_500_cluster) -> burst_size

df %>%
	group_by(raton, session, condition, expGroup) %>%
	summarise(b = max(burst_500_cluster)) -> burst_number

burst_number %>%
	filter(session %in% c(9, 10, 11), !(session %in% c(16, 20, 25))) %>%
	group_by(raton) %>%
	mutate(baseline = mean(b)) %>%
	distinct(raton, baseline) %>%
	left_join(burst_number, ., by = c("raton")) %>%
	mutate(bdiff = b - baseline)  %>%
	group_by(raton, expGroup, condition) %>%
	summarise(m = mean(bdiff)) %>%
	filter(condition  == "post") %>%
	group_by(expGroup, condition) %>%
	mutate(mg = mean(m), sg = sd(m) / sqrt(n())) -> burst_baseline
	ggplot(aes(expGroup, mg, ymin = mg - sg, ymax = mg + sg), data = burst_baseline %>% spread(raton, m)) +
	geom_col() +
	geom_point(data = burst_baseline, aes(expGroup, m)) +
	geom_errorbar(width = 0.3) +
	ylab("Mean burst number - baseline") +
	xlab("Group") +
	theme_pubr() -> burst_plot
ggsave("burst.png", burst_plot)


ggplot(aes(expGroup, mg, ymin = mg - sg, ymax = mg + sg, fill = expGroup), data = burst_baseline %>% spread(raton, m)) +
	geom_col() +
	geom_point(data = burst_baseline, aes(expGroup, m)) +
	geom_errorbar(width = 0.3) +
	geom_hline(yintercept = 0) +
	ylab("Mean burst number - baseline") +
	xlab("Group") +
	theme_pubr() +
	theme(
	      axis.text = element_text(size = 18),
	      axis.title = element_text(size = 18),
	      axis.text.x = element_text(size = 16),
	      legend.position = "none"
	      ) +
	scale_x_discrete(labels = c("Treatment", "Control")) +
	scale_fill_manual(values = c("grey", "grey30")) -> bplot
ggsave("burst.png", bplot)

burst_number %>%
	filter(session %in% c(8, 9, 10, 11)) %>%
	group_by(raton) %>%
	mutate(baseline = mean(b)) %>%
	distinct(raton, baseline) %>%
	left_join(burst_number, ., by = c("raton")) %>%
	mutate(bdiff = b - baseline) %>%
	filter(condition == "post", session < 27) -> burst_baseline
lmer(data = burst_baseline, bdiff ~ expGroup + (1 | raton)) %>% summary()

b %>%
	filter(condition == "post") -> a
lmer(bdiff ~ expGroup + (1 | raton), data = a) %>% summary()

burst_number %>% filter(raton == 221)

a %>%
	ggplot(aes(session, bdiff, color = raton)) +
	geom_line() +
	facet_grid(~expGroup)


	hist(burst_baseline$m)

burst_baseline %>%
	ggplot(aes(expGroup, m)) +
	geom_boxplot() +
	geom_point() + 
	theme_pubr() +
	ylab("Mean burst number - baseline") +
	xlab("Group") -> burst_plot
ggsave("burst.png", burst_plot)

burst_size %>%
	filter(session %in% c(9, 10, 11)) %>%
	group_by(raton) %>%
	mutate(baseline = mean(b)) %>%
	distinct(raton, baseline) %>%
	left_join(burst_size, ., by = c("raton")) %>%
	mutate(bdiff = b - baseline) %>%
	mutate(week = case_when(
			 session > 12 & session < 21 ~ "week 1",
			 session >= 21 ~ "week 2"
			 )) %>%
	group_by(raton, expGroup, condition, week) %>%
	summarise(m = mean(bdiff)) %>%
	filter(condition  == "post") %>%
	group_by(expGroup, condition, week) %>%
	mutate(mg = mean(m), sg = sd(m) / sqrt(n())) -> burst_baseline_size
	ggplot(aes(expGroup, mg, ymin = mg - sg, ymax = mg + sg), data = burst_baseline_size %>% spread(raton, m)) +
	geom_col() +
	geom_errorbar(width = 0.3) +
	geom_point(data = burst_baseline_size, aes(expGroup, m)) + 
	theme_pubr() +
	facet_grid(~week) +
	ylab("Mean burst size - baseline") +
	xlab("Group")  -> burstSize
ggsave("burst_size.png", burstSize)

# intra burst lick rate

df %>%
	filter(burst_500 != 0) %>%
	group_by(raton, session, burst_500_cluster, condition, expGroup) %>%
	summarise(burst_size = length(burst_500_cluster * burst_500),
		  burst_lick_rate = (length(burst_500_cluster * burst_500) * 1000) /sum(ILI)) %>%
	filter(burst_lick_rate != Inf) %>%
	ungroup() -> burst_rate

burst_rate %>%
	filter(session %in% c(9, 10, 11)) %>%
	group_by(raton) %>%
	mutate(baseline = mean(burst_lick_rate)) %>%
	distinct(raton, baseline) %>%
	left_join(burst_rate, ., by = c("raton")) %>%
	mutate(bdiff = burst_lick_rate - baseline) %>%
	ungroup() %>%
	group_by(raton, expGroup, condition) %>%
	summarise(m = mean(bdiff)) %>%
	filter(condition  == "post") %>%
	group_by(expGroup, condition) %>%
	mutate(mg = mean(m), sg = sd(m) / sqrt(n())) -> burst.rate
	ggplot(aes(expGroup, mg, ymin = mg - sg, ymax = mg + sg, fill = expGroup), data = burst.rate %>% spread(raton, m)) +
	geom_col() +
	geom_point(data = burst.rate, aes(expGroup, m)) +
	geom_errorbar(width = 0.3) +
	ylab("Intra-burst lick rate - baseline") +
	xlab("Group") +
	theme_pubr() +
	theme(
	      axis.text = element_text(size = 18),
	      axis.title = element_text(size = 18),
	      axis.text.x = element_text(size = 16),
	      legend.position = "none"
	      ) +
	scale_x_discrete(labels = c("Treatment", "Control")) +
	scale_fill_manual(values = c("grey", "grey30")) -> intra_burst
ggsave("intra_burst.png", intra_burst)

lmer(data = burst_rate, burst_lick_rate ~ expGroup + (1 | raton)) %>% summary()


ggsave("burst_rate.png", burstRate)
