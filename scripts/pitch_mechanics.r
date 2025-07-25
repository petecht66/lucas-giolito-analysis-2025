# R packages needed for this script
library(ggplot2)

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

ggplot(mechanics_data, aes(x = AvgArmAngle, y = Extension, color = Angle)) +
geom_point() + geom_line() + ggtitle("Lucas Giolito's Average Arm Angle by Start") +
labs(x = "Start Number", y = "Average Arm Angle in Degrees") +
theme_minimal() + theme(plot.title = element_text(hjust = 0.5))



