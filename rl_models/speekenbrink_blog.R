library(tidyverse)

df_raw <- read_csv("https://github.com/speekenbrink-lab/data/raw/master/Speekenbrink_Konstantinidis_2015.csv")

head(df)

df_raw %>%
	select(id2, deck) %>%
	group_by(id2, deck) %>%
	summarise(count = n()) %>%
	spread(deck, count)

df_raw %>%
	filter(id2 == 4) -> df

# maximum likelihood estimation

# the model should predict, on each trial t, the probability of choosing each
# option, conditionally upon the experience up to that point

# kalman filter
kalman_filter <- function(
	 choice,
	 reward,
	 noption,
	 mu0,
	 sigma0_sq,
	 sigma_xi_sq,
	 sigma_epsilon_sq
	 ) {
	nt <- length(choice)
	no <- noption
	m <- matrix(mu0, ncol = no, nrow = nt + 1)
	v <- matrix(sigma0_sq, ncol = no, nrow = nt + 1)
	for (t in 1:nt) {
		kt <- rep(0, no)
		kt[choice[t]] <- (v[t,choice[t]] + sigma_xi_sq)/(v[t,choice[t]] + sigma_xi_sq + sigma_epsilon_sq)
		m[t+1,] <- m[t,] + kt*(reward[t] - m[t,])
	        v[t+1,] <- (1-kt)*(v[t,] + sigma_xi_sq)
	}
	return(list(m = m, v = v))
}

softmax_choice_prob <- function(
				m,
				gamma
				) {
	prob <- exp(gamma * m)
	prob <- prob / rowSums(prob)
	return(prob)
}

