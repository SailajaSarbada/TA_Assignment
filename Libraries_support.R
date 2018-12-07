# setup code block
try(require(shiny) || install.packages("shiny"))
if (!require(udpipe)){install.packages("udpipe")}
if (!require(textrank)){install.packages("textrank")}
if (!require(stringr)){install.packages("stringr")}
if (!require(lattice)){install.packages("lattice")}
if (!require(igraph)){install.packages("igraph")}
if (!require(ggraph)){install.packages("ggraph")}
if (!require(ggplot2)){install.packages("ggplot2")}
if (!require(shinyWidgets)){install.packages("shinyWidgets")}
if (!require(shinydashboard)){install.packages("shinydashboard")}
if (!require(DT)){install.packages("DT")}


library(shiny)
library(udpipe)
library(textrank)
library(lattice)
library(igraph)
library(ggraph)
library(ggplot2)
library(wordcloud)
library(stringr)
library(shinyWidgets)
library(shinydashboard)
library(DT)
