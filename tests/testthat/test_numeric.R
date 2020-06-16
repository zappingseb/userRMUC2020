context("numerical testing")

test_that("summary table", {
  data("experimental_data")
  
  result <- expect_silent(summary_table(experimental_data$IgG$meas, experimental_data$IgG$treatment))
  
  expect_equal(
    result$lower_quantile,
    c(90.29758, 149.46806, 125.22527)
  )
  
  result <- expect_silent(summary_table(experimental_data$IgA$meas, experimental_data$IgA$treatment))
  
  expect_equal(
    result$lower_quantile,
    c(23, 20, 15)
  )
})


test_that("summary plot", {
  expect_silent(summary_plot(experimental_data$IgA$meas, experimental_data$IgA$treatment))
  expect_silent(summary_plot(experimental_data$IgG$meas, experimental_data$IgG$treatment))
  
})