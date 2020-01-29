library(devtools)
require(roxygen2)

rm(list = ls()) # clear workspace before building

getwd()
setwd("/Users/kprovost/Documents/Github/")
#dir.create('./subsppLabelR/')
setwd(paste(getwd(), '/subsppLabelR/', sep=''))
#setwd(paste(getwd(),"/Documents/Github/speciesPairNicheOverlap/",sep=""))

#create('./')

roxygenize('./') #Builds description file and documentation

## put your functions in the R folder

## to ignore folder
devtools::use_build_ignore("scripts")

roxygenize('./')
check(cran=TRUE)

library(subsppLabelR,verbose=T)
install_github('kaiyaprovost/subsppLabelR')

#####

## make your functions
## you can have one Rscript with many functions, groups of related functions,
## or one script for each function

## to make a function do these steps 
## the "#'" is an roxygen comment
## param are the parameters
## export tells you to export it
## examples is how you use the function
## there are different @blah you can do 

## this is how to load packages
#' @import raster
#' @import paralell
#' @import stats
NULL


#' Echo
#' 
#' This function echos whatever you give it.
#' 
#' @param echo A word or sentence to echo
#'
#' @export
#' @examples
#'
#' echo('This is a test')


echo = function(echo){
  return(echo)
}

