# Foraging models and underlying processes in food-seekings behavior

One of the way classical models such as [@ESYGCSLH#Charnov_1976] dealt with
modeling foraging in uncertain environments, was with the assumption of perfect
knowledge. Animals should stay seeking for food within a patch for as long the
capture rate is above the capture rate of the environment
[@ESYGCSLH#Charnov_1976], which implicitly assumes that somehow the animal is
able to compute such capture rate. While such assumptions may sound
unrealistic, there is some support for this as an experienced forager may learn
and integrate information about the environment to closely approximate the
perefect knowledge [@9X7Z6PMX#Marshall_Etal_2016].

On the other hand, and in consequence with the priously exposed relation
between foraging and uncertainty, a model presented here should account for
such relation. First, the rules determining the results of the interaction
between animal and environment are assumed to be unknown or only partially
known due to the stochastic nature of the environment. Then, the animal may
take any action $a$ within a set of possible actions $a \in A$ for a particular
state of the environment $s$. Any action $a$ causes an stochastic transition
from a state $s$ to another state $s'$. As such the result of an interaction
between animal and environment can be described by its value $q$ which is a
function of both action and current environment state $q(s, a)$. Such model of
action, state and value corresponds to a markov decision process
[@2BEHEM7X#Sutton_Barto_2018]. In this model, all environment dynamics are
described by the probabilities $p(s', r | s, a)$, where $r$ is the obtained
reward (interaction outcome), and such probabilities is defined for every pair
of $a$ and $s$. We could consider a markov decision process to include the
perceptual noise which we deemed inherent to food-seeking behavior, by
considering that states $s$ are paired with an observation $o$ made by the
animal to infer state $s$, because state cannot be directly observed or there
is some sensory noise. As such, animals consider environment states as
conditional probability of any particular observation given a state $p(o | s)$,
giving a belief of the current state based of perceptual information
[@W73P5HZ9#Ma_Jazayeri_2014].

Optimal Sensorimotor Integration in Recurrent Cortical Networks: A Neural
Implementation of Kalman Filters

Describe the role of uncertainty in q(s, a)

How to guide exploitation/exploration

Comparing model that explicitly include uncertainty
