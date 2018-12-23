
#---------------------------------------------------------------------#
#               UDPipe NLP Workflow App                               #
#---------------------------------------------------------------------#

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
windowsFonts(devanew=windowsFont("Devanagari new normal"))
shinyUI( fluidPage(
    
    titlePanel(" UDPipe NLP workflow"),
    sidebarLayout( 
      sidebarPanel(  
        fileInput("file1", "Upload text file"),
        fileInput("file2", "Upload udpipe file"),
        setBackgroundColor(color = c("#F7FBFF", "#2171B5"),
                           gradient = "linear",
                           direction = "bottom"),
        prettyCheckboxGroup(
          inputId = "inCheckboxGroup",
          label = "Select List for POS Tags", thick = TRUE,
          choices = c("adjective (JJ)"= "JJ",
                      "noun(NN)"="NN",
                      "proper noun (NNP)"= "NNP",
                      "adverb (RB)"="RB",
                      "verb (VB)"="VB"),
          selected = c("JJ","NN","NNP"),
          animation = "pulse", status = "info" ),
        submitButton(text = "Submit Changes", icon("refresh"))
      ),   # end of sidebar panel
      
      
      mainPanel(
       tabsetPanel(type = "tabs",
             tabPanel(h3(strong("Overview")),
                             br(),
                             p('The "UDPipe NLP workflow" Shiny app is created to do Basic Text Analysis on a text file entered by the user. The mandatory features the app has are listed below:
                               A - Read any text file using standard upload functionality
                               B - Option to upload trained UDPipe model for different languages. 
                               C - Provide the user with a select list of part-of-speech tags (XPOS) using check box for plotting cooccurrences.'),
                             p('The required XPOS in our app are: adjective (JJ) noun(NN) proper noun (NNP) adverb (RB) verb (VB).'),
                             br(),
                             p(strong("Note"),'The default XPOS selection list when the app is opened should be: adjective (JJ), noun (NN), proper noun (NNP).'),
                             br(),
                             h3(p("Data input")),
                             p("This app supports text data files only, the supported languagues are: English, Spanish and Hindi.",align="justify"),
                             br(),
                             h3('How to use this App'),
                             p('To use this app, upload the text file in language of interest, followed by the appropriate trained UDPipe Model file, as explained below.'),
                             p(''),
                             p('Step 1: Click on', strong("Upload text data"),'and upload the text data file.','Please refer to the link',
                             a(href="https://raw.githubusercontent.com/SailajaSarbada/TA_Assignment/master/Sample%20Datasets/Nokia_Lumia_reviews.txt","Sample data input file"),' for sample text file.'
                              ),
                             p('Step 2: Click on',strong("Upload udpipe data"),'and upload the udpipe data file.','Please refer to the link',
                               a(href="https://github.com/SailajaSarbada/TA_Assignment/blob/master/Sample%20Datasets/english-ud-2.0-170801.udpipe","Sample udpipe data input file"),' for sample udpipe file.'),
                             p('Step3: Check',strong("Input checkbox"),'for XPOS selection, if you wish to change the default selection.'),
                             p('Click the submit button.'),
                             br(),
                             h3(p("App Created for Text Analytics Group Assignment")),
                             h5(p(em("Sailaja Sarbada (11810046)    Sobhana Somisetty(11810100)     Sravani PVN(11810104)",align="justify"))),
                             br()),
              tabPanel(h3(strong("Table")),dataTableOutput('table'),
                             h4(p('The table shows the POS classification for the corpus created.',align = "justify")),
                             br(),br(),
                             downloadButton('downloadData1', 'Download the data'),br(),br()),
              tabPanel(h3(strong("Word Cloud")),
                             h4(p('The two diagrams below depict word clouds for',strong("Nouns"),"and",strong("Verbs"),'.The side panel XPOS options are',strong('deactivated'),'for this.')),
                             h4("Nouns"),
                             plotOutput("wordcloud1"),
                             h4("Verbs"),
                             plotOutput('wordcloud2')),
              tabPanel(h3(strong("Co-occurrence")),
                             br(),
                             h4(p('Please select',strong('POS'),'tags from side panel and click',strong('Submit Changes.'),'Based on',strong('XPOS selection'),'document is filter annotated and co-occurrences plot is built.')),
                             plotOutput("plot"),
                             br(),br(),
                             h4(p(strong("Note"),'For Hindi and Spanish we filter the POS Tags based on the uPOS labels.')))
                    
        ) # end of tabsetPanel
      )# end of main panel
    ) # end of sidebarLayout
  )  # end if fluidPage
) # end of UI




