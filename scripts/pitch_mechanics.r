# R packages needed for this script
library(ggplot2)
library(tidyr)

# import data from .csv file
mechanics_data <- read.csv("https://raw.githubusercontent.com/petecht66/lucas-giolito-analysis-2025/refs/heads/main/data/Lucas%20Giolito%20Arm%20Angle%20and%20Mound%20Data.csv")

# creating data frame for first half of Giolito's season: includes his first 7 starts with old arm angle
first_half <- mechanics_data[(mechanics_data$StartNum <= 7), ]
first_half

# creating data frame for second half of Giolito's season: includes his last 6 starts with new arm angle
second_half <- mechanics_data[(mechanics_data$StartNum > 7), ]
second_half

# creating a column for starts with old arm angle versus new arm angle
mechanics_data$Angle <- ifelse(mechanics_data$StartNum <= 7, "Old Arm Angle", "New Arm Angle")

# plotting arm angle by start number while identifying where arm angle change was
ggplot(mechanics_data, aes(x = StartNum, y = AvgArmAngle, color = Angle)) +
geom_point() + geom_line() + ggtitle("Lucas Giolito's Average Arm Angle by Start") +
labs(x = "Start Number", y = "Average Arm Angle in Degrees") +
theme_minimal() + theme(plot.title = element_text(hjust = 0.5))

# illustrating the accompanying change in extension
ggplot(mechanics_data, aes(x = AvgArmAngle, y = Extension, color = Angle)) +
geom_point() + geom_line() + ggtitle("The Accompanying Change in Extension") +
labs(x = "Average Arm Angle in Degrees", y = "Average Distance from Mound in Feet") +
theme_minimal() + theme(plot.title = element_text(hjust = 0.5))

# vertical vs horizontal release points by start
ggplot(mechanics_data, aes(x = HorzRelPoint, y = VertRelPoint, color = Angle)) +
geom_point() + geom_line() + ggtitle("Horizontal vs. Vertical Release Points by Start") +
labs(x = "Average Distance Away from the Plate in Feet", y = "Average Distance Above the Ground in Feet") +
theme_minimal() + theme(plot.title = element_text(hjust = 0.5))

# reshape to long format for faceting
long_mechanics <- mechanics_data %>%
  pivot_longer(cols = c(AvgArmAngle, Extension, HorzRelPoint, VertRelPoint),
               names_to = "Metric", values_to = "Value")

# creating facet plot to illustrate mechanics data by start
ggplot(long_mechanics, aes(x = StartNum, y = Value, color = Angle)) +
  geom_point() + geom_line() +
  facet_wrap(~ Metric, scales = "free_y") +
  labs(title = "Lucas Giolito's Pitching Mechanics by Start",
       x = "Start Number", y = "Mechanical Data") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))



