#' This function is going to generate the + insted of a TRUE value
#'
#' Use it for table generation where T or F values need to be nicely presented
#'
#' @param x Include the vector to be tranformed
#' @return a vector of + and - values
#' @export


pmf <- function(x){
  ifelse(x==T,"+","-")
}
