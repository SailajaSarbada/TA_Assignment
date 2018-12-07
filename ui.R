


#---------------------------------------------------------------------#
#               UDPipe NLP workflow App                               #
#---------------------------------------------------------------------#

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
                             br(),
                             h4('How to use this App'),
                             p('To use this app,'),
                             p('Click on', strong("Upload text data"),'and upload the text data file.','Please refer to the link',
                             a(href="https://raw.githubusercontent.com/SailajaSarbada/TA_Assignment/master/Sample%20Datasets/Nokia_Lumia_reviews.txt","Sample data input file"),' for sample text file.'
                              ),
                             p('Click on',strong("Upload udpipe data"),'and upload the udpipe data file.','Please refer to the link',
                               a(href="https://github.com/SailajaSarbada/TA_Assignment/blob/master/Sample%20Datasets/english-ud-2.0-170801.udpipe","Sample udpipe data input file"),' for sample udpipe file.'),
                             p('Check',strong("Input checkbox"),'for XPOS selection.')
                    ),
                    tabPanel("Table",dataTableOutput('table'),
                             br(),br(),
                             downloadButton('downloadData1', 'Download the data'),br(),br()
                            ),
                    tabPanel("Co-occurrence",
                             plotOutput("plot")
                    )
                    
        ) # end of tabsetPanel
      )# end of main panel
    ) # end of sidebarLayout
  )  # end if fluidPage
) # end of UI




