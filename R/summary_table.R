
#' Create a grouped summary table
#' 
#' @param x (\code{numeric}) Vector with numbers
#' @param y (\code{factor}) Vector with factor levels
#' 
#' @export
#' @import magrittr
#' @importFrom dplyr group_by summarise
#' @importFrom stats median quantile
#' @examples 
#' set.seed(1)
#' x <- sample(1:100, 50, replace = TRUE)
#' y <- as.factor(sample(c("Drug", "Placebo", "no treament"), 50, replace = TRUE))
#' 
#' summary_table(x, y)
#' 
#' set.seed(1)
#' x <- c(
#'   rnorm(50, 115, sd = 25),
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
#' summary_table(x, y)
summary_table <- function(x, y) {
  stopifnot(is.numeric(x))
  stopifnot(is.factor(y))s
  
  data.frame(x = x, y = y) %>%
    dplyr::group_by(y) %>%
    dplyr::summarise(
      mean = mean(x),
      median = median(x),
      lower_quantile = quantile(x, 0.1),
      upper_quantile = quantile(x, 0.9)
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
#'   rnorm(50, 115, sd = 25),
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