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
\title{Proyecto de tesis doctoral para optar al grado de Doctor en Neurociencia en la Pontificia Universidad Católica de Chile: Orexin and uncertainty effects on food-seeking behavior}
\author{Luis Nicolás Luarte Rodríguez - Claudio Peréz-Leighton}

\begin{titlingpage}
\maketitle
\end{titlingpage}

\pagebreak

# Introduction

Mammals evolved in an environment of food scarcity; thus, maintaining fat
reserves and overall caloric intake is extremely important. Most animals
accomplish this by increasing food-seeking behavior when food access is limited,
resulting in extended foraging bouts. However, foraging and larger fat reserves
can increase predation risk by increasing exposure and reducing mobility,
respectively. Therefore, increasing foraging bouts should only occur when the
risk of starvation outweighs the risk of predation. One environmental clue that
animals use to make this decision is uncertainty in food access: higher levels
of uncertainty in food access predicts future food scarcity, triggering
food-seeking behaviors. This prediction allows animals to act upon proximal cues
without knowing the complete state of the environment.

Relating uncertainty to food scarcity is a successful adaptive strategy when
food is limited, but modern environments are plentiful. Thus increased
food-seeking behavior leads to excessive intake, higher risk of overweight and
obesity. We propose that the prediction error, between expected and actual intake
from foraging bouts, translates into a measure of food-access uncertainty.
Increasing uncertainty generates unreliable expectations, therefore, more
prediction errors. Leading to an orexin mediated increase in food-seeking
behavior.

The neurobiological mechanisms that regulate food-seeking behavior and foraging
must use information about a nutrient deficit to increase alertness and physical
activity to forage successfully. The neuropeptide orexin has the potential to be
a mediator of foraging behavior. Fasting and intake respectively increase and
decrease the activity of orexin neurons, and activation of orexin receptors in
different brain sites increases physical activity and food intake. Additionally,
orexin promotes foraging behavior by increasing locomotor activity before
food intake in response to a nutrient deficit.

Together, these data led us to hypothesize that orexin promotes
food-seeking-related behaviors when facing uncertainty related to food access.
Our overall aim is to determine how uncertainty in food-access increases
food-seeking behavior, and how orexin mediates uncertainty-driven increased
food-seeking behavior.

# General research strategy

To determine how uncertainty in food-access increases food-seeking behavior we
will use two experimental strategies: (1) behavioral modeling using the
reinforcement learning framework to assess changes in reward processing due to
uncertainty, and (2) operant tasks to manipulate uncertainty levels in food
acquisition. To determine how orexin mediates uncertainty-driven food-seeking
behaviors we will (1) assess differential gene expression in conditions with and
without uncertainty using real time qPCR, obtaining correlational-level data
on orexin as a mediator of uncertainty-driven food-seeking behavior; (2)
determine if orexin is necessary to drive increased food-seeking behavior in
uncertain conditions with the use of orexin antagonists, and gain of function
with orexin agonist, (3) We will test functional connectivity between
hypothalamic orexin neurons and paraventricular nucleus/ventral tegmental area
(VTA), to determine if orexin mediation of uncertainty-driven food-seeking
behavior can be supported as a modulation of reward-related systems.

\pagebreak

# Theoretical and empirical framework

## The natural setting for food-seeking behavior

Foraging encompases all behaviors related to obtaining food, including
food-seeking, feeding and hoarding [@V3Z2UVAU#Kramer_2001]. Food-seeking
behavior is the re-orientation of attention and locomotor activity with the goal
of acquiring food. A successful food-seeking behavior minimizes energy
expenditure while reducing exposure to potential predators to find food. Because
the environment is constantly changing, food seeking strategies must also be
constantly adapting [@9XCDNBAM#Bartumeus_Etal_2016;
@BWKDXXFW#Kölzsch_Etal_2015]. However, animals are never completely aware of
when or how an environment changes, so they always have incomplete knowledge of
food location, quality and the probability of obtaining food
[@ZD73QGIR#Pyke_1984].  Thus, the main challenge for the foraging animal is how
to determine an optimal strategy to procure food while having only partial
knowledge of its food environment.

The necessary information to determine a food-seeking strategy are the overall
statistical properties of the environment: how dense are the food targets in a
given area, how variable is the quality of food (i.e. calories, organoleptic
properties), and what is the expected outcome of foraging  in a given area.
Given that an animal must consider all these potential characteristics of the
environment to search and find food while minimizing energy expenditure and
predator exposure begs the question: _**what kind of strategy could accomplish
this while having only partial or incomplete knowledge about the food
environment?**_

The movement data of several species (including human) during food-seeking
behavior can be described using Lévy-walk patterns [@7YQKP7Z2#Garg_Kello_2021;
@I2BS842S#Reynolds_Etal_2018; @TPRPLPEC#Viswanathan_Etal_1996;
@BWKDXXFW#Kölzsch_Etal_2015]. Lévy-walks are random walks with a Lévy
distribution, which produces heavy-tails and describing multiple concentrated
movements with sharp turning angles followed by few ballistic displacements.
These patterns produce optimal searches in environments with a patchy
distribution of resources (clumped resources distant to one another)
[@97UESCC6#Wosniack_Etal_2017]. Although how animals produce Lévy-walks patterns
is unknown [@I2BS842S#Reynolds_Etal_2018], this mechanism might be partially
independent of sensory information regarding environmental feed-back
[@M5RXPXSZ#Humphries_Sims_2014; @5WUMQR2H#Sims_Etal_2019]. Wait and move
foraging patterns, across multiple species, retain the same Lévy-like
distribution in natural, simple captive environments
[@55ZWLF4S#Wearmouth_Etal_2014] and when devoided from environmental feed-back
[@YPHZTQH2#Maye_Etal_2007]. Showing that important features of foraging such as
deciding when to wait for prey, and when to move on to catch prey are
independent of sensory information. Moreover, the Lévy-walk foraging pattern is
present in multiple species which inhabit diverse environments and have
different sensory abilities [@UM497IEK#Humphries_Etal_2010]. Evidence of
Lévy-walks being either completely or partially independent of sensory
information are thought to reflect a strategy selected in early evolution to
optimize food searching with partial or complete lack of knowledge of food
location [@97UESCC6#Wosniack_Etal_2017].

While Lévy-walks can describe a search strategy to find food with only partial
knowledge of the environment [@BWKDXXFW#Kölzsch_Etal_2015;
@5WUMQR2H#Sims_Etal_2019], sensory information can inform when to switch the
strategy.  It has been observed that food encounters create deviations from
Lévy-walks making movement more focused within the area where food was found
[@MPYTP8HE#DeJager_Etal_2011]. The intuition here is simple, if an animal finds
food in a particular area, then there is a good chance that more food will be
nearby. This strategy switch is thought to reflect an adaptation to environments
where food is usually clumped together [@5KMWW8NS#Reynolds_Frye_2007;
@F9HICU4A#Nauta_Khaluf_Simoens_2020]. While this strategy switch is informed by
sensory information, the main feature is that it relies on simple strategies
that are in tune with the usual distribution of food in the environment
[@M5RXPXSZ#Humphries_Sims_2014]. Thus, limiting the need to use sensory
information.

Starting from the base that animals have only partial knowledge about food
location, we discussed that Lévy-walks are a food seeking strategy partially
independent of perceptual information, and we proposed that this strategy could
have emerged to deal with environmental uncertainty. In the next section, we
will explore how considering uncertainty, within the food-seeking strategy, can
be useful when perceptual abilities are limited, and how uncertainty itself can
modify food-seeking behavior [@HJ7CGIEU#Anselme_Robinson_2019;
@3YWCKUUK#Anselme_Otto_Güntürkün_2017; @C6Z374UG#Anselme_Güntürkün_2019].

## Foraging and uncertainty

As discussed previously, animals adopted food-seeking strategies to procure food
within uncertain environments [@M5RXPXSZ#Humphries_Sims_2014;
@5WUMQR2H#Sims_Etal_2019]. Here, we will discuss how environmental uncertainty
can regulate food-seeking behavior and the neuronal representation of
uncertainty.

To illustrate how environmental uncertainty can influence food-seeking behavior,
we can consider two scenarios, one where food-seeking behavior strategies does
not consider uncertainty and one where it is considered. In the first scenario,
an animal will randomly sample a section of its environment for food sources and
pick the one that, at that time, delivered the greatest amount or quality of
food. This sampling and choice strategy is called greedy
[@JH5D2C9Z#Tokic_Palm_2011] and implies that the animal will continue to choose
the option that yielded the most value in an initial random sampling, missing
out on potentially better alternatives that did not deliver good rewards or
sticking with its original choice even when its value or quality has dropped due
to food resources being consumed. This is problematic as it makes food-seeking
strategies insensitive to reward variation [@2BEHEM7X#Sutton_Barto_2018]. An
improvement over acting greedily is to store in memory the mean value (i.e.
quantity or quality) of the food obtained over time, to compare the selected
alternative against the overall quality of the environment. This idea is
implemented in the now classical model by @ESYGCSLH#Charnov_1976, which proposes
that animals should decide whether to stay or leave a certain location based on
the mean value of its past choices. However, this model does not provide a  good
fit to behavioral data, showing a clear bias towards longer than predicted
staying times [@GC6MVWQU#Nonacs_2001; @9XVRLKC3#LeHeron_Etal_2020;
@RR87DVIX#Pyke_2010; @H9JQCFZA#Hayden_Pearson_Platt_2011].

For the second scenario, there are several options to describe uncertainty and
we will discuss two: By considering the spread (i.e. standard deviation) over
possible outcomes [@VACKG3ZK#Rothwell_Stock_1988] (i.e. a food source has food
consistently but the food obtained in quality/quantity vary over time) or by
considering  a change in the contingency between an action and its outcome (i.e.
a food source that had high quantity and quality food over time suddenly has no
food). When considering the spread as a measure of uncertainty, it is necessary
to calculate an average outcome from which the spread is observed. The anterior
cingulate cortex (ACC) is able to represent the magnitude of the spread over
possible outcomes in decision making tasks [@GLI8DY99#Christopoulos_Etal_2009]
with high precision, for every alternative, different cues and contexts
[@5ANLDC83#VanHolstein_Floresco_2020]. The second option, the change in the
outcome of an action, is tracked by increased  ACC activity
[@BHR2NAEI#Behrens_Etal_2007]. Thus, ACC activity can signal whether an outcome
is within the expected values or the value obtained in a particular occasion is
very different from expected. Being able to distinguish between these two cases
can increase food-seeking success. Being able to compute these uncertainty
features allows animals to stay in an area that provides food, despite
occasionally not finding food (change in action-outcome but obtained value is
within expected values based on tracked average), but leave this area if
consistently fails to find food (change in action-outcome and obtained value has
large variation relative to tracked average). The orbitofrontal cortex (OFC) has
a role in this regulation.  @X6XAHBZA#Stolyarova_Izquierdo_2017 showed that rats
could choose the option with largest mean value, that is, the option that
delivered sucrose pellets with the least amount of delay, despite high
variability in delay times. However, a lesion to the orbitofrontal cortex (OFC)
impaired this ability, making rats unable to change their option when the mean
value was decreased (increased delay time). Together, these data show that
different measures of uncertainty are tracked by brain structures, allowing one
to choose the best option while filtering out the variation around the expected
value.

The intuition that an animal should behave differently when the outcome is
within expected values or has changed drastically is formalized in the expected
and unexpected uncertainty model [@4BJ2B6KB#Yu_Dayan_2005]. This model describes
expected uncertainty as the uncertainty regarding outcomes when contingencies
remain stable, but are subject to some noise (variation around the expected
value). On the other hand, unexpected uncertainty represents a drastic change in
the contingencies, likely due to a structural change in the environment. Using
these concepts, the expected/unexpected uncertainty model proposes that if the
obtained rewards fluctuate near its expected value (i.e. a food source has food
consistently but the food obtained varies in quality/quantity over time) the
animal should not modify the learned actions that lead to rewards in this
environment (i.e. the animal should ignore cues that could point to new
potential food sources and continue to choose this food source), so top-down
control (where value representations are) should dominate over bottom-up input
(sensory information). On the other hand, if the variation of the obtained
rewards increases, the balance should switch to prioritize bottom-up input to
increase learning about new actions, that could lead to increase or maintain the
expected value of the rewards (i.e. the animal should pay attention and
follow-up on cues that indicate new food sources) [@4BJ2B6KB#Yu_Dayan_2005;
@P2FYNJKR#Soltani_Izquierdo_2019].

As discussed, animals can determine whether changes in the outcome are expected
or unexpected. If the action-outcome contingencies never changes, the
environment is described as stationary, whereas if contingencies change or the
mean value goes up or down over time, then the environment is defined as
non-stationary [@VPX6THEN#Raj_Kalyani_2017]. Animals tend to behave as if the
environment is non-stationary [@UJSWSGH3#Wu_Iyer_Wang_2018], increasing
exploratory behavior [@77AMCAE4#Ryali_Reddy_Yu_2016], as predicted by the
expected/unexpected model [@4BJ2B6KB#Yu_Dayan_2005;
@T3QJH2AJ#Cohen_Mcclure_Yu_2007].  While the functional reasons behind this
behavior are not clear, assuming a non-stationary environment does not decrease
performance in stationary environments significantly
[@77AMCAE4#Ryali_Reddy_Yu_2016], and can provide near optimal performance in
natural environments [@ERS4UNTK#Reverdy_Srivastava_Leonard_2014].

However, excessive exploration can be detrimental to obtaining food, so
exploiting current knowledge about food location is also necessary. This leads
to the exploration-exploitation dilemma [@2BEHEM7X#Sutton_Barto_2018].
Exploiting means that behavior should be consistent with previously learned
reward contingencies, choosing the option with the highest expected value. On
the other hand, exploration implies re-sampling the environment to improve or
re-learn contingencies. Uncertainty is a key variable to the resolution of this
dilemma.  Unexpected uncertainty increases the exploratory behavior, boosting
learning of new contingencies, whereas expected uncertainty bias behavior
towards exploitation [@T3QJH2AJ#Cohen_Mcclure_Yu_2007;
@S6TNU7XM#Harris_Wimmer_AstonJones_2005]. This idea implies that animals should
stay in areas where foraging is successful, without paying much attention to
small fluctuations in the results. However, if obtaining food suddenly becomes
more uncertain, the animal should start exploring for other options, because the
expected value of that location might have changed, and other locations might
now be better.

A key assumption behind the usefulness of uncertainty is that animal perceptual
abilities are limited. We argue against the idea of perceptual abilities being
dominant over the search strategies already discussed
[@92KDU3TH#LascalaGruenewald_Etal_2019], because sensory perception is always
limited in some aspect, introducing uncertainty of what lies beyond its limits
[@9XCDNBAM#Bartumeus_Etal_2016]. All sensory organs have a receptive field,
which defines the range where information can be sensed and thus used to orient
food-seeking behavior [@C377F7EP#Fletcher_Etal_2013]. If an animal must know
what is beyond such range, the animal must move to a new area and explore it.
However, the decision of where, when and how to move requires input from memory,
integrating perceptual information or other cognitive processes
[@NF2J3H5H#Ranc_Etal_2021], because by definition the animal has no sensory
information about the new area, and somehow must determine if moving to the next
area is good or bad. However, what is remembered about a certain location loses
validity over time due to the environment being in constant change. Thus, the
animal must integrate information about how food availability changes over
time, if the food source is always present then there's certatinty of its
availability, on the other hand, if the food source comes and goes then there's
high uncertainty over its availability [@LDCMV4VS#Fagan_Etal_2017].

Integrating information of location and availability over time can inform
food-seeking behavior. However, obtaining good quality information requires the
animal to explore its environment. Exploring requires a balance between how fast
it should be done and how exhaustive the animal should be, this balance is
represented by the speed-perception tradeoff, which determines that perceptual
abilities are degraded as speed is increased
[@KU6TMHRT#Campos_Bartumeus_Méndez_2013]. For example, fast speeds are required
to capture a moving prey, as the prey can move or be consumed by another animal,
rendering the information useless. However, moving fast prevents animals from
making an exhaustive exploration of its environment, as detection accuracy drops
by moving faster [@LDCMV4VS#Fagan_Etal_2017]. A second problem is the
intensive-extensive tradeoff, which points out how finding food-resources nearby
impairs finding resources far-away. If the animal performs an exhaustive search
in its nearby areas, it must be done slowly to be accurate. However, being slow
means that far away areas are left unattended longer, increasing uncertainty
about their food resources [@VYE5NZFU#Raposo_Etal_2011;
@9XCDNBAM#Bartumeus_Etal_2016]. Both tradeoffs imply that obtaining knowledge
about food resources leads to an inevitable perceptual uncertainty; moving fast
makes information about food location harder to obtain, but at the same time
moving fast is necessary to actually obtain food. Additionally, appropriately
exploring the environment forces the animal to focus on one area and to grow
increasingly uncertain of other areas’ food resources. Together, these tradeoffs
illustrate how, even when perceptual abilities can inform food location, there is
an inescapable uncertainty that animals must deal with.

The limitation in perceptual abilities makes uncertainty inescapable. Even when
an experienced animal can remember optimal foraging paths, random searches with
distinct cycles of exploration/exploitation phases persists
[@GNGBMVLA#Kembro_Etal_2019].  Animals still explore, even when having knowledge
of food location, because introducing stochasticity in food-seeking behavior
improves success, by making strategies more resilient to cognitive errors
derived from perception [@KU6TMHRT#Campos_Bartumeus_Méndez_2013]. The
persistence of strategies that balance exploitation/exploration
[@KU6TMHRT#Campos_Bartumeus_Méndez_2013], even when they are not technically
needed [@77AMCAE4#Ryali_Reddy_Yu_2016] shows how relevant uncertainty is for
food-seeking behavior. 

In this section we discussed the relevance of uncertainty and the limitations of
sensory information for food-seeking behavior. In the next section, we will
examine models that consider the case of foraging in uncertain environments to
inform about the underlying processes in food-seeking behavior.

## Foraging models and underlying processes in food-seekings behavior

Having discussed the importance of uncertainty for food seeking, we now move to
provide a more formal framework to relate uncertainty with the
exploration/exploitation dilemma and perceptual limitations discussed in the
previous sections. A model that includes uncertainty into food-seeking behavior
should include the following considerations: first, the rules determining the
result of the interaction between animal and environment are assumed to be
unknown or only partially known due to the stochastic nature of the environment.
Secondly, the animal may take any action $a$ within a set of possible actions $a
\in A$ for a particular state of the environment $s$. Any action $a$ causes an
stochastic transition from a state $s$ to another state $s'$. As such, the
result of an interaction between animal and environment can be described by its
value $q$, which is a function of both action and current environment state
$q(s, a)$ (Fig. 3).

These considerations are included in a Markov decision process
[@2BEHEM7X#Sutton_Barto_2018], which captures the intuition of the decision
making process where the animal can take action in the environment, but the
action outcome is partly random, and dependent on the current state. In this
model, all environment dynamics are described by the probabilities $p(s', r | s,
a)$, where $r$ is the obtained reward (interaction outcome), and such
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
stated rules (Fig. 4). Then, for each posterior, a single reward estimate
$\hat{r}$ is sampled, resulting in an estimated value for each action. The
action selected greedily, so $a = argmax_{a \in A} \hat{r}(a)$ where $A$ is the
set of possible actions within an environment [@WFYYPZ3N#Wang_Zhou_2020]. With
this simple algorithm for action selection, the exploration and exploitation of
different actions is balanced, actions with high associated value and certainty
will likely draw high values in the sampling procedure, actions with low
expected value and high certainty will draw low values, and actions with high
uncertainty can draw lower or higher values. Because the process must be
performed for every state, tractability is limited by the number of states. To
avoid the problem with tractability, rewards can be summarised as a weighted
average of past rewards, with a step-size parameter $((0,1])$. The lower the
value of this parameter the more weight is given to recent rewards, on the other
hand, if it's closer to 1, then all the reward history is equally considered.
More complex alternatives to this problem include modeling non-stationarity as
Poisson arrival process that modifies the means rewards [@2S4JPDRG#Ghatak_2020],
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

In the previous section we presented HMM to represent  what is the belief of the
current state of the environment using only partial information.  On the other
hand, Thompson sampling allowed us to model the uncertainty over $q$, that is,
the uncertainty over the value of an action in a given state. In this section we
will discuss how uncertainty can be computed in the animal brain, and how it
modifies parameters presented in previously discussed foraging models.

Uncertainty arises from having more than one option, but also when more than one
option is attractive. If the probability of choosing any given option has a
uniform distribution, then uncertainty increases proportionally with the number
of options. Shannon entropy [@LUFF6VTC#Shannon_1948] formalizes this intuition
as follows

$$H = - \sum_{i = 1}^{n} p_{i} log_{2} p_{i}$$ 

This formula expresses uncertainty in bits. So, maximum entropy (one bit) is
achieved when all the alternatives have the same probability, such as a coin
flip. However, if the coin happens to have two heads, then Shannon entropy is 0
bits. If we apply the Shannon entropy to estimate uncertainty in food seeking,
we can start by considering an animal in simple environment with only one
environmental state s and one action a which initiates a food-seeking bout. If
there are only two possible outcomes: food is found ($p$) or not found ($q = 1 -
p$), then $H = -(p log_{2} p + q log{2} q)$.  If an animal performs multiple
food-seeking bouts and all of them have the same result (either successful or
unsuccessful), then there is no uncertainty $H = 0$. However, if the probability
of a successful food-seeking bout is 0.5, then entropy is maximized $H = 1$.

The computation of entropy has a neural basis. Uncertainty can be determined in
decision making tasks, by observing the probability of choosing between two
alternatives. The highest uncertainty is achieved when the probability of
choosing any given alternative is 1 divided by the number of possible
alternatives. @55XGJCH7#Goñi_Etal_2011 showed that when choosing between two
stimuli with different rewards, the choosing uncertainty for any given pair of
alternatives was encoded in the middle cingulate cortex (MCC).
@DRJBKPPI#Gloy_Herrmann_Fehr_20200 explored a similar setting by asking
participants whether they should bring and umbrella to a forest barbeque by
giving them two sources of information (1) whether forecasts and (2) images of
the sky, for every tested combination of these sources of informations,
decisions were classified as either certain (consistently choosing to bring or
not an umbrella) or inconsistent decisions (combination with high decision
uncertainty), results showed that higher uncertainty increased activity in MCC,
whereas certain decision were encoded within the left supramarginal gyrus.
Theses data suggests that uncertainty is encoded as entropy within the MCC, and
this process seems to be important when trying to determine the true state of
the environment (whether is going to rain or not). Thus, the neural basis of
entropy computation seems to dependent on the estimation of the true environment
state.

Entropy is not directly available as sensory input, and must be derived from
actions and outcomes, which are dependent on the state of the environment.
Previously, we discussed how Thompson sampling can encode the variance of an
outcome in a posterior distribution and this can be used to model the
transitions in a HMM.  In Thompson sampling the variance of the posteriors is
related to entropy, the more variance the more entropy, as the probability of
each possible value is more similar. Nevertheless, a more direct way to compute
entropy is through the prediction error. The classical model of Rescorla-Wagner
[@LFYTIBBR#Rescorla_Etal_1972] models how animals could predict the reinforcing
value of a given stimuli $$ y_{t} = y_{t-1} + \alpha \delta_{n} $$ where the
value representation of the stimuli $y$ is obtained by considering the
previously estimated value $y_{t-1} weighted by a learning rate $\alpha$, and a
prediction error $\delta$. $delta$ is the simple difference between the expected
reward and the actual reward $$\delta_{n} = r_{t}
- y_{t}$$ where $r_{t}$ is the obtained reward. An extension to this model
  [@2BEHEM7X#Sutton_Barto_2018] modifies the prediction error by giving more
  weight to current rewards compared to past rewards $$ \delta_{n} = R{t} +
  \gamma \hat{V_{n+1}}
- \hat{V_{n}} $$ where $\gamma$ is a discount factor $0 <= \gamma < 1$ for all
  the history of rewards, and $\hat{V}$ is an estimate for the true value of the
  reward. Finally, $\alpha : [0, 1]$ is the learning rate which effectively
  weights the reward prediction error $\delta$ so to make small updates $\alpha
  \approx 0$ or rather large ones $\alpha \approx 1$ to the reward estimation.

The Rescorla-Wagner model allows deriving a prediction error based on
experience, where the learning rate can be set lower to simulate unexpected
uncertainty or higher to simulate expected uncertainty. However, $\alpha$ in
such a model is a hyperparameter, thus is not derived from experience.
@NZFTTQJZ#Pearce_Hall_1980 model proposes that $\alpha$ can be controlled by the
prediction error magnitude $|\delta|$ so $$\alpha = \gamma|\delta_{n-q}| + (1 -
\gamma) \alpha_{n-1}$$ Higher entropy on reward outcomes increases the
probability of error [@7JBVDKC8#Feder_Merhav_1994], thus increasing $|\delta|$
and, consequently, $\alpha$. The behavioral intuition captured in the Pearce
Hall model is that the animals should increase its behavioral vigor and
attention towards options with the uncertain outcomes
[@BVC98GTV#Diederen_Fletcher_2021].

In this section, we presented simple models showing how uncertainty can be
computed using the reward prediction error without any meaningful computational
complexity. In the following section, we will brain structures supporting the
computation of the reward prediction error and uncertainty.

# Neuronal representation of uncertainty

A good candidate neurotransmitter for representing uncertainty is dopamine (DA).
The firing rate of DA VTA neurons has been proposed to encode the prediction
error [@8C97FJFI#Nasser_Etal_2017; @AR2TQB84#Fiorillo_2003;
@5BR3FL7N#Fiorillo_2011; @IV9MZSXR#Lak_Stauffer_Schultz_2014;
@HLCSQTJB#Glimcher_2011; @4YU7F96V#Khaw_Glimcher_Louie_2017;
@FAIJ66PZ#Gershman_2019]. DA neurons firing rate increases when the number of
rewards increases suddenly over the base rate, and decreases its firing rate in
response to an omission in reward [@698KWSAL#Takahashi_Etal_2017]. Moreover, DA
neurons sustained firing has been show to encode reward probability analogously
to entropy, that is, displaying a peak of activity when the reward is obtained
with a probability of 0.5, and lower levels of sustained activity when the
reward probability is either high or low (low entropy)
[@AR2TQB84#Fiorillo_2003]. @5BR3FL7N#Fiorillo_2011 showed how rhesus macaques DA
neurons firing rates were higher for uncertain stimuli compared to certain
stimuli, while controlling for the expected value by pairing the ceratint
stimulus with a fixed amount of reward delivery, and the uncertain stimulus with
either no reward or double the reward of the certain stimulus, so the expected
values were the same.

Encoding of uncertainty seems to be fairly distributed within brain areas.
Hippocampal acitivity has been shown to encode stimulus entropy
[@7PXFUSRW#Schiffer_Etal_2012]; substantia nigra encodes unexpected gains and
losses within a financial context [@6IGYU34R#Zaghloul_Etal_2009]; VTA DA neurons
activity has been proposed to be modulated by ACh uncertainty signal
[@ERS4UNTK#Reverdy_Srivastava_Leonard_2014], changing the balance between
exploration and exploitation [@6RPWIYR3#Cinotti_Etal_2019]. VTA DA neurons seems
to respond accordingly to the @NZFTTQJZ#Pearce_Hall_1980 model presented
previously, as optogenetic activation of VTA DA neurons during reward prediction
errors increased cue-reward learning [@LSWYXCBD#Steinberg_Etal_2013], and L-DOPA
has shown to increase learning for new associations
[@8FIHXB6G#Chakroun_Etal_2020]. Thus, general DA activity is sensitive to
uncertainty signals carried by reward prediction, showing
@NZFTTQJZ#Pearce_Hall_1980 model prediction regarding increasing learning rate,
and showing connectivity to uncertainty encoding areas. Moreover,
hyperdopaminergic mice show a bias towards exploration even when this implies
greater costs, which according to reinforcement learning modeling point could be
due to a decoupling between actions and reward history
[@TN6NBEH8#Beeler_Etal_2010].  Within the reinforcement learning framework this
means that mice give less weight to the expected value of their options during
choice, thus increasing action randomness.

The VTA DA neurons computes the reward prediction error
[@NLDHLRVN#WatabeUchida_Eshel_Uchida_2017], by weighing inputs from multiple
brain areas, including the lateral hypothalamus, dorsal and ventral striatum,
ventral pallidum, and subthalamic nucleus [@SFZIJKFP#Tian_Etal_2016]. The main
intuition here is that VTA DA neurons generate a reward prediction signal using
multiple redundant inputs, that compute slightly different reward features. For
example, the lateral hypothalamus has been shown to encode reward properties
modulated by internal states [@8ZNMHI24#Nakamura_Ono_1986,
@KPIHYUYF#Yamanaka_Etal_2003] and this subjective valuation of reward is passed
onto VTA DA neurons [@NLDHLRVN#WatabeUchida_Eshel_Uchida_2017].

Acetylcholine (ACh) and norepinephrine (NA) activity has been proposed to signal
expected and unexpected uncertainty, respectively [@4BJ2B6KB#Yu_Dayan_2005].
Both neurotransmitters are mainly produced in the basal forebrain
[@D8EGNYCV#Sturgill_Etal_2020] and locus coeruleus (LC), showing an important
role in the modulation of the reward prediction error signal
[@TA5KB3TF#Sales_Etal_2019; @9MIJEAWP#AstonJones_Etal_2010]. ACh antagonists
increase sensitivity to random fluctuation in rewards
[@9X7Z6PMX#Marshall_Etal_2016], so that they are no longer perceived as
expected. On the other hand, normal ACh concentration levels activity signals
that random fluctuations are to be expected, and no meaningful changes are
present in rewards [@4BJ2B6KB#Yu_Dayan_2005]. The opposite role is attributed to
LC tonic activity signaling unexpected uncertainty, which promotes the learning
of new contingencies, increasing exploratory behavior via DA sensitization to
reward fluctuations [@9Z525EYW#PayzanLenestour_Etal_2013;
@LEWESIS6#AstonJones_Cohen_2005].

In this section, we presented how the reward prediction error which allows the
computation of uncertainty is supported by DA activity within the VTA modulated
by ACh and NA signals of expected or unexpected uncertainty. In the following
two sections, we will show empirical evidence on how food-access uncertainty
increases food-seeking behavior, and increases the risk of overweight in modern
times. Finally, we will propose the orexin neuropeptide as a potential mediator
of the uncertainty-driven increase in food-seeking behavior.

## An adaptive strategy in modern times

In modern urban environments, high-fat food is of easy access; this, coupled
with a food-seeking behavior which seeks to maximize energetic gain when food
shortage is predicted due to food-access uncertainty, can lead to overweight,
because the mechanism is adapted to low resource environments and not
calorically dense one. Thus, in developed countries, where caloric density is
extremely high [@YZNPFBM3#Drewnowski_Darmon_2005], increasing food-seeking
behavior is likely to result in excessive caloric intake. Here we will present
evidence on how food access uncertainty increases food-seeking behavior, and how
this can result in a increase risk of obesity.

When food is limited, animals approach cues with the highest associative
strength to actual food [@B8QZIGEN#Montague_Dayan_Sejnowski_1996].
@8Q6QHXGB#Kacelnik_Bateson_1996 in fact proposed that approaching behavior
should be reduced if the cues become unreliable, for example, by delivering
rewards only 50% of the time. However, introducing uncertainty in food access
reduces the time latency of lever approach and increases lever pressing rate
[@S8CHV5KG#Anselme_Robinson_Berridge_2013]. Showing increased food-seeking
behavior due to uncertainty in food-access.

Intermittent access protocols allow us to study the effects of introducing
uncertainty in food-access. These protocols basically consists either giving a
brief access to a palatable or non-palatable food option, randomly or every
other day throughout the week. Intermittent access to high-fat diets generates
binge-eating behavior, which corresponds to a drastic increase in food intake
over a short period of time [@QN55S25U#Hess_Etal_2019; @CTAFJAZ3#King_Etal_2016;
@MBZJPLN3#Lardeux_Kim_Nicola_2013]. Moreover, intermittent access for vegetable
shortening in rats increases lever pressing for food upon withdrawal
[@BDVQLHQZ#Mcgee_Etal_2010] and without withdrawal
[@8KGR8TT6#Wojnicki_Babbs_Corwin_2013; @DQHTA2QH#Wojnicki_Stine_Corwin_2007;
@WPLVSADN#Wojnicki_Etal_2015]. The increase of food-seeking behavior due to
intermittent access to food increases general psychomotor behavior, and
attenuates the effects of food devaluation [@GIDJCJMP#Hardaway_Etal_2016].
Furthermore, intermittent access is correlated with an increase DA concentration
within the accumbens shell, and increased motativation to obtain food
[@23K7IPBA#Rada_Avena_Hoebel_2005]. Is important to note that intermittent
access is typically delivered at regular hours, and this allow animals to
predict food arrival [@KUXWM8W5#Luby_Etal_2012]. However, the behavioral
effects, except anticipatory behavior, are common disregarding if intermittent
access is provided at completely random time or given at fixed times of the day
[@VY8ZEZB6#MuñozEscobar_GuerreroVargas_Escobar_2019]. Taken together, this data
suggests that introducing uncertainty in food-access robustly increases
food-seeking behavior and food intake, while reducing devaluation effects on
intake.

Food-seeking behavior is increased to avoid starvation when a food shortage is
predicted (by increased uncertainty), and as previously noted, this derives in
increased exploration, number foraging bouts, and time expended in foraging
[@G83L8BXA#Harris_Chapman_Monfort_2010]. In humans, food-access uncertainty is
analogous with food insecurity, which is defined as the perception of how secure
or certain food access is going to be in the future [@WZS8BTVL#Dhurandhar_2016].
Higher levels of food-insecurity correlate with increased food intake
[@WZS8BTVL#Dhurandhar_2016] and preference for high-fat alternatives
[@EER2TNCJ#Nettle_Andrews_Bateson_2017], which is in line with an adaptive
behavior to prevent starvation in food-limited environments
[@VTI2FVJG#Brunstrom_Cheon_2018]. However, this adaptive strategy turns
problematic as calorically dense are of easy access and the cost to obtain
calorically dense food has dropped in modern countries
[@YZNPFBM3#Drewnowski_Darmon_2005], were the effect of food-insecurity on
food-intake is more pronounced [@4LJKTR3N#Moradi_Etal_2019;
@2N6SBNMK#Dinour_Bergen_Yeh_2007; @VDHUFYYV#Nettle_Bateson_2019]. Increased food
intake due to food-insecurity increases the risk of obesity and overweight,
probably due to overeating fats and carbohydrates (which correspond to
easy-access food previously mentioned) in periods of high food availability
[@2ZRH7IWR#Stinson_Etal_2018]. 

In this section we showed evidence connecting food-access uncertainty and the
risk of overweight and obesity in modern environments, where calorically dense
foods are of easy access, and the uncertainty-driven increase on food-seeking
behavior results maladaptive. In the following section, we present orexin as a
potential mediator of uncertainty-driven foraging because of its pivotal role in
both reactive and predictive homeostatic control [@52DV95LU#Burdakov_2020], and
motivated behavior [@2X7SNKS3#Tyree_Borniger_DeLecea_2018].

## Orexin as a potential mediator of uncertainty-drive foraging

The hypothalamus is a relevant structure in the homeostatic process, being
capable of controlling arousal levels
[@3ZQDGXXZ#Adamantidis_Carter_DeLecea_2010; @HQFDMJJ8#Kosse_Burdakov_2014],
motivation for food intake [@6FUPLHIJ#Castro_Berridge_2017], receiving internal
status information of fat deposits via leptin signaling
[@RWABER6F#Pandit_Beerens_Adan_2017; @DHNLNHHI#Meister_2000], and
gastrointestinal status via ghrelin signaling [@NRWCYJCX#Müller_Etal_2015;
@W3IUQNUY#Toshinai_Etal_2003]. Hypothalamus capability of sensing internal
status and controlling motivation could allow it to be an important contributor
to uncertainty-driven foraging, specifically its orexin neurons, as they show
important contributions to foraging related adaptations [@LBGV5NJ5#Barson_2020].

Orexin or hypocretin is a neuropeptide with few neurons producing it, most of
them located within the lateral hypothalamus and perifornical area, but with
large projections throughout the brain [@84IMKHCU#Peyron_Etal_1998
;@EFWJQ65B#Chowdhury_Etal_2019]. Orexin-A and orexin-B are the two types of
orexin coming from the same precursor peptide prepo-orexin
[@A93676U3#Sakurai_Etal_2005], they bind to closely related receptors $OX_1$ and
$OX_2$, the first being selective to orexin-A, while the latter being
non-selective for orexin-A and orexin-B [@KPIHYUYF#Yamanaka_Etal_2003]. Orexins
A and B are co-located [@Q9JU4KC8#Chou_Etal_2001] and co-released
[@67V7P3AC#Li_Marchant_Shaham_2014] with dynorphin. Its functions range from
regulating sleep/wakefulness states [@AR3R5QLP#Chemelli_Etal_1999] to energetic
balance [@KPIHYUYF#Yamanaka_Etal_2003]. Different lines of evidence suggest that
orexin neurons can control foraging-related behaviors. Orexin activity promotes
locomotor activity but is rapidly inhibited upon contact with food
[@7GXEINLY#González_Etal_2016], orexin neuronal activity increases upon sucrose
predictive cues [@PIJIVQER#Hassani_Etal_2016], and the increased spontaneous
physical activity is directed towards food sources [@Y4UZKQ5V#Zink_Etal_2018].
This makes sense as orexin neuronal activity increases during fasting
[@EC67BDWX#Futatsuki_Etal_2018; @5HP9Q6Q6#Almeneessier_Etal_2018;
@4K59WANU#Diano_Etal_2003] and is inhibited by glucose and leptin
[@KPIHYUYF#Yamanaka_Etal_2003]. Thus, orexin-related activity can be interpreted
as a food procuring signal. Further support for this interpretation comes from
orexin increasing olfactory activity [@X9STRHXX#PrudHomme_Etal_2009], enhancing
visual attention [@7ZXMSXYC#Zajo_Fadel_Burk_2016], the impairment of spatial
working memory in orexin knockout mice [@Z2G6BP2E#Dang_Etal_2018], among other
foraging-related behaviors [@LBGV5NJ5#Barson_2020].

Orexin might support foraging-related behaviors including uncertainty-driven
food-seeking behavior. Orexin connectivity with VTA, LC and basal forebrain
[@PQWIJHAP#Siegel_2004], might modulate DA, ACh and NE activity, respectively.
Such connectivity hints at a possible role of orexin in promoting food-seeking
behavior via prediction-error derived expected and unexpected uncertainty.
Orexin antagonist decreases dopamine activity and behavioral motivation to
obtain rewards, and direct infusion of orexin into VTA increases dopamine
activity and motivation to self-administer drugs [@7TJ6MVI5#España_Etal_2011;
@KN9TLADJ#Richardson_AstonJones_2012] and cue-induced reinstatement
[@N2GZKN6Q#Mahler_Smith_AstonJones_2013]. VTA DA firing activity is modulated by
orexin and dynorphin, orexin-A increases VTA increases exctibability of VTA DA
neurons, while dynorophin inhibits its activity [@59TEBA3J#Muschamp_Etal_2014].
Moreover, this modulations seems to be dependents on VTA DA neurons projections
in the case of orexin but not for dynorphin; orexin increased nucleus accumbens
lateral and medial projecting neurons activity, but not basolateral amygdala
projecting ones, whereas dynorphin showed an inhibitory effect regardless of
projections [@XIJMRM6S#Baimel_Etal_2017]. Thus hypothalamic peptides can
modulate the reward signal via modulation of VTA-DA activity.

Indirect modulation of VTA activity comes from a positive feedback loop between
VTA and the lateral hypothalamus. Nucleus accumbens shell exerts inhibitory
activity witin the lateral hypothalamus through medium spiny neurons
[@IUF535G9#Qi_Etal_2016; @M2RERH96#PerezLeighton_Etal_2017], which permits rapid
inhibition of food intake [@TIF7X9CT#O’Connor_Etal_2015]. In turn, inhibition of
nucleus accumbens shell results in a intense feeding response
[@VD2436JM#Stratford_Kelley_1999]. VTA projections to nucleus accumbens shell
are mainly inhibitors of medium spiny neurons activity, thus modulating overall
nucleus accumbens shell output [@TECSZSXX#Yu_Etal_2019]. This loop could allow
VTA to increase hypothalamic activity through by releasing nucleus accumbens
shell inhibhition on the lateral hypothalamus. Additionally, DA activity, in
response to environmental uncertainty, could increase lateral hypothalamus
activity via dopaminergic inputs to the supramammillary nucleus, whose activity
is correlated, and shows reciprocal inputs with the lateral hypothalamus
[@4SMCFQII#Plaisier_Hume_Menzies_2020]. This could result in a net increase of
food-seeking behavior via uncertainty-driven activity in the VTA.

In addition to directly regulating VTA DA neurons, orexin also has inputs to the
LC, another brain region relevant for computing uncertainty through NE and Ach
signaling. Orexin signal depolarizes the LC [@A5ZYWRZW#Hagan_Etal_1999],
modulates LC response to emotionally salient information
[@BCNSK25R#Soya_Etal_2017] and central administration of orexin increases LC
activity [@U7KSJFYR#SoaresNaufel_MartinTruzzi_SantosCoelho_2020]. LC activity
promotes task disengagement [@KA4Y29AG#Kane_Etal_2017], altered network
representation of tasks [@GFA24ABK#Grella_Etal_2019], and updating world models
containing action-outcome pairings [@TA5KB3TF#Sales_Etal_2019], likely via
promotion of exploratory behavior related to LC tonic firing
[@LEWESIS6#AstonJones_Cohen_2005]. Then, orexin could potentially increase LC
activity, which in turn can accelerate the learning of action-outcome
contingencies [@2L794LMR#Glennon_Etal_2019] triggered by unexpected uncertainty
[@TA5KB3TF#Sales_Etal_2019]. Orexin can include internal and external
information to motivate food-seeking behavior [@C6NVHYKV#Mahler_Etal_2014] and
its LC connectivity can allow optimal search behavior, by first including a
measure of uncertainty via prediction error signal in VTA, which in turn can
inform to increase exploration when unexpected uncertainty arises.

The orexin neurons could also promotes uncertainty-driven food-seeking behavior
through cholinergic modulation of DA neurons in the VTA. ACh activity provides a
valence-free prediction error signal which correlates with DA prediction error
signal [@D8EGNYCV#Sturgill_Etal_2020]. This correlated activity can be due to a
modulatory role of ACh in DA neurons through the nicotinic ACh receptors
(nAChRs). nAChRs modulate DA neurons tonic and phasic activity, tonic firing
mode signals overall uncertainty within a task [@AR2TQB84#Fiorillo_2003,
@5BR3FL7N#Fiorillo_2011], whereas phasic bursting signals uncertainty-seeking
behavior [@IQSQBR9B#Naudé_Etal_2018, @5I6AFP54#Naudé_Etal_2016]. Thus, nAChRs
modulation increases exploratory behavior when the environment is uncertain,
similar to the proposed orexin role. The basal forebrain, which is one of the
brain areas containing most of cholinergic neurons
[@UJBTXZNA#Ballinger_Etal_2016], receives important orexigenic inputs
[@A93676U3#Sakurai_Etal_2005], and these inputs are known to be excitatory
promoting ACh release [@USHNF8KL#Arrigoni_Mochizuki_Scammell_2010]. Orexin
modulation of ACh concentrations is present during exploratory behavior
[@7ZXMSXYC#Zajo_Fadel_Burk_2016, @INCRN3KS#Fadel_Burk_2010], and in response to
salient stimuli [@E9TYYBTR#Villano_Etal_2017]. Thus, increasing exploration in
response to uncertainty.

In this section, we provided a plausible circuit where orexin activity acts as a
hub integrating prediction error with unexpected uncertainty and expected
uncertainty. This puts orexin as a candidate neuropeptide for modulating
uncertainty-driven food-seeking behavior, as it can integrate environmental and
internal status information to promote food-seeking behavior when necessary,
while considering environmental stochasticity. We derived this plausible orexin
function taking theoretical and empirical findings from foraging theory,
computational models of reinforcement learning and literature on homeostatic
control of food intake, allowing us to propose a functional role for orexin
situated in the proper evolutionary and environmental context.

\pagebreak

# Objectives

## General objective

Determine how uncertainty in food-access increases food-seeking behavior, and
how orexin mediates uncertainty-driven increased food-seeking behavior.

## Specific objectives

1. Determine whether uncertainty in food access required for substance increases
   motivation for palatable foods, and if this correlates with orexin gene
   expression.

2. Determine whether uncertainty in obesogenic environments increases
   food-seeking behavior and assess if increased food-seeking behavior
   correlates with orexin gene expression.

3. Determine if orexin/dynorphin neurons projecting to the VTA are active during
   sucrose intake.

4. Determine whether orexin in VTA elicits increased food-seeking behavior
   towards uncertain options, and orexin agonists inhibits food-seeking behavior
   towards uncertain options.

# Hypothesis

## General hypothesis

Food-access uncertainty increases food-seeking behavior, and this increase is
modulated by orexin-neurons activity.

## Specific hypothesis

1. Food-access uncertainty, in substainance food supply and in obesogenic
   environments, increases food-seeking behavior.

2. Prolonged exposure to food-access uncertainty environments increases
   prepro-orexin and orexin receptor expression in the hypothalamus.

3. Orexins and dynorphin neurons projecting to the VTA are active during sucrose
   intake

4. Orexin injection in VTA increases the choice of uncertain options, while
   orexin antagonists reduce the choice of uncertain options.

# Methods

## Specific hypothesis 1, Experiment 1

### Animals

16 normal C57/BL6 mice  will be used in this experiment. Sample size was
selected by estimating the effect of uncertain access to food in operant
behavior reported in [@BWVUS5B9#Parkes_Etal_2017], with a statistical power of
80% and α=0.05. The sample size per group is estimated at n = 4. For
differential gene expression sample size was selected according to literature
reporting sample sizes of 4-6 for orexin expression
[@37QP9J8W#Pankevich_Etal_2010; @GAZJE6IJ#AlcarazIborra_Etal_2014]

### Experimental design

Mice (n = 16) will be housed individually with a 12/12 hr (light/dark) schedule
with an automatic feeding device delivering nutritionally complete food-pellets.
Animals will acclimate for a week to the feeding device. Next, mice will be
split in two groups (n = 8), balanced for total food intake. The control group
will maintain the same conditions as the acclimation phase, receiving pellets
with a delay of 15 seconds, whereas the treatment group delay will be randomly
selected from either 15, 45 seconds or 2 minutes. After 6 weeks, 4 randomly
selected mice from each group will be euthanized and their brains extracted for
quantitative analysis of gene expression. Remaining animals (n = 4, per group)
will complete 10 sessions of a progressive ratio (PR) task for sucrose.

### Random delivery of food pellets

The feeding device delivers exactly one pellet with a delay of 15 seconds once a
pellet is removed from its cup. The random delay will be modeled as random
samples from a truncated normal distribution with 15 second as the mean and a
standard deviation of 1 minute. As such, once the food pellet is removed from
the cup, in the random delay condition, the next pellet will be delivered with a
mean of 15 seconds, but with a possible range from 0 to 1 minutes.

### Progressive ratio task (PR)

The PR task will be conducted in a cage with two spouts, one with water and the
other one with a sucrose solution, alternating positions between sessions. All
sessions will last 1 h. Mice will be trained in 5 sessions to receive either
water or sucrose after 5 licks (fixed-ratio 5, FR5) with a 20 second timeout
after each sucrose or water delivery. In the PR task, the required number of
licks to obtain sucrose will increase exponentially starting from 5 for the
first sucrose reward, while water will continue in a FR5.

### Quantitative analysis of gene expression

Mice will be euthanized with isoflurane. Brains will be removed, hypothalamus
dissected and stored at -20C in RNAlater. RNA will be isolated by using TRIzol
(Invitrogen) according to the manufacturer's instructions. Primers for
prepro-orexin, orexin 1 and orexin 2 receptors will be prepared for real-time
quantitative PCR according to [@L2MVQGK9#Lazzarino_Etal_2019].

### Materials and instruments

### Feeding experimentation device 2 (FED 2)

The FED2 an open-source automatic feeding device, and all its parts 3D printed
in polylactic acid (PLA). The device consists of two main parts: a reservoir
where food pellets are stored, and a cup where food-pellets are delivered. The
cup contains a photo-interrupter that detects if a pellet is within the cup,
each time a pellet is removed and after a determined delay another food-pellet
comes down from the reservoir. This device allows us to measure (1) the exact
number of food-pellets removed (Nguyen et al. 2017), (2) the time when each of
the pellets were removed, and (3) how many times the animal tried to reach for a
food-pellet.

### Lickometer

This device consists of a cage with two spouts through which a predetermined
amount of liquid solution can be delivered. Each spout detects contact with the
animal tongue, allowing us to measure the number of licks per spout, and when
they were performed. Additionally the liquid solution delivery is conditioned
upon a determined number of licks. This allows us to characterize the intake
behavior by considering (1) the time between successive licks, (2) the
distribution of the time between licks, and (3) differentiate the number of
licks and the number of rewards obtained. Our pilot studies showed that between
5 to 7 sessions are sufficient for animals to stabilize their behavior and learn
the operant task.

### Data analysis

We want to understand if food motivation changes due to prolonged exposure to
uncertainty in food-access. Food motivation will be measured as the breaking
point, that is, the total number of events performed in the PR task- an event is
when the animal performs the required number of licks when the spout is active.
Additionally, we will analyze lick microstructure to determine for other effects
related to food motivation.

### Data analysis pipeline

A negative binomial generalized mixed model will be used to estimate the
difference between control and treatment group in number of events. The negative
binomial distribution allows us to explicitly account for individual differences
in response to treatment while adjusting for variables such as weight and mean
food intake. Additionally, the negative binomial distribution is the appropriate
way to model count data (number of events).

Sucrose-seeking behavior will be characterized using lick microstructure
analysis [@ZVNAACB5#Johnson_Etal_2010]. Lick microstructure mainly accounts for
the pattern analysis of inter-lick intervals (ILI), which corresponds to the
time elapsed between a determined lick and the next one. Our main patterns of
interest are bursts, which correspond to rapid successive licks that are within
an ILI of 500 ms between each other. Bursts are described by number and burst
length, which correspond to the number of clusters under the burst definition,
and how many licks compose each of those clusters, respectively. This allows us
to differentiate between ‘motivation’ related behavior (burst number) and
‘liking’ response (burst size) [@ZVNAACB5#Johnson_Etal_2010;
@6D6GY5Q4#Johnson_2018]. The lick microstructure features will be used as
dependent variables in the negative binomial model to assess group differences
in food-seeking behavior. Additionally, we will compare the main and temporal
course effect of uncertainty in food-pellet intake within the home cage,
effectively estimating daily caloric intake.

Using qPCR we will obtain measures of transcriptional differences between groups
in prepro-orexin and orexin receptors. We aim to obtain an average relative
normalized expression per group, and to statistically determine differences, we
will perform a Student’s t-test between groups for previously mentioned genes of
interest. Statistical analysis will be performed using the bioconductor package
[@QJDJKYD4#Gentleman_Etal_2004] and the ddCt algorithm
[@3RSH6K5F#Livak_Schmittgen_2001].

## Specific hypothesis 2, Experiment 1

### Animals

8 normal C57/BL6 mice will be used in this experiment. Sample size was
calculated with the same criteria of experiment 1 for differential gene
expression. For behavioral effects of uncertainty, a pilot experiment determined
that a sample size of 8 (4 per group) is necessary to observe a statistically
significant effect.

### Experimental design

Mice (n = 8) will be housed individually with a 12/12 hr (light/dark) schedule,
with nutritionally complete food-pellets and water provided ad-lib. For two
weeks animals will be acclimated to the lickometer device delivering a sucrose
reward in both spouts. At the end of the acclimation phase animals will be
splitted into two groups (n = 4) balancing on the total number of events. The
control will continue with the same setup as the acclimation phase, whereas the
treatment group will have one spout delivering the sucrose reward randomly 50%
of the times upon 5 licks, and the other spout delivering the same sucrose
reward 100% of the time for 60 minutes, alternating positions between sessions.
This phase will last for 2 weeks, at the end of which animals will be euthanized
with isoflurane, its brain extracted, and samples from the hypothalamus taken
and prepared for RT qPCR following the protocols of the previous experiment.

Materials and instruments consist of the same lickometer described in experiment
1, variables of interest are also the same as experiment 1.

### Data analysis

Our main interest is to measure how the food-seeking behavior of animals is
affected by introducing uncertainty, while retaining a certain alternative. This
will allow us to model an obesogenic environment where uncertainty is present.
Main analyses are similar to experiment 2, but a reinforcement model is included
as part of the analysis pipeline in order (1) determine the inclusion of
uncertainty modifies decision processes within food-seeking behavior, and (2)
compare actual food-seeking behavior to optimal models of food acquisition to
determine if exploration of uncertain options is rewarding for the animal.

### Data analysis pipeline

As we are expecting a general trend towards reduction of both events and licks
due to sucrose devaluation from previous pilot studies, we will fit the same
model as experiment 1, but including the interaction between treatment, session
number and group, while adjusting for baseline number of events and licks. To
model food-seeking behavior we will consider each lick as a choice for one of
the two spouts.

We will use two reinforcement learning algorithms to model uncertainty effects
in food-seeking behavior during the task. Epsilon-greedy choice rule will be
used to model the intuition that if uncertainty does not affect reward value
(i.e. the modeled estimation of the reinforcing properties of the reward),
then choice should be mostly directed towards the spout with reward probability
of 1, but with some stochastic deviation from this, for example, due to spout
position preference. To model an effect of uncertainty in reward value we will
use the Thompson sampling model, allowing us to test if uncertainty increases
the reward value. Model parameters will be determined using maximum likelihood
estimation; parameter recoverability and model validation will be performed
according to standard statistical techniques [@VRHNLHDG#Wilson_Etal_2014]. Model
comparison will be performed using bayesian information criterion to determine
the best fit to animal choice data, between epsilon-greedy and Thompson sampling
models. Gene expression fold change will follow the same procedure as the
previous experiment, effectively allowing us to observe if there are differences
when uncertainty is introduced in an obesogenic environment.

## Specific hypothesis 3, Experiment 1

### Animals

18 normal C57/BL6 mice will be used in this experiment. Preliminary results from
our laboratory indicate that 4 mice per group are necessary to observe Fos
differences due to food intake (Coehn’s d = 0.25, p < 0.05) with
immunofluorescence techniques (Carolina Sandoval, unpublished data). Assuming an
effect size of 80% of preliminary studies for positive control, resulting in 6
required animals ( = 0.05 y  = 0.8). Assuming a 80’% success rate in the
bilateral tracer injection, this results in 9 required animals per experimental
group, 18 in total.

### Experimental design

18 mice will be injected in the VTA with a retrograde fluorescent tracer using
stereotaxic surgery. Animals will be maintained with food and water ad-lib and
in a 12/12 (light/dark) schedule, without any kind of intervention until they
are fully recovered from surgery. Using the previously described lickometer,
animals will be exposed to 30 minutes sessions with two alternating spouts
delivering water and a sucrose solution upon 5 licks for treatment group (n =
9), and the two spouts delivering water for control group (n = 9). After 6
sessions, animals will be euthanized 90 minutes after the beginning of the
session by isoflurane. Brain will be extracted under standard techniques for
immunofluorescence to evaluate orexin neurons present in both the retrograde
tracer mark and Fos neuronal activity marker.

### Data analysis

This experiment will test the hypothesis that there exists the necessary
functional connectivity between orexin neurons and reward processing brain
structures in hedonic intake of sucrose.

### Data analysis pipeline

The percent of orexin and co-released dynorphin neurons expressing Foss that are
labeled with retrograde tracers will be analyzed with a two-way ANOVA, with the
experimental group as a dependent variable. This will allow us to determine if
this functional connectivity is present exclusively in hedonic intake compared
to only water intake.

## Specific hypothesis 4, Experiment 1

### Animals

8 normal C57/BL6 mice will be used in this experiment. The number of animals was
determined by previous pilot experiment, showing that sample size of 8 is
necessary to observe the behavioral effects.

### Experimental design

Mice (n = 8) will be housed individually with a 12/12 hr (light/dark) schedule,
nutritionally complete food-pellets and water will be provided ad-lib. Cannulas
will be implanted unilaterally aiming at the VTA, and will be left to recover
without any intervention for one week. Next, for two weeks animals will be
acclimated to the lickometer device, with the same setup as experiment 2 except
that here, choosing any of the two spouts makes both spouts inactive until the
animal makes them active by staying on top of a sensor plate located equidistant
from both spouts for 1 second. After the learning phase, for 5 sessions, the
spouts will be changed to one delivering a 5% sucrose solution 100% of the time,
whereas the other will randomly deliver 50% of the time, alternating positions
between sessions. For the next 10 sessions, spread 48 hours apart, animals will
perform the same task after VTA injections of orexin-A and an orexin receptor
antagonist TCS1105 (0.3 nmol / side) in random sequence for 5 sessions each. All
sessions will be recorded with an infrared camera to obtain movement data.

Materials and instruments are the same as previous experiments. In addition, a
sensor plate will be placed equidistant to each spout, this plate sensor allows
us to enforce a trial structure to the task, where each trial begins after the
animal touches the plate for 1 second and ends when a spout is chosen. Infrared
video data will be processed with a custom-made image processing software, to
obtain animal centroid. Allowing us to track animal movement at a resolution of
~30 frames per second. Similar to previous experiments using the lickometer, the
main measures obtained are the number of events and licks per spout with a
timestamp, and positional “x-y” data from video recordings.

### Data analysis

Our main interest is to measure how orexin-induced activity modifies the choice
ratio between uncertain and certain alternatives, in a forced-choice paradigm.
Additionally, behavioral trajectories between trial start and end will inform us
of locomotor activity up to decision, which can be considered as the exploratory
activity.

### Data analysis pipeline

We will compare the ratios of uncertain to certain options between conditions
without drug, orexin antagonist and orexin agonist using a two-ways repeated
measures ANOVA for choice ratio, using drug and session number as covariates. A
mixed effects logistic regression will be fitted to data to obtain a more
fine-grained effect of orexin in the choice between spouts. The logistic model
will allow us to determine the change in odds for choosing the certain or
uncertain option, while controlling for individual differences, weight, and
baseline number of events. Video recordings will allow us to compute the area
under the trajectory curve, which basically measures the distance between an
optimal (straight) path from the sensor plate to the spout chosen and the actual
path taken, so more deviation accounts for a larger area. Area under the
trajectory curve can inform us about invigoration of exploitative behavior
between conditions (reduction of area under the trajectory curve). Instantaneous
speed and traveled distance, will allow us to infer time spent exploring and
exploiting. All previous features derived from video recording will be tested
using repeated measures ANOVA with Tukey post-hoc pairwise comparison, allowing
us to determine differences between the drug conditions.

\pagebreak

# Work plan

![Work plan gantt chart, Thesis I-VI lengths are approximated, and are included
to guide the time scales](/home/nicoluarte/gantt.png)

![Work plan with specific dates and planned amount of work
days](/home/nicoluarte/table.png)

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


