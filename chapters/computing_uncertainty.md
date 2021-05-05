# Computing uncertainty

Uncertainty arises from having more than one option, and that the motivation to
opt for one of those options is somewhat distributed, and there is no one option
that is always prefered. Considering that the probability of choosing any given
option has a uniform distribution, then uncertainty increases proportionally
with the number of options. Shannon entropy [@LUFF6VTC#Shannon_1948
] formalizes this intuition $$H = - \sum_{i = 1}^{n} p_{i} log_{2} p_{i}$$
So maximum entropy (one bit) is achieved when all the alternatives have the same
probability, such as a coin flip. However, if the coin happens to have two
heads, then Shannon entropy is 0.

If we consider a simple environment with only one state $s$, one action $a$
initiate a food-seeking bout, and only two possible outcomes food is found
($p$) or not found ($q = 1 - p$), then $H = -(p log_{2} p + q log{2} q)$. If an
animals performs multiple food-seekign bouts and non of them are succesful $H =
0$ the same is true if all are successful. However, if the probability of a
successful food-seeking bout is 0.5, then entropy is maximized $H = 1$. Neural
representation of entropy has been found in the middle cingulate cortex (MCC)
for the particular implementation of encoding outcome entropy
[@55XGJCH7#Goñi_Etal_2011; @DRJBKPPI#Gloy_Herrmann_Fehr_2020] so this
computation seems to be biologically plausible. However, entropy is not
available as sensory input it must derive from actions and outcomes, which are
dependent on environment state. Previously, through Thompson sampling we
provided a way in that entropy could be enconded as variance in the posterior
distribution, nevertheless, a more direct way to compute entropy is possible
through the prediction error.

Describe prediction error.
Learning rate as point estimate of uncertainty.

Dynamically adjust learning rate in face of uncertainty.

the uncertainty bonus.

uncertainty increases food-seeking behavior.

dopamin, ach, NE. Hint orexin.
