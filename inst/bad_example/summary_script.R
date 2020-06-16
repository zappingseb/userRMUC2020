experimental_data <- readRDS("experimental_data.rds")
# ---- Script Start ----
if (!"dplyr" %in% installed.packages()[, "Package"]) {
  install.packages("dplyr")
}
if (!"ggplot2" %in% installed.packages()[, "Package"]) {
  install.packages("ggplot2")
}
library(dplyr)
library(ggplot2)

# ---- * summary table IgA ----
experimental_data$IgA %>%
  dplyr::group_by(treatment) %>%
  dplyr::summarise(
    mean = mean(meas),
    median = median(meas),
    lower_quantile = quantile(meas, 0.1),
    upper_quantile = quantile(meas, 0.9)
  )

# ---- * summary table IgG ----
experimental_data$IgG %>%
  dplyr::group_by(treatment) %>%
  dplyr::summarise(
    mean = mean(meas),
    median = median(meas),
    lower_quantile = quantile(meas, 0.1),
    upper_quantile = quantile(meas, 0.9)
  )

# ---- * distribution plot IgA ----

ggplot(experimental_data$IgG, aes(x = meas, fill = treatment)) +
  geom_density(alpha = 0.5)

# ---- * distribution plot IgG ----

ggplot(experimental_data$IgG, aes(x = meas, fill = treatment)) +
  geom_density(alpha = 0.5)