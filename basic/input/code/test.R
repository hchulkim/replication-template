
# read in necessary package
# if (!require("pacman")) install.packages("pacman")
# pacman::p_load(tidyverse, here)
library(tidyverse)
library(here)

# read in the data
data <- read_rds(here("input", "data", "raw_data.rds"))


# do some analysis
data <- data %>% 
  select(mpg, cyl)



# save the output result
data %>% write_rds(here("output", "tables", "processed_data.rds"))
