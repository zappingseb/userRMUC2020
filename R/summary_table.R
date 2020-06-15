
#' Create a grouped summary table
#' 
#' @param x (\code{numeric}) Vector with numbers
#' @param y (\code{factor}) Vector with factor levels
#' 
#' @export
#' @import magrittr
#' @importFrom dplyr group_by summarise
#' @examples 
#' set.seed(1)
#' x <- sample(1:100, 50, replace = TRUE)
#' y <- as.factor(sample(c("Drug", "Placebo", "no treament"), 50, replace = TRUE))
#' 
#' summary_table(x, y)
#' 
#' set.seed(1)
#' x <- c(
#'   rnorm(50, 198, sd = 65),
#'   rnorm(50, 100, sd = 25),
#'   sample(rnorm(50, 195, sd = 45), 50, TRUE)
#' )
#' 
#' y <- as.factor(c(
#'  rep("Drug", 50),
#'  rep("Placebo", 50),
#'  rep("no treatment", 50)
#' ))
#' 
#' summary_table(x, y)
summary_table <- function(x, y) {
  stopifnot(is.numeric(x))
  stopifnot(is.factor(y))
  
  data.frame(x = x, y = y) %>%
    dplyr::group_by(y) %>%
    dplyr::summarise(
      mean = mean(x),
      median = median(x),
      q25 = quantile(x, 0.25),
      q75 = quantile(x, 0.75)
    )
  
}

#' Create a grouped distribution plot
#' 
#' @param x (\code{numeric}) Vector with numbers
#' @param y (\code{factor}) Vector with factor levels 
#' 
#' @export
#' @importFrom ggplot2 ggplot aes geom_density
#' @examples 
#' set.seed(1)
#' x <- sample(1:100, 50, replace = TRUE)
#' y <- as.factor(sample(c("Drug", "Placebo", "no treament"), 50, replace = TRUE))
#' 
#' summary_plot(x, y)
#' 
#' set.seed(1)
#' x <- c(
#'   rnorm(50, 100, sd = 25),
#'   rnorm(50, 198, sd = 65),
#'   sample(rnorm(50, 195, sd = 45), 50, TRUE)
#' )
#' 
#' y <- as.factor(c(
#'  rep("Drug", 50),
#'  rep("Placebo", 50),
#'  rep("no treatment", 50)
#' ))
#' 
#' summary_plot(x, y)
summary_plot <- function(x, y) {
  stopifnot(is.numeric(x))
  stopifnot(is.factor(y))
  
  ggplot(data.frame(x = x, y = y), aes(x=x, fill=y)) +
    geom_density(alpha = 0.5)
}