# R packages needed for this script
library(ggplot2)
library(tidyr)
library(dplyr)

# import data from .csv file
outcomes_data <- read.csv("https://raw.githubusercontent.com/petecht66/lucas-giolito-analysis-2025/refs/heads/main/data/Lucas%20Giolito%20Pitch%20Mix%20and%20Outcomes.csv")

# reshape the three different outcomes to long format
long_outcomes <- outcomes_data %>%
  pivot_longer(cols = c(K., B., H.),
               names_to = "Outcomes",
               values_to = "Outcome%") %>%
  mutate(Outcomes = recode(Outcomes, # have to mutate here for labels on the legend
                            `K.` = "Strikeout %",
                            `B.` = "Walk %",
                            `H.` = "Hit %"))

# plotting the three outcome percentages together on one graph
ggplot(long_outcomes, aes(x = StartNum, y = `Outcome%`, color = Outcomes)) +
  geom_point() +
  geom_line() +
  geom_vline(xintercept = 7.5, linetype = "solid", color = "black") + # black line indicates the switch in arm angle, identified in report
  ggtitle("Giolito's Outcomes by Start") +
  labs(x = "Start Number", y = "Outcome Percentage", color = "Outcomes") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

