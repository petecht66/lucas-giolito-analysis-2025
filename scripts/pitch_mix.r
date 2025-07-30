# R packages needed for this script
library(ggplot2)
library(tidyr)
library(dplyr)

# import data from .csv file
performance_data <- read.csv("https://raw.githubusercontent.com/petecht66/lucas-giolito-analysis-2025/refs/heads/main/data/Lucas%20Giolito%20Pitch%20Mix%20and%20Outcomes.csv")

# creating a column for starts with old arm angle versus new arm angle, similar to other file
performance_data$Angle <- ifelse(performance_data$StartNum <= 7, "Old Arm Angle", "New Arm Angle")

# plotting strike percentage by start number while identifying where arm angle change was
ggplot(performance_data, aes(x = StartNum, y = Strike., color = Angle)) +
  geom_point() + 
  geom_line() + 
  geom_hline(yintercept = 64.5, linetype = "dashed", color = "black") +
  annotate("text", x = max(performance_data$StartNum), y = 64.5, 
           label = "League Avg", vjust = -0.5, hjust = 1, size = 3) +
  ggtitle("Strike Percentage by Start") +
  labs(x = "Start Number", y = "Strike%") +
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5))


# reshape pitch mix to long format
long_pitch_mix <- performance_data %>%
  pivot_longer(cols = c(FB., SL., CH., CB.),
               names_to = "PitchType",
               values_to = "Usage%") %>%
  mutate(PitchType = recode(PitchType, # have to mutate here for labels on the legend
                            `FB.` = "FB%",
                            `SL.` = "SL%",
                            `CH.` = "CH%",
                            `CB.` = "CB%"))

# plot usage of Giolito's pitch mix on one graph
ggplot(long_pitch_mix, aes(x = StartNum, y = `Usage%`, color = PitchType)) +
  geom_point() +
  geom_line() +
  geom_vline(xintercept = 7.5, linetype = "solid", color = "black") +
  ggtitle("Pitch Type Usage by Start") +
  labs(x = "Start Number", y = "Usage Percentage", color = "Pitch Type") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))