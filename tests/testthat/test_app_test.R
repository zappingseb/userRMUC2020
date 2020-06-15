library(shinytest)
context("app with counter")
# This file is for testing the applications in the inst/ directory.
windows_report_test <- function(appDir, testname = "mytest") {
  cat("\n")
  current_dir  <- file.path(appDir, "tests", paste0(testname, "-current"))
  expected_dir <- file.path(appDir, "tests", paste0(testname, "-expected"))
  file1 <-file.path(
    working_dir, 
    list.files(expected_dir, pattern = ".json", full.names = T, include.dirs = T)
  )
  file2 <-file.path(
    working_dir,
    list.files(current_dir, pattern = ".json", full.names = T)
  )
  for (i in 1:length(file1)) {
    system(paste("fc",
                 gsub(pattern = "/", replacement = "\\\\", file1[i]),
                 gsub(pattern = "/", replacement = "\\\\", file2[i])
    ))
  }
}

test_that("sampleapp works", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  
  # Use compareImages=FALSE because the expected image screenshots were created
  # on a Mac, and they will differ from screenshots taken on the CI platform,
  # which runs on Linux.
  test_result <- testApp("app_test", compareImages = FALSE, interactive = FALSE)
  
  expect_pass(test_result)
  if (!all(unlist(lapply(test_result$results, `[[`, "pass")))) {
    if (Sys.info()["sysname"] == "Windows") {
      windows_report_test("app_test")
    } else {
      shinytest::textTestDiff("app_test")
    }
  }
})