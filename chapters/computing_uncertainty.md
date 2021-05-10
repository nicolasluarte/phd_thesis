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
dependent on environment state. Previously, through Thompson sampling, we
provided a way in that entropy could be enconded as variance in the posterior
distribution, nevertheless, a more direct way to compute entropy is possible
through the prediction error.

The classical model of Rescorla-Wagner [@LFYTIBBR#Rescorla_Etal_1972] modeled
how animals could predict the reinforcing value of a given stimuli $$ y_{t} =
y_{t-1} + \alpha \delta_{n} $$ where the value representation of the stimuli $y$
is obtained by considering the previously estimated value $y_{t-1}, but weighted
by a learning rate $\alpha$ and a prediction error $\delta$. $delta$ is the
simple difference between the expected reward and the actual reward $\delta_{n}
= r_{t} - y_{t}$ where $r_{t}$ is the obtained reward, an extension to this has
proposed by [@2BEHEM7X#Sutton_Barto_2018] where the prediction error consider an
estimate of the rewards that give more weight to current rewards while still
considering past rewards $$ \delta_{n} = R{t} + \gamma \hat{V_{n+1}} -
\hat{V_{n}} $$ $\gamma$ is a discount factor $0 <= \gamma < 1$ for all the
history of rewards, and $\hat{V}$ is a proxy for the true value of the reward.
Finally, $\alpha : [0, 1]$ is the learning rate which effectively weights the
reward prediction error $\delta$ so to make small updates $\alpha \approx 0$ or
rather large ones $\alpha \approx 1$.

The simple model presented allows to derive a prediction error based on
experience, and the learning rate can be set lower to simulate unexpected
uncertainty or higher to simulate expected uncertainty. However, $\alpha$ in
such models is a hyperparameter, thus not derived from experience.
@NZFTTQJZ#Pearce_Hall_1980 model proposes that $\alpha$ can be controlled by the
prediction error magnitude $|\delta$ so $$\alpha = \gamma|\delta_{n-q}| + (1 -
\gamma) \alpha_{n-1}$$ Higher entropy on reward outcomes increases the minimal
error probability [@7JBVDKC8#Feder_Merhav_1994], thus increasing $|\delta|$, and
consequently $\alpha$. The behavioral result is that the animal should increase
learning for options with uncertain outcome by directing its attention
[@BVC98GTV#Diederen_Fletcher_2021].

Dopamine (DA) encodes prediction error [@8C97FJFI#Nasser_Etal_2017;
@AR2TQB84#Fiorillo_2003; @5BR3FL7N#Fiorillo_2011;
@IV9MZSXR#Lak_Stauffer_Schultz_2014; @HLCSQTJB#Glimcher_2011;
@4YU7F96V#Khaw_Glimcher_Louie_2017; @34HNDDL4#Gershman_Uchida_2019], more
specifically, DA phasic median activity encodes reward probability as positive
linear relationship for the conditioned stimulus, and as a negative linear
relationship for the unconditioned stimulus [@AR2TQB84#Fiorillo_2003].
Effectively encoding the prediction of the unconditioned stimulus, and the
surprise for the unconditioned stimulus, if a reward has low probability
obtaining it should be 'surprising'. Moreover, the change in sustained
activation encodes rewards probability analogous to entropy, that is, displaying
a peak of activity at probability 0.5 [@AR2TQB84#Fiorillo_2003 Moreover, the
change in sustained activation encodes rewards probability analogous to entropy,
that is, displaying a peak of activity at probability 0.5
[@AR2TQB84#Fiorillo_2003]. Hippocampal activity has been shown to reflect
Shannon entropy, and adaptation predicted by prediction error minimization
[@7PXFUSRW#Schiffer_Etal_2012], similar activity is also present on the striatum
[@6FBLSRK9#DenOuden_Etal_2010], substantia nigra [@6IGYU34R#Zaghloul_Etal_2009],
and ventral tegmental area [@XHH632AS#Iordanova_Etal_2021]. Moreover, DA
activity fits the classical reinforcement models as ventral tegmental DA support
cue-reward learning, the modifications of previous cue-reward associations
[@LSWYXCBD#Steinberg_Etal_2013; @8FIHXB6G#Chakroun_Etal_2020], and capable of
dealing with exploration/exploitation via tonic and phasic signaling,
respectively [@TN6NBEH8#Beeler_Etal_2010].

There is substantially evidence that DA neurons, specifically in the VTA serve
the functional role of computing reward prediction errors
[@NLDHLRVN#WatabeUchida_Eshel_Uchida_2017 ], by weighting inputs from multiple
brain areas, most remarkably the lateral hypothalamus, dorsal and ventral
striatum, ventral pallidum, and subthalamic nucleus [@SFZIJKFP#Tian_Etal_2016].
However, acetylcholine (ACh) and norepinephrine (NA) associated with expected
and unexpected uncertainty, respectively [@4BJ2B6KB#Yu_Dayan_2005] which are
mainly produced in the basal forebrain [@D8EGNYCV#Sturgill_Etal_2020] and locus
coeruleus (LC) [@TA5KB3TF#Sales_Etal_2019; @LEWESIS6#AstonJones_Cohen_2005]. ACh
antagonism has been shown to increase the response sensitivity to expected
uncertainty within a task [@9X7Z6PMX#Marshall_Etal_2016], providing evidence
that ACh represents expected uncertainty. On the other hand, NA for new
contingencies. On the other hand, LC tonic activity represents unexpected
uncertainty [@9Z525EYW#PayzanLenestour_Etal_2013;
@LEWESIS6#AstonJones_Cohen_2005].

In this section we presented simple computational models that consider
uncertainty by using information provided by the reward prediction error, which
is a extremely simple computation with that is likely to be implemented by DA
activity in the VTA, with additional modulation by ACh and NA possibly
controling the sensitivity of DA to expectected and unexpected uncertainty. In
the following two sections we will show empirical evidence on how food-access
uncertainty increases food-seeking behavior, and propose orexin as a potential
mediator of uncertainty-driven foraging.
