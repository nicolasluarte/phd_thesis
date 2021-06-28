library(tidyverse)
library(ggpubr)

p = seq(0, 1, length = 100)
plot(p, dbeta(p, 1, 1), type = "l")
