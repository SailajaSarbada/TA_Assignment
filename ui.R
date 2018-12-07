


#---------------------------------------------------------------------#
#               UDPipe NLP workflow App                               #
#---------------------------------------------------------------------#
install.packages("DT")
library(udpipe)
library(stringr)
library("shiny")
library(shinyWidgets)
library(shinydashboard)
library(igraph)
library(ggraph)
library(ggplot2)
library(DT)
shinyUI( fluidPage(
    
    titlePanel(" UDPipe NLP workflow"),
    
    sidebarLayout( 
      
      sidebarPanel(  
        
        fileInput("file1", "Upload text file"),
        fileInput("file2", "Upload udpipe file"),
        p("some text need to enter for make up :P"),
        setBackgroundColor(color = c("#F7FBFF", "#2171B5"),
                           gradient = "linear",
                           direction = "bottom"),
        prettyCheckboxGroup(
          inputId = "inCheckboxGroup",
          label = "Input checkbox", thick = TRUE,
          choices = c("adjective"= "ADJ",
                      "Noun" = "NOUN",
                      "proper noun" = "PROPN",
                      "adverb"="ADV","verb"= "VERB"),
          selected = c("ADJ","NOUN","PROPN"),
          animation = "pulse", status = "info" )
      ),   # end of sidebar panel
      
      
      mainPanel(
        
        tabsetPanel(type = "tabs",
                    
                    tabPanel("Overview",
                             h4(p("Data input")),
                             p("This app supports only text data file.",align="justify"),
                             p("Please refer to the link below for sample csv file."),
                             a(href="https://github.com/sudhir-voleti/sample-data-sets/blob/master/Segmentation%20Discriminant%20and%20targeting%20data/ConneCtorPDASegmentation.csv"
                               ,"Sample data input file"),   
                             br(),
                             h4('How to use this App'),
                             p('To use this app,'),
                             p('Click on', strong("Upload text data"),'and upload the text data file.'),
                             p('Click on',strong("Upload udpipe data"),'and upload the udpipe data file.'),
                             p('Check',strong("Input checkbox"),'for XPOS selection.')
                    ),
                    tabPanel("Table",dataTableOutput('table'),
                             br(),br(),
                             downloadButton('downloadData1', 'Download the data'),br(),br(),
                             p(" write some story")),
                    tabPanel("Co-occurrence",
                             plotOutput("plot")
                    )
                    
        ) # end of tabsetPanel
      )# end of main panel
    ) # end of sidebarLayout
  )  # end if fluidPage
) # end of UI




