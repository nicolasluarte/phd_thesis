---
fontsize: 20pt
mainfont: Times New Roman
geometry: margin=4cm

header-includes:
	- \usepackage{fancyhdr}
	- \usepackage{titling}
---

\fancypagestyle{plain}{%
\fancyhf{} % clear all header and footer fields
\rfoot[RO,RE]{\thepage} %RO=right odd, RE=right even
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}
\pagestyle{plain}
\renewcommand\maketitlehooka{\null\mbox{}\vfill}
\renewcommand\maketitlehookd{\vfill\null}
\title{Proyecto de tesis doctoral para optar al grado de Doctor en Neurociencia en la Pontificia Universidad Católica de Chile}
\author{Luis Nicolás Luarte Rodríguez - Claudio Peréz-Leighton}

\begin{titlingpage}
\maketitle
\end{titlingpage}

\pagebreak

# Introduction

Mammals evolved in an environment where food sources are limited and often scarce; thus, maintaining fat reserves and overall caloric intake is extremely important. Most animals accomplish this by increasing food-seeking behavior when food access is limited, resulting in extended foraging bouts. However, foraging and larger fat reserves can increase predation risk by increasing exposure and reducing mobility, respectively. Therefore, increasing foraging bouts should only occur when the risk of starvation outweighs the risk of predation. One environmental clue that animals use to make this decision is uncertainty in food access: higher levels of food access uncertainty predicts future food scarcity, triggering food-seeking behavior to prevent starvation. This prediction effectively allows animals to act upon proximal cues without the need to know the complete state of the environment.

Currently, it is unclear how animals use uncertainty to drive food-seeking behavior. We propose that the prediction error between expected and actual intake from foraging bouts translates into a measure of food-access uncertainty. Increasing uncertainty generates unreliable expectations, therefore, more prediction errors. Then, exploratory behavior should increase proportionally to the prediction error.

Relating uncertainty to food scarcity is a successful adaptive strategy when food is limited, but food sources are ubiquitous in modern environments. These environments increase food-seeking behavior leading to excessive intake, raising the risk of overweight and obesity. Even though the effects of uncertainty (through intermittent diet schemes) are known to increase food intake in a binge-like fashion, the specific behavioral events and the neurobiological substrate mediating these effects remain unclear.

The neurobiological mechanisms that regulate food-seeking behavior and foraging must use information about a nutrient deficit to increase alertness and physical activity to forage successfully. The neuropeptide orexin has the potential to be a mediator of foraging behavior. Fasting and intake respectively increase and decrease the activity of orexin neurons, and its activation increases physical activity and food intake, but this effect seems to be brain site-specific. Together, these data support that orexin might promote foraging behavior by increasing locomotor activity in response to a nutrient deficit before food intake. Orexin could provide the mechanism to drive increased food-seeking behavior when uncertainty increases.

Together, these data led us to hypothesize that orexin promotes food-seeking-related behaviors when facing uncertainty related to food access. Our overall aim is to determine how uncertainty in food-access increases food-seeking behavior, and how orexin mediates uncertainty-drive increased food-seeking behavior.


# General research strategy

To determine how uncertainty in food-access increases food-seeking behavior we will use mainly two strategies: (1) behavioral modeling using the reinforcement learning framework to assess changes in reward processing in conditions with uncertainty compared to those without uncertainty, and (2) operant tasks to manipulate uncertainty levels in food acquisition. To determine how orexin mediates uncertainty-driven food-seeking behaviors we will (1) assess differential gene expression in conditions with and without uncertainty through real time qPCR, obtaining correlational-level data on orexin as a mediator of uncertainty-driven food-seeking behavior; (2) determine if orexin is necessary to drive increased food-seeking behavior in uncertain conditions with the use of orexin antagonists, and gain of function with orexin agonist, (3) We will test functional connectivity between hypothalamic orexin neurons and paraventricular nucleus/ventral tegmental area (VTA), t determine if orexin mediation of uncertainty-driven food-seeking behavior can be supported as a modulation of reward-related systems.

\pagebreak

# Theoretical and empirical framework

## The natural setting for food-seeking behavior

Foraging are all behaviors related to obtaining food, including feeding and
hoarding [@V3Z2UVAU#Kramer_2001]. Within foraging, food-seeking behavior
precedes actual intake and is the re-orientation of attention and locomotor
activity to acquire food. A successful food-seeking behavior uses the least
amount of resources while reducing exposure to potential predators to find food.
Because the environment is in constant change, food seeking strategies must be
in constant adaptation [@9XCDNBAM#Bartumeus_Etal_2016;
@BWKDXXFW#Kölzsch_Etal_2015]. However, animals are never completly aware of
these environmental changes, food location, quality and the probability of
obtaining food are only partially known [@ZD73QGIR#Pyke_1984 ]. Thus, the main
challenge for the foraging animal is how to determine an optimal strategy to
procure food while having only partial knowledge of food location.

The necessary information to determine a food-seeking strategy are the overall
statistical properties of the environment: how dense are the food targets in a
given area, how variable is the quality of such resources, and what is the
expected outcome of foraging here or there. These properties should not be
considered in isolation. For example, not considering changes in food quality
could lead to a search for food in an area with an overall low food quality,
increasing the risk of starvation. This problem begs the question: _**what kind of
strategy could accomplish this while having only partial or incomplete knowledge
about the food environment?**_

Distribution fitting of movement data of different species (including human) has
shown that food-seeking behavior tends to follow Lévy-walk patterns
[@7YQKP7Z2#Garg_Kello_2021; @I2BS842S#Reynolds_Etal_2018;
@TPRPLPEC#Viswanathan_Etal_1996; @BWKDXXFW#Kölzsch_Etal_2015]. Lévy-walks are
random walks with a Lévy distribution, which produces heavy-tails and describes
multiple concentrated movements with sharp turning angles followed by few
ballistic displacements. These patterns produce optimal searches in various
environments with a patchy distribution of resources (clumped resources distant
to one another) [@97UESCC6#Wosniack_Etal_2017]. Although how animals produce
Lévy search patterns is unknown [@I2BS842S#Reynolds_Etal_2018], this might be
partially independent of sensory information [@M5RXPXSZ#Humphries_Sims_2014;
@5WUMQR2H#Sims_Etal_2019]. This strategy probably evolved to optimize food
searching with partial or complete lack of knowledge of food location
[@97UESCC6#Wosniack_Etal_2017].

Lévy-walks is a ubiquitous strategy that does not rely on sensory information,
and might be an ancient ‘base’ strategy to deal with locating food in uncertain
environments [@BWKDXXFW#Kölzsch_Etal_2015; @5WUMQR2H#Sims_Etal_2019]. However,
after a food encounter, the search strategy switches to a more focused one
similar to Brownian-motion, following random trajectories within a more enclosed
space, possibly reflecting an adaptation to the usual distribution of food
within patches: if one encounters food, there is a good chance that more food
will be nearby [@5KMWW8NS#Reynolds_Frye_2007;
@F9HICU4A#Nauta_Khaluf_Simoens_2020]. This suggests that food seeking behavior
likely evolved to deal with food location uncertainty that could not be reduced
by perceptual information.

Starting from the base that animals have only partial knowledge about food
location, we asked what strategy could provide optimal results given this
constraint. Lévy-walks fit within this constraint providing a way to seeking for
food without relying on perceptual information. Moreover, we proposed that this
strategy could have emerged to lead with environment uncertainty. In the next
section, we will explore how considering uncertainty within the food-seeking
strategy can be useful when perceptual abilities are limited, and how
uncertainty itself can modify food-seeking behavior
[@HJ7CGIEU#Anselme_Robinson_2019; @3YWCKUUK#Anselme_Otto_Güntürkün_2017;
@C6Z374UG#Anselme_Güntürkün_2019].

## Foraging and uncertainty

As discussed previously, animals adopted food-seeking strategies to procure food
within uncertain environments [@M5RXPXSZ#Humphries_Sims_2014;
@5WUMQR2H#Sims_Etal_2019]. Here, we will show how environmental uncertainty can
regulate food-seeking behavior, its easily computed, and how brain structures
readily can represent it.

To show how environmental uncertainty regulates food-seeking behavior, we will
expose two case, one without considering uncertainty within food-seeking
behavior, and the alternative case when it is considered. For the first case, we
can assume that the animal will randomly sample its alternatives and then pick
the one that, at that time, delivered the greatest value. This sampling and
action selection strategy is called greedy [@JH5D2C9Z#Tokic_Palm_2011]. Acting
greedily implies that the animal will always choose the option that yielded the
most value in an initial random sampling, neglecting that  the samples come from
a stochastic reward process that changes over time. This is problematic as it
makes food-seeking strategies insensitive to reward variation
[@2BEHEM7X#Sutton_Barto_2018]. An improvement over acting greedily is to store
in memory the mean rewards, this can provide a way to compare if the selected
alternative is good or bad compared to a global reference of what is the overall
quality of the environment. The classical model by @ESYGCSLH#Charnov_1976,
proposes that animals should decide whether to stay or leave a certain location
based on the mean value of the whole environment. However, such model does not
provide good fit to behavioral data, showing a systematic bias to stay more time
within a certain location that the model predicts [@GC6MVWQU#Nonacs_2001;
@9XVRLKC3#LeHeron_Etal_2020; @RR87DVIX#Pyke_2010;
@H9JQCFZA#Hayden_Pearson_Platt_2011].

For the second case, one way of incorporating uncertainty is through considering
the spread (i.e. standard deviation) over possible outcomes
[@VACKG3ZK#Rothwell_Stock_1988]. This computation of uncertainty implies an
average outcome from which the spread is observed, the anterior cingulate cortex
(ACC) might support this, as is able to represent the magnitude of the spread in
decision making tasks [@GLI8DY99#Christopoulos_Etal_2009]. The representation of
spread within the ACC is quite precise, as is able to integrate cue information
for its representations, that is, a measure of uncertainty, as spread over the
average value, is considered for every cue-related option or context
[@5ANLDC83#VanHolstein_Floresco_2020]. On the other hand, uncertainty can appear
when the outcomes generated by certain action changes. The ACC activity
increases when action-outcome contingencies change drastically
[@BHR2NAEI#Behrens_Etal_2007]. Thus, ACC activity can signal whether an outcome
is within the expected values or the value obtained is totally different from
expected. Being able to distinguish between this two cases is extremelly
important to increase success while searching for food, an animal should not
leave a good spot if it ocasionally bring bad results, and should leave a good
spot if it starts to have consistenly bad results. The orbitofrontal cortex
(OFC) has a role in this regulation. @X6XAHBZA#Stolyarova_Izquierdo_2017 showed
that rats could choose the option with larger mean value despite large
variability. However, a lesion to the orbitofrontal cortex (OFC) impaired this
ability, making rat unable to change their option when the mean value was
decreased. Together, these data show that different measures of uncertainty, are
tracked by brain structures, allowing to choose the best option filtering out
the noise.

The notion, previously presented, that an animals should behave differently when
the outcome is within expected values or has changed drastically, is formalized
in the models of expected and unexpected uncertainty [@4BJ2B6KB#Yu_Dayan_2005].
The model proposes expected uncertainty as the uncertainty regarding outcomes
when contingencies (outcome given a particular action) remain stable but is
subject to some noise. On the other hand, unexpected uncertainty represents a
drastic change in the contingencies likely due to a structural change in the
environment. More precisely, the expected/unexpected uncertainty model proposes
that if the obtained rewards present some variation it should not modify learned
contingencies that map actions with rewards in a given environment, so top-down
control (where value representations are) should dominate over bottom-up input
(sensory information). On the other hand, if obtained rewards present a large
amount of variation, the balance should switch in order to prioritize bottom-up
input increasing learning about new contingencies [@4BJ2B6KB#Yu_Dayan_2005;
@P2FYNJKR#Soltani_Izquierdo_2019].

As mentioned previously, animals should whether changes in the outcome are
expected or unexpected. If the action-outcome contingencies never present abrupt
changes the environment is described as stationary, whereas if from time to time
contingencies change or the mean value goes up or down, then the environment is
defined as non-stationary [@VPX6THEN#Raj_Kalyani_2017]. Animals, tend to behave
as if the environment was non-stationary [@UJSWSGH3#Wu_Iyer_Wang_2018], and they
couple this with an increase in exploratory behavior
[@77AMCAE4#Ryali_Reddy_Yu_2016], as predicted by the expected/unexpected model
[@4BJ2B6KB#Yu_Dayan_2005; @T3QJH2AJ#Cohen_Mcclure_Yu_2007]. While the functional
reasons behind this behavior are not clear, it has been proposed that acting as
if the environment was non-stationary simply does not prove to be problematic in
stationary ones [@77AMCAE4#Ryali_Reddy_Yu_2016], and can be used as an heuristic
in natural environments [@ERS4UNTK#Reverdy_Srivastava_Leonard_2014]. That is,
assuming a non-stationary environment and consequently increasing exploratory
behavior, might prove to be useful in most cases and does not prove to be
detrimental when the environment is stationary.

While exploring the environment can be useful, exploring too much can be
detrimental to actually obtaining food, so exploiting current knowledge about
food location is also necesary. This makes animals face the
exploration-exploitation dillema [@2BEHEM7X#Sutton_Barto_2018]. Exploiting means
that behavior should be consistent with previously learned reward contingencies,
choosing the option with the highest expected value. On the other hand,
exploration implies re-sampling the environment to improve or re-learn current
contingencies. Uncertainty is a key variable to the resolution of this dillema.
Unexpected uncertainty increases the exploratory behavior, boosting learning of
new contingencies, whereas expected uncertainty bias towards explotation
[@T3QJH2AJ#Cohen_Mcclure_Yu_2007; @LEWESIS6#AstonJones_Cohen_2005].

Here we discussed how sensing uncertainty in the food environment regulates
food-seeking behavior. Animals act as if the food environments are uncertain and
non-stationary even if this is not the case, supporting the idea of a deeply
rooted strategy to deal with uncertain environments. One of the key assumptions
behind this idea is that sensing uncertainty is useful because the perceptual
abilities of an animal are limited. We argue against the idea of perceptual
abilities being dominant over the simple search strategies presented
[@92KDU3TH#LascalaGruenewald_Etal_2019], because sensory perception is always
limited in some aspect inroducing uncertainty [@9XCDNBAM#Bartumeus_Etal_2016].

ALl sensory organs have a receptive field, which defines a range where
information can orient food-seeking behavior [@C377F7EP#Fletcher_Etal_2013]. If
an animal must know what is beyond such range, displacement is needed. However,
to inform such displacement, memory, perceptual information integration or other
cognitive process should come into play [@NF2J3H5H#Ranc_Etal_2021], because by
definition such palce lies beyond the receptive field. However, what is
remembered about a certain location loses validity over time. Given that the
environment is in constant change, integrating information of how food
availability changes over can prove to be useful for the foraging animal
[@LDCMV4VS#Fagan_Etal_2017].

Integrating information of location and availability over time can inform
food-seeking behavior. However, obtaining good quality information requires the
animal to explore its environment, which at the same time can modify the quality
of information obtained. The speed-perception tradeoff describes how perceptual
abilities are degraded as speed is increased
[@KU6TMHRT#Campos_Bartumeus_Méndez_2013], rapid approaching speeds are required
to capture prey or obtain food resources, otherwise food location can change or
be consumed by another animal, rendering the information useless; however,
moving fast prevents animals to make an exhaustive exploration of its
environment [@LDCMV4VS#Fagan_Etal_2017]. On the other hand, the
intensive-extensive tradeoff points how finding food-resources nearby impairs
finding resources far-away, if the animal is performing and exhaustive search in
the nearby area, information about areas far away is more difficult to obtain
[@VYE5NZFU#Raposo_Etal_2011; @9XCDNBAM#Bartumeus_Etal_2016 ]. Both tradeoffs
imply that in order to obtain knowledge about food location and actually
achieving success in obtaining it, leads to an inevitable perceptual
uncertainty; moving fast makes information about food location harder to obtain,
but at the same time moving fast is necessary to actually obtain food.
Additionally, appropriately exploring the environment forces the animal to focus
on one area and to grow increasingly uncertain of other areas' food resources.
Together, these tradeoffs illustrate how even when perceptual abilities can
inform food location, there is an inescapable uncertainty that animals are
required to deal with.

Given the limitation in perceptual abilities, uncertainty seems to be
inescapable. Even when an experienced animal can remember optimal foraging
paths, random searches with distinct cycles of exploration/exploitation phases
persist [@GNGBMVLA#Kembro_Etal_2019]. The reason why animals still explore, even
when having knowledge of food location, might be that introducing stochasticity
in food-seeking behavior improves success as it makes strategies more resilient
to cognitive errors derived from perception [@YTHQBTQH#Campos_Etal_2020]. The
persistence of strategies that permits the balance between exploitation,
exploration [@KU6TMHRT#Campos_Bartumeus_Méndez_2013], even when they are not
technically needed [@77AMCAE4#Ryali_Reddy_Yu_2016] shows how relevant
uncertainty is food-seeking behavior. In this section we presented the relevance
of uncertainty if food-seeking behavior, and how inescapable it is, because even
when sensory perception can help reduce it at a local scale, in re-introduces
uncertainty on further away locations. In the following section, we will examine
models that consider the case of foraging in uncertain environments to inform
about the underlying processes in food-seeking behavior.

## Foraging models and underlying processes in food-seekings behavior

A model that presents how animals include uncertainty into food-seeking behavior
should include the following considerations: first, the rules determining the
result of the interaction between animal and environment are assumed to be
unknown or only partially known due to the stochastic nature of the environment.
Secondly, the animal may take any action $a$ within a set of possible actions $a
\in A$ for a particular state of the environment $s$. Any action $a$ causes an
stochastic transition from a state $s$ to another state $s'$. As such, the
result of an interaction between animal and environment can be described by its
value $q$, which is a function of both action and current environment state
$q(s, a)$ (Fig. 1). Such model of action, state, and value corresponds to a Markov
decision process [@2BEHEM7X#Sutton_Barto_2018] that captures the intuition of
the decision making process where the animal can take action in the environment,
but the action outcome is partly random and dependent on the current state. In
this model, all environment dynamics are described by the probabilities $p(s', r
| s, a)$, where $r$ is the obtained reward (interaction outcome), and such
probabilities are defined for every pair of $a$ and $s$. A Markov decision
process that includes the perceptual uncertainty, which we deemed inherent to
food-seeking behavior, can be included by considering that states $s$ are paired
with observations $o$ made by the animal to infer state $s$, because the state
cannot be directly observed or there is some sensory noise. Including perceptual
uncertainty makes the animal to consider environment states as the conditional
probability of any particular observation given a state $p(o | s)$, generating a
belief of the current state based on perceptual information
[@W73P5HZ9#Ma_Jazayeri_2014].

To model how an animal represents the value of a given option $q$ in an
uncertain environment, the value of the option becomes a distribution over
possible values that is updated every time an action $a$ is performed. For the
simple case where rewards are obtained or not (without any difference in reward
magnitude), $q(s, a)$ has a Bernoulli distribution $p(X = reward) = a$ and $(p(X
= no reward) = 1 - a)$. Then, these probabilities can be modeled with the Beta
distribution, which takes parameters $\alpha$ and $\beta$. With $\alpha = 1,
\beta = 1$ the Beta distributions produce a uniform distribution over $[0, 1]$
successfully representing the uninformed prior probability for the rewards,
representing total uncertainty about option value. To generate the posterior
probability, every time an action results in a reward, the parameter $\alpha$
increases by 1, biasing the distribution towards 1. On the other hand, if no
reward is obtained, the parameter $\beta$ increases by 1, biasing the
distribution towards 0.

Finally, the mean is defined as

$$\frac{\alpha}{\alpha + \beta}$$

and its variance by

$$\frac{\alpha\beta}{(\alpha + \beta)^2(\alpha + \beta + 1)}$$

With these simple statistical properties of the Beta distribution, we can
represent uncertainty over the expected rewards for any given $a$ and $s$.  The
previously presented way to model environment uncertainty and $q$ is the general
case of Thompson sampling [@ZZ9I6KCZ#Thompson_1933]. To select an action, a
posterior is built for every action and updated according to the previously
stated rules (Fig. 2). Then, for each posterior, a single reward estimate $\hat{r}$ is
sampled, resulting in an estimated value for each action. The action selected
greedily, so $a = argmax_{a \in A} \hat{r}(a)$ where $A$ is the set of possible
actions within an environment [@WFYYPZ3N#Wang_Zhou_2020]. With this simple
algorithm for action selection, the exploration and exploitation of different
actions is balanced, actions with high associated value and certainty will
likely draw high values in the sampling procedure, actions with low expected
value and high certainty will draw low values, and actions with high uncertainty
can draw lower or higher values. Because the process must be performed for every
state, tractability is limited by the number of states. In general terms, a
solution for this is to consider the reward vector as a weighted average over
past rewards, with a step-size parameter $((0,1])$. The lower the value of this
parameter the more weight is given to recent rewards, on the other hand, if it's
closer to 1, then all the reward history is equally considered. More complex
alternatives to this problem include modeling non-stationarity as Poisson
arrival process that modifies the means rewards [@2S4JPDRG#Ghatak_2020],
bayesian approaches to modulate past observed rewards
[@VPX6THEN#Raj_Kalyani_2017], and explicitly modeling environment volatility in
a bayesian setup [@BHR2NAEI#Behrens_Etal_2007].

While this general model can work in non-stationary environments, it doesn't
explicitly considers the belief of the current state based on the perceptual
information received $p(o | s)$. To include this, a probability for every $o \in
O$ by state is necessary, where $O$ is the set of all particular observations
$o$. To model state beliefs, the goal is to obtain the function that maps
observations $o$ to action $a$, given an underlying model that relates states
with observations. A hidden Markov model (HMM) represents this. HMM generates
conditional probability distributions $p(o | s)$. This allows us to explicitly
model how an animal infers the current state given perceptual information
[@B9YLCVG6#Funamizu_Etal_2012; @XBHNGIHT#Yoon_Lee_Hovakimyan_2018;
@TBQJ5HNA#Piray_Daw_2020].

In this section, we offered the elementary considerations for a model of
food-seeking behavior in non-stationary environments, with uncertainty over
action outcomes due to perceptual limitations. Thompson sampling was considered
as the base for this due to its simplicity and elegance in balancing
exploration/exploitation and including uncertainty in the decision process. The
goal here was not to establish or to specify a complete model, but to provide a
more formal framework to relate uncertainty with the exploration/exploitation
dilemma and perceptual limitations discussed in the previous sections. In the
next section we provide evidence on how uncertainty is computed following the
framework presented above and introduce the reward prediction error as a simple
process that could allow animals to compute uncertainty.

## Computing uncertainty

Uncertainty arises from having more than one option, with the motivation to opt for one of those somewhat distributed. Considering that the probability of choosing any given option has a uniform distribution, then uncertainty increases proportionally with the number of options. Shannon entropy [@LUFF6VTC#Shannon_1948 ] formalizes this intuition $$H = - \sum_{i = 1}^{n} p_{i} log_{2} p_{i}$$ so maximum entropy (one bit) is achieved when all the alternatives have the same probability, such as a coin flip. However, if the coin happens to have two heads, then Shannon entropy is 0.

If we consider a simple environment with only one state $s$ and one action $a$ which initiates a food-seeking bout, and only two possible outcomes: food is found ($p$) or not found ($q = 1 - p$), then $H = -(p log_{2} p + q log{2} q)$. If an animal performs multiple food-seeking bouts and none of them are successful $H = 0$, the same is true if all are successful. However, if the probability of a successful food-seeking bout is 0.5, then entropy is maximized $H = 1$. Neural
representation of entropy has been found in the middle cingulate cortex (MCC) specifically encoding outcome entropy [@55XGJCH7#Goñi_Etal_2011; @DRJBKPPI#Gloy_Herrmann_Fehr_2020] so this computation seems to be biologically plausible. However, entropy is not directly available as sensory input, and must be derived from actions and outcomes, which are dependent on the environment state. Previously, through Thompson sampling, we provided a way in which action outcome entropy could be encoded as variance in the posterior distribution. Nevertheless, a more direct way to compute entropy is possible through the prediction error.

The classical model of Rescorla-Wagner [@LFYTIBBR#Rescorla_Etal_1972] modeled
how animals could predict the reinforcing value of a given stimuli $$ y_{t} =
y_{t-1} + \alpha \delta_{n} $$ where the value representation of the stimuli $y$
is obtained by considering the previously estimated value $y_{t-1} weighted
by a learning rate $\alpha$, and a prediction error $\delta$. $delta$ is the
simple difference between the expected reward and the actual reward $\delta_{n}
= r_{t} - y_{t}$ where $r_{t}$ is the obtained reward. An extension to this model has been proposed by [@2BEHEM7X#Sutton_Barto_2018] where the prediction error considers an
estimate of the rewards that gives more weight to current rewards, while still considering past rewards $$ \delta_{n} = R{t} + \gamma \hat{V_{n+1}} - \hat{V_{n}} $$ where $\gamma$ is a discount factor $0 <= \gamma < 1$ for all the history of rewards, and $\hat{V}$ is an estimate for the true value of the reward. Finally, $\alpha : [0, 1]$ is the learning rate which effectively weights the reward prediction error $\delta$ so to make small updates $\alpha \approx 0$ or
rather large ones $\alpha \approx 1$ to the reward estimation.

The Rescorla-Wagner model allows deriving a prediction error based on experience, where the learning rate can be set lower to simulate unexpected uncertainty or higher to simulate expected uncertainty. However, $\alpha$ in such a model is a hyperparameter, thus is not derived from experience. @NZFTTQJZ#Pearce_Hall_1980 model proposes that $\alpha$ can be controlled by the prediction error magnitude $|\delta$ so $$\alpha = \gamma|\delta_{n-q}| + (1 - \gamma) \alpha_{n-1}$$ Higher entropy on reward outcomes increases the probability of error [@7JBVDKC8#Feder_Merhav_1994], thus increasing $|\delta|$ and, consequently, $\alpha$. The behavioral intuition captured in the Pearce Hall model is that the animals should increase its behavioral vigor and attention towards options with the uncertain outcomes [@BVC98GTV#Diederen_Fletcher_2021].

A good candidate neurotransmitter for representing uncertainty is dopamine (DA) as it encodes the prediction error [@8C97FJFI#Nasser_Etal_2017;@AR2TQB84#Fiorillo_2003; @5BR3FL7N#Fiorillo_2011;
@IV9MZSXR#Lak_Stauffer_Schultz_2014; @HLCSQTJB#Glimcher_2011;
@4YU7F96V#Khaw_Glimcher_Louie_2017; @34HNDDL4#Gershman_Uchida_2019], more
specifically, DA phasic median activity encodes reward probability as positive
linear relationship for the conditioned stimulus, and as a negative linear
relationship for the unconditioned stimulus [@AR2TQB84#Fiorillo_2003]. Effectively encoding the prediction of the conditioned stimulus and the surprise for the unconditioned stimulus (if a reward has a low probability, obtaining it should be 'surprising'). The change in DA sustained activation encodes rewards probability analogous to entropy, that is, displaying a peak of activity when the reward is obtained with a probability of 0.5, where maximum entropy is attained, and lower relative levels of activity at a probability of 1 and 0 [@AR2TQB84#Fiorillo_2003]. Similar encoding of uncertainty has been observed in hippocampal activity [@7PXFUSRW#Schiffer_Etal_2012], on the striatum [@6FBLSRK9#DenOuden_Etal_2010], substantia nigra [@6IGYU34R#Zaghloul_Etal_2009], and VTA [@XHH632AS#Iordanova_Etal_2021]. Ventral tegmental area DA activity is well modeled by classical reinforcement models for cue-reward learning tasks, showing predicted changes in activity when previously learned cue-reward paired are modified [@LSWYXCBD#Steinberg_Etal_2013; @8FIHXB6G#Chakroun_Etal_2020]. Moreover, DA activity is capable of regulating exploratory/exploitative behavior via tonic and phasic signaling, respectively [@TN6NBEH8#Beeler_Etal_2010].

There is substantial evidence that DA neurons, specifically in the VTA, serve
the functional role of computing reward prediction errors [@NLDHLRVN#WatabeUchida_Eshel_Uchida_2017 ], by weighing inputs from multiple
brain areas, most remarkably the lateral hypothalamus, dorsal and ventral striatum, ventral pallidum, and subthalamic nucleus [@SFZIJKFP#Tian_Etal_2016]. Acetylcholine (ACh) and norepinephrine (NA) activity has been proposed to signal expected and unexpected uncertainty, respectively [@4BJ2B6KB#Yu_Dayan_2005]. Both neurotransmitters are mainly produced in the basal forebrain [@D8EGNYCV#Sturgill_Etal_2020] and locus coeruleus (LC) [@TA5KB3TF#Sales_Etal_2019; @LEWESIS6#AstonJones_Cohen_2005] and also play an important role in the reward prediction error signal. ACh antagonists increase the response sensitivity to expected uncertainty [@9X7Z6PMX#Marshall_Etal_2016], which supports the role of ACh as signaling expected uncertainty, or in other words, that changes in the outcomes are part of chance fluctuations and there are no structural changes present. On the other hand, LC tonic activity signals unexpected uncertainty promoting the learning of new contingencies by increasing exploratory behavior [@9Z525EYW#PayzanLenestour_Etal_2013; @LEWESIS6#AstonJones_Cohen_2005].

In this section, we presented simple models showing how uncertainty can be computed using the reward prediction error without any meaningful computational complexity. One of the main candidates for supporting the computation of the reward prediction error is DA activity within the VTA, paired with ACh and NA activity modulating the sensitivity of DA according to whether we are in presence of expected or unexpected uncertainty. In the following two sections, we will show empirical evidence on how food-access uncertainty increases food-seeking behavior, which in turn could contribute to overweight related issues in modern times. Finally, we will propose the orexin neuropeptide as a potential mediator of the uncertainty-driven increase in food-seeking behavior.

## An adaptive strategy in modern times

Food-seeking behavior adapted to environments with limited food. When food is
limited animals approach cues with the highest associative strength to actual
food [@B8QZIGEN#Montague_Dayan_Sejnowski_1996]. If a lever was associated with
food delivery, but now food is being delivered randomly 50% of the time upon
lever pressing, then the reward prediction would increase until the expectation
is re-adjusted, and the animal should lower the its rate of lever pressing
compared to when the lever always delivered food
[@8Q6QHXGB#Kacelnik_Bateson_1996]. However, uncertainty in food delivery
increases lever pressing and reduces the time latency for approaching the lever
[@S8CHV5KG#Anselme_Robinson_Berridge_2013], which in fact means the opposite of
preferring cues with highest associative strength food.

Intermittent access to high-fat diets generates binge-eating behavior
corresponding to drastic increases in food-seeking behavior
[@QN55S25U#Hess_Etal_2019; @CTAFJAZ3#King_Etal_2016;
@MBZJPLN3#Lardeux_Kim_Nicola_2013], increases reinforcement value upon
withdrawal [@BDVQLHQZ#Mcgee_Etal_2010] and operant behavior without withdrawal
[@8KGR8TT6#Wojnicki_Babbs_Corwin_2013; @DQHTA2QH#Wojnicki_Stine_Corwin_2007;
@WPLVSADN#Wojnicki_Etal_2015] attenuating the effects of food devaluation,
general psychomotor behavior increases [@GIDJCJMP#Hardaway_Etal_2016], and
DA-Ach release also increases, augmenting motivated behavior towards food
[@23K7IPBA#Rada_Avena_Hoebel_2005]. Mainly because of logistic reasons,
intermittent access is provided at the same time of the day (in most cases), and
that allows animals to predict the arrival of food, although with some
inconsistencies within animals [@KUXWM8W5#Luby_Etal_2012]. However, the
behavioral effects, except anticipatory behavior, are common disregarding if
intermittent access is provided at completely random time or given at fixed
times of the day [@VY8ZEZB6#MuñozEscobar_GuerreroVargas_Escobar_2019]. Taken
together, this data suggests that food-seeking behavior increases in response to
uncertainty in action-outcome association, and food availability.

Food-seeking behavior is increased to avoid starvation when a food shortage is
predicted, and as previously noted, this derives in increased exploration,
number foraging bouts, and time expended in foraging
[@G83L8BXA#Harris_Chapman_Monfort_2010]. Food insecurity is defined as the
perception of how secure or certain food access is going to be in the future
[@WZS8BTVL#Dhurandhar_2016], and positively correlates with greater energetic
intake [@WZS8BTVL#Dhurandhar_2016] and preference for high-fat alternatives
[@EER2TNCJ#Nettle_Andrews_Bateson_2017], which are mainly cheap access foods in
developed countries where this effect is more pronounced
[@4LJKTR3N#Moradi_Etal_2019; @2N6SBNMK#Dinour_Bergen_Yeh_2007;
@VDHUFYYV#Nettle_Bateson_2019]. The effect of food insecurity on increased
intake are probably due to overeating fats and carbohydrates (cheap access and
calorically dense foods) in periods of high food availability, leading to
overweight [@2ZRH7IWR#Stinson_Etal_2018]. In modern urban environments, high-fat
food is of easy access; this, coupled with a food-seeking behavior which seeks
to maximize energetic gain when food shortage is predicted due to food-access
uncertainty, can lead to overweight, because the mechanism is adapted to low
resource environments and not calorically dense one. Thus, in developed
countries, where caloric density is extremely high, increasing food-seeking
behavior is likely to result in excessive caloric intake.

 In this section we showed how action-outcome uncertainty, intermittent food
 access, and food insecurity show converging evidence on how food access
 uncertainty invigorates food-seeking behavior. However, coupled with an easy
 access to highly energetic foods, an adaptive behavior for preventing
 starvation, turns maladaptive resulting in overweight. In the following
 section, we present orexin as a potential mediator of uncertainty-driven
 foraging because of its pivotal role in both reactive and predictive
 homeostatic control [@52DV95LU#Burdakov_2020], and motivated behavior
 [@2X7SNKS3#Tyree_Borniger_DeLecea_2018].

## Orexin as a potential mediator of uncertainty-drive foraging

Animals respond to the environment by seeking to preserve certain physiological
parameters within a normal range, this homeostatic process is highly adaptive
and can generate transient changes within animals physiology [@7BNMJXRJ#Davies_2016]. The hypothalamus is a relevant structure in the homeostatic process, being capable of
controlling arousal levels [@3ZQDGXXZ#Adamantidis_Carter_DeLecea_2010;
@HQFDMJJ8#Kosse_Burdakov_2014], motivation for food intake [@6FUPLHIJ#Castro_Berridge_2017], receiving internal status information of fat deposits via leptin signaling [@RWABER6F#Pandit_Beerens_Adan_2017; @DHNLNHHI#Meister_2000], and gastrointestinal status via ghrelin signaling [@NRWCYJCX#Müller_Etal_2015; @W3IUQNUY#Toshinai_Etal_2003]. Together, this functionality takes the hypothalamus to a pivotal role in the homeostasis process, specifically related to food intake control.

Orexin or hypocretin is a neuropeptide with few neurons producing it, most of
them located within the lateral hypothalamus and perifornical area, but with
large projections throughout the brain [@EFWJQ65B#Chowdhury_Etal_2019]. Its
functions range from regulating sleep/wakefulness states [@AR3R5QLP#Chemelli_Etal_1999] to energetic balance [@KPIHYUYF#Yamanaka_Etal_2003]. Thus, lateral hypothalamus orexin neurons are in a well-suited spot to control foraging-related behaviors. Orexin activity
promotes locomotor activity but is rapidly inhibited upon contact with food [@7GXEINLY#González_Etal_2016], activity increases upon sucrose predictive cues
[@PIJIVQER#Hassani_Etal_2016], and in certain subpopulations, the increased spontaneous physical activity is directed towards food sources [@Y4UZKQ5V#Zink_Etal_2018]. Thus, orexin-related activity can be interpreted as food procuring signal [@Y4UZKQ5V#Zink_Etal_2018]. Further support for this interpretation comes from orexin increasing olfactory activity [@X9STRHXX#PrudHomme_Etal_2009], enhancing visual attention [@7ZXMSXYC#Zajo_Fadel_Burk_2016], impairment of spatial working memory in orexin knockout mice [@Z2G6BP2E#Dang_Etal_2018], among others which have been classified as foraging-related behavior by @LBGV5NJ5#Barson_2020.

Orexin might support foraging-related behaviors including uncertainty-driven food-seeking behavior. Orexin connectivity with VTA, LC and basal forebrain [@PQWIJHAP#Siegel_2004], might modulate DA, ACh and NE activity, respectively. Such connectivity hints at a possible role of orexin in promoting food-seeking behavior via prediction-error derived expected and unexpected uncertainty. 

VTA has glutamatergic projections into the nucleus accumbens shell, specifically into parvalbumin GABAergic interneurons. Activation of GABAergic interneurons results in inhibition of medium spiny neurons activity into the lateral hypothalamus  @IUF535G9#Qi_Etal_2016], which are known to be inhibitory [@TIF7X9CT#O’Connor_Etal_2015; @M2RERH96#PerezLeighton_Etal_2017]. This inhibition results in a increase of lateral hypothalamus activity [@VD2436JM#Stratford_Kelley_1999;
@ZCDTXFJI#Gutierrez_Etal_2011]. This connectivity makes posibles that DA activity response to environmental uncertainty, to increase lateral hypothalamus activity via dopaminergic inputs to the supramammillary nucleus [@4SMCFQII#Plaisier_Hume_Menzies_2020]. Additionally, a positive feedback loop between VTA and lateral hypothalamus can be established with the inhibition of the nucleus accumbens shell, as previously described. This could result in a net increase of food-seeking behavior via uncertainty-driven activity in the VTA.

Orexin signal depolarizes the LC [@A5ZYWRZW#Hagan_Etal_1999] promoting task disengagement [@KA4Y29AG#Kane_Etal_2017], altered network
representation of tasks [@GFA24ABK#Grella_Etal_2019], and updating world models containing action-outcome pairings [@TA5KB3TF#Sales_Etal_2019], likely via promotion of exploratory behavior related to LC tonic firing [@LEWESIS6#AstonJones_Cohen_2005]. Task disengagement and updating of action-outcome pairings point to a role of orexin in modulating uncertainty-related behavior, specifically regarding unexpected uncertainty. On the other hand, orexin is also related to ACh activity via a positive feedback loop with the basal forebrain [@A93676U3#Sakurai_Etal_2005]. ACh activity somewhat mirrors DA prediction error [@D8EGNYCV#Sturgill_Etal_2020], so DA and ACh connectivity with orexin could generate a similar uncertainty-driven activity. However, ACh activity might have an additional role by signaling a smaller variance in outcome results[@S3YZPJJI#Puigbò_Etal_2020; @4BJ2B6KB#Yu_Dayan_2005] effectively sustaining an expected uncertainty signal.

In this section, we provided a plausible circuit where orexin activity acts as a hub integrating prediction error with unexpected uncertainty and expected uncertainty. This puts orexin as a candidate neuropeptide for modulating uncertainty-driven food-seeking behavior, as it can integrate environmental and internal status information to promote food-seeking behavior when necessary, while considering environmental stochasticity. We derived this plausible orexin function taking theoretical and empirical findings from foraging theory, computational models of reinforcement learning and literature on homeostatic control of food intake, allowing us to propose a functional role for orexin situated in the proper evolutionary and environmental context.

\pagebreak

# Objectives

## General objective

Determine how uncertainty in food-access increases food-seeking behavior, and
how orexin mediates uncertainty-driven increased food-seeking behavior.

## Specific objectives

1. Determine whether increased uncertainty in substainance food access increases
   motivation for palatable foods.

2. Determine whether increased unceratinty in an obesogenic environment
   increases motivation for palatable foods.

3. Determine whether orexin promotes uncertainty-driven motivation for a sucrose
   solution. We will model uncertainty by presenting two alternatives one with
   uncertainty and the other with certainty about reward delivery. However, here
   choosing one option implies not choosing the other. Uncertainty-driven
   motivation will be considered as a change in the selection ratio between
   certain and uncertain alternatives in saline and orexin injected mice. We
   will also test the ratio change while blocking orexin function.

4. Determine the differential gene expression in the hypothalamic area in
   uncertainty compared to certain conditions of specific objective 1. We will
   perform real time quantitative PCR (RT qPCR) on hypothalamic brain tissue of
   subjects in both conditions present in specific objective 1.

5. Determine if orexin/dynorphin neurons projecting to the paraventricular
   nucleus and VTA are active during sucrose intake. We will inject a retrograde
   tracer into PVN and VTA and identify fos expressing projections after an
   operant task of sucrose acquisition.

# Hypothesis

## General hypothesis

Food-access uncertainty increases food-seeking behavior, and this increase is
modulated by orexin-neurons activity.

## Specific hypothesis

1. Food-access uncertainty, in substainance food supply and in obesogenic
   environments, increases food-seeking behavior.

2. Prolonged exposure to food-access uncertainty environments increases
   prepro-orexin and orexin receptor expression in the hypothalamus.

3. Orexin, during hedonic intake, presents functional connectivity to the VTA.

4. Orexin agonists increase the choice of uncertain options when presented with
   a certain and uncertain alternative, while orexin antagonists reduce the
   choice of uncertain options, relative to control.

# Methods

## Specific hypothesis 1, Experiment 1

### Animals

16 normal C57/BL6 mice. Sample size was selected by estimating the effect of
uncertain access to food in operant behavior reported in
[@BWVUS5B9#Parkes_Etal_2017], with a statistical power of 80% and $\alpha = 0.05$ the sample size per group is estimated at n = 4. For differential gene expression sample size was selected according to literature reporting sample sizes of 4-6 for orexin expression [@37QP9J8W#Pankevich_Etal_2010; @GAZJE6IJ#AlcarazIborra_Etal_2014]

### Experimental design

Mice (n = 16) will be housed individually with a 12/12 hr (light/dark) schedule, within each cage an automatic feeding device will be placed, delivering nutritionally complete food-pellets. Animals will be in this condition for a week to acclimate to the feeding device. After the acclimation period,  mice will be split in two groups (n = 8), balancing for food-pellet intake. The control group will maintain the same conditions as the acclimation phase, whereas the treatment group will receive food pellets with a random delay centered on the mean delay of the control group (15 seconds). After 6 weeks, 4 randomly selected mice from each group will be euthanized and their brains extracted for quantitative analysis of gene expression. Remaining animals (n = 4, per group) will complete 10 sessions of a progressive ratio task for sucrose.

### Random delivery of food pellets

The feeding device delivers exactly one pellet with a delay of 15 seconds once a pellet is removed from its cup. The random delay will be modeled as random samples from a truncated normal distribution with 15 second as the mean and a standard deviation of 1 minute. As such, once the food pellet is removed from the cup, in the random delay condition, the next pellet will be delivered with a mean of 15 seconds, but with a possible range from 0 to 1 minutes.

### Progressive ratio task

The progressive ratio task consists of a cage with two spouts, one with water and the other one with a sucrose solution, alternating positions between sessions. Mice will be trained in 5 sessions (60 min each) to receive either water or sucrose after 5 licks, throughout the session. In the progressive ratio task, the required amount of licks will increase logarithmically starting from 5 within the 1 hour duration of the task, after every reward acquisition the spout will be inactive for 20 seconds. 

### Quantitative analysis of gene expression

Mice will be euthanized with isoflurane. Brain will be removed and stored at -80
C until hypothalamus dissection. RNA will be isolated by using TRIzol
(Invitrogen) according to the manufacturer's instructions. Primers for
prepro-orexin, orexin 1 and orexin 2 receptors will be prepared for real-time
quantitative PCR according to [@L2MVQGK9#Lazzarino_Etal_2019].

### Materials and instruments

### Feeding experimentation device 2 (FED 2)

Is an automatic feeding device with an open-source design, and all its parts 3D printed in polylactic acid (PLA). The device consists of two main parts: a reservoir where food pellets are stored, and a cup where food-pellets are delivered. The cup contains a photo-interrupter that detects if a pellet is within the cup, each time a pellet is removed and after a determined delay another food-pellet comes down from the reservoir. This device allows us to measure (1) the exact number of food-pellets removed [@JGIIVLN5#Nguyen_Etal_2017], (2) the time when each of the pellets were removed, and (3) how many times the animal tried to reach for a food-pellet.

### Lickometer

This device consists of a cage with two spouts that can deliver a predetermined amount of liquid solution. Each spout detects contact with the animal tongue, allowing us to measure the number of licks per spout, and when they were performed. This allows us to characterize the intake behavior by considering (1) the time between successive licks, (2) the distribution of the time between licks, and (3) differentiate the number of licks and the number of rewards obtained. Our laboratory previous pilot studies have shown that between 5 to 7 sessions are sufficient for animals to stabilize their behavior and learn the operant task. For acclimation purposes the lickometer is equipped with two spouts that deliver water and a sucrose solution upon 5 licks.

### Data analysis

Our main interest is to measure food motivation given prolonged exposure to uncertainty in food-access. Food motivation will be measured as the number of events for sucrose in the progressive ratio task- an event is when the animal performs the required number of licks when the spout is active.

### Data analysis pipeline

Estimate the difference between control and treatment group regarding the number of events. To do this we will fit a negative binomial generalized mixed model, which allows us to appropriately model count data (number of events) under the negative binomial distribution, and explicitly account for individual response to treatment while adjusting for meaningful variables such as weight and mean food intake.
Characterize the food-seeking behavior in the treatment and control group using a lick microstructure analysis [@JGIIVLN5#Nguyen_Etal_2017]. Lick microstructure mainly accounts for the pattern analysis of inter-lick intervals (ILI), which corresponds to the time elapsed between a determined lick and the next one. Our main patterns of interest are bursts, which correspond to rapid successive licks that are within an ILI of 500 ms between each other. Bursts are further divided into burst number and burst length, which correspond to the number of clusters under the burst definition, and how many licks compose each of those clusters, respectively. This allows us to differentiate between ‘motivation’ related behavior (burst number) and ‘liking’ response (burst size) [@ZVNAACB5#Johnson_Etal_2010]. Previously described features will be used as dependent variables in the mixed effects models to assess group differences.
Compare food-pellet intake between groups. Using the previously described model we can compare the main and temporal course effect of uncertainty in food-pellet count within the home cage, allowing us to compare an estimation of daily caloric intake.
Obtain a measure of transcriptional differences between groups in prepro-orexin and orexin receptors. Using qPCR we aim to obtain an average relative normalized expression per group, to statistically determine differences we will perform a Student’s t-test between groups for previously mentioned genes of interest. Statistical analysis will be performed using the bioconductor package [@QJDJKYD4#Gentleman_Etal_2004] and the ddCt algorithm [@3RSH6K5F#Livak_Schmittgen_2001].

## Specific hypothesis 1, Experiment 2

### Animals

8 normal C57/BL6 mice. Sample size was calculated with the same criteria of
experiment 1 for differential gene expression. For behavioral effects of
uncertainty a pilot experiment determined that a sample size of 4 is necessary
to observe a statistically significant effect.

### Experimental design

Mice (n = 8) will be housed individually with a 12/12 hr (light/dark) schedule, nutritionally complete food-pellets and water will be provided ad-lib. For two weeks animals will be acclimated to the lickometer device. At the end of the acclimation phase animals will be splitted into two groups (n = 4) balancing on the total number of events. The control will continue with the same setup as the acclimation phase, whereas the treatment group will have one spout delivering the sucrose reward randomly 50% of the times upon 5 licks, and the other spout delivering the same sucrose reward 100% of the time for 60 minutes, alternating positions between sessions. This phase will last for 2 weeks, at the end of which animals will be euthanized with isoflurane, its brain extracted, and samples from the hypothalamus taken and prepared for RT qPCR following the protocols of the previous experiment.

Materials and instruments consist of the same lickometer described in experiment 1, variables of interest are also the same as experiment 1.

### Data analysis

Our main interest is to measure how the food-seeking behavior of animals is affected by introducing uncertainty, while retaining a certain alternative. This will allow us to model an obesogenic environment where uncertainty is present. Main analyses are similar to experiment 2, but a reinforcement model is included as part of the analysis pipeline in order (1) determine the inclusion of uncertainty modifies decision processes within food-seeking behavior, and (2) compare actual food-seeking behavior to optimal models of food acquisition to determine if exploration of uncertain options is rewarding for the animal.

### Data analysis pipeline

Compare the number of events and licks, relative to baseline, of both control and treatment groups. As we are expecting a general trend towards reduction of both events and licks due to sucrose devaluation, we will fit the same model as experiment 1, but including the interaction between treatment, session number and group, while adjusting for baseline number of events and licks.
To model food-seeking behavior we will consider each lick as a choice for one of the two spouts. Because the expected (average) value of a choice corresponds to the probability of reward delivery of a given spout and animals will be well trained in the task, we will assume that animals know the expected value of each spout. We will compare an epsilon-greedy choice rule to model the intuition that if uncertainty does not affect reward value, then choice should be mostly directed towards the spout with reward probability of 1, but with some stochastic deviation from this, for example, due to spout position preference. On the other hand, to model an effect of uncertainty in reward value we will use the Thompson sampling model, which establishes a belief distribution of the value of each spout, and then samples that distribution so beliefs centered around larger values would be sampled often, however uncertain options will also be sampled as the belief of the value can have a large variance between a small and a very large value. Model parameters will be determined using maximum likelihood estimation among standar statistical techniques [@KHHA3LNQ#Wilson_Collins_2019], and model comparison bayesian information criterion to determine the best fit to animal choice data between epsilon-greedy and thompson sampling models.
Gene expression fold change will follow the same procedure as the previous experiment, effectively allowing us to observe if there are differences when uncertainty is introduced in an obesogenic environment or within the home cage food.

## Specific hypothesis 3, Experiment 1

### Animals

18 normal C57/BL6 mice. Preliminary results from our laboratory indicated that 4 mice per group are necessary to observe Fos differences in food intake (Coehn’s d = 0.25, p < 0.05) with immunofluorescence techniques (Carolina Sandoval, datos no publicados). Assuming an effect size of 80% of preliminary studies for positive control, resulting in 6 required animals ( $\alpha$ = 0.05 y $\beta$ = 0.8). Assuming a 80’% success rate in the bilateral tracer injection, this results in 9 required animals per experimental group, 18 in total.

### Experimental design

18 mice will be injected in the VTA with a retrograde fluorescent tracer using stereotaxic surgery. Animals will be maintained with food and water ad-lib and in a 12/12 (light/dark) schedule, without any kind of intervention until they are fully recovered from surgery. Using the previously described lickometer, animals will be exposed to 30 minutes sessions with two alternating spouts delivering water and a sucrose solution upon 5 licks for treatment group (n = 9), and the two spouts delivering water for control group (n = 9). After 6 sessions, animals will be euthanized 90 minutes after the beginning of the session by isoflurane. Brain will be extracted under standard techniques for immunofluorescence to evaluate orexin neurons present in both the retrograde tracer mark and Fos neuronal activity marker.

### Data analysis

This experiment will test the hypothesis that there exists the necessary functional connectivity between orexin neurons and reward processing brain structures in hedonic intake of sucrose. 

### Data analysis pipeline

The percent of orexin and co-released dynorphin neurons expressing Foss that are labeled with retrograde tracers will be analyzed with a two-way ANOVA, with the experimental group as a dependent variable. This will allow us to determine if this functional connectivity is present exclusively in hedonic intake compared to only water intake.

## Specific hypothesis 4, Experiment 1

### Animals

18 normal C57/BL6 mice

### Experimental design

Mice (n = 8) will be housed individually with a 12/12 hr (light/dark) schedule, nutritionally complete food-pellets and water will be provided ad-lib. Cannulas will be implanted unilaterally aiming at the VTA, and will be left to recover without any intervention for one week. After recovery and for two weeks, animals will be acclimated to the lickometer device, with the same setup as experiment 2 except that here, choosing any of the two spouts, makes both spouts inactive until the animal makes them active by staying on top of a sensor plate located equidistant from both spouts for 1 second. After the learning phase, for 5 sessions, the spouts will be changed to one delivering a 5% sucrose solution 100% of the time, whereas the other will randomly deliver 50% of the time, alternating positions between sessions. For the next 10 sessions, spread 48 hours apart, animals will perform the same task after VTA injections of orexin-A and an orexin receptor antagonist TCS1105 (0.3 nmol / side) in random sequence for 5 sessions each. All sessions will be recorded with an infrared camera to obtain movement data, each camera frame will have a timestamp to synchronize the video with events during the task offline.

Materials and instruments are the same as previous experiments. In addition, a sensor plate will be placed equidistant to each spout, this plate sensor allows us to enforce a trial structure to the task, where each trial begins after the animal touches the plate for 1 second, and ends when a spout is chosen. Infrared video data will be processed with a custom-made image processing software, to obtain animal centroid. Allowing us to track animal movement at a resolution of ~30 frames per second. Similar to previous experiments using the lickometer, the main measures obtained are the number of events and licks per spout with a timestamp, and positional  “x-y” data from video recordings.

### Data analysis

Our main interest is to measure how orexin-induced activity modifies the choice ratio between uncertain and certain alternatives, in a forced-choice paradigm. Additionally, behavioral trajectories between trial start and end will inform us of locomotor activity up to decision, which can be considered as the exploratory activity.

### Data analysis pipeline

Compare the ratios of uncertain to certain options between conditions without drug, orexin antagonist and orexin agonist. This will be performed using a two-ways repeated measures ANOVA for choice ratio, using drug and session number as covariates.
A mixed effects logistic regression will be fitted to data in order to obtain a more fine-grained effect of orexin in the choice between spouts. The logistic model will allow us to determine the change in odds for choosing the certain or uncertain option, while controlling for individual differences, weight and baseline number of events. Additionally, adding session time courses as a covariate, will allow us to observe differences in choice behavior within each session.
Video recording will allow us to compute the area under the trajectory curve, which basically measures the distance between an optimal (straight) path from the sensor plate to the spout chosen and the actual path taken, so more deviation accounts for a larger area. Area under the trajectory curve can inform us about invigoration of exploitative behavior between conditions, and coupled with instantaneous speed and traveled distance, the time spent in exploratory behavior versus exploitative behavior can be inferred. Repeated measures ANOVA with Tukey post-hoc pairwise comparison, will allow us to determine the difference between these measures between the drug conditions.

\pagebreak

# Figures

![An animal in state $s$ upon choosing the blue option receives a food reward.
In turn, choosing the blue option changes the state to $s'$ where choosing the
same action does not deliver food. Here the value $q$ is dependent on both action $a$ (red or blue) and state ($s$ or $s'$)](/home/nicoluarte/phd_thesis/chapters/fig1.png)

![Creation of posterior distributions for possible actions. (1) the animal has
never choosen any option so it thinks that the lever has an equal probability of
given food or not. (2-3) the animal then sample both options, the blue one
delivers food so the belief distribution is slighty bias toward that option
delivering food, whereas the red option shows the opposite. (4) the animal
re-samples the red option, but now food is delivered increasing the spread of
the belief distribution, representing uncertainty on whether the red option is
expected to give food or not. (5) The blue option is sampled again and food is
delivered, thus increasing the bias towards the blue option delivering food,
leaving less uncertainty over this option.](/home/nicoluarte/phd_thesis/chapters/fig2.png)

\pagebreak

# References


