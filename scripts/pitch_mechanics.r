
# import data from .csv file
mechanics_data <- read.csv("https://raw.githubusercontent.com/petecht66/lucas-giolito-analysis-2025/refs/heads/main/data/Lucas%20Giolito%20Arm%20Angle%20and%20Mound%20Data.csv")

first_half <- mechanics_data[(mechanics_data$StartNum<=7), ]
first_half



