# ---- Data creation ----
set.seed(1)
experimental_data <- list(
  IgA = data.frame(
    meas = sample(1:100, 50, replace = TRUE),
    treatment = as.factor(sample(c("Drug", "Placebo", "no treament"), 50, replace = TRUE))
  ),
  IgG = data.frame(
    meas = c(
      rnorm(50, 115, sd = 25),
      rnorm(50, 198, sd = 65),
      sample(rnorm(50, 195, sd = 45), 50, TRUE)
    ),
    treatment = as.factor(c(
      rep("Drug", 50),
      rep("Placebo", 50),
      rep("no treatment", 50)
    ))
  )
)

saveRDS(experimental_data, "experimental_data.rds")