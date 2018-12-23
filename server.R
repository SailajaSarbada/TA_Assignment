#shiny server created for Text Analytics Assignment
#Sailaja Sarbada (11810046)    Sobhana Somisetty(11810100)     Sravani PVN(11810104)


shinyServer(function(input, output) {
 
  options(warn=-1)
  options(shiny.maxRequestSize=30*1024^2)
  #windowsFonts(devanew=windowsFont("Devanagari new normal"))
  
  Dataset <- reactive({
    if (is.null(input$file1)) {   # locate 'file1' from ui.R
        return(NULL) } else{
          Data <- readLines(input$file1$datapath,encoding ="UTF-8")
          Data  =  str_replace_all(Data, "<.*?>", "") # get rid of html junk 
          return(Data)
      }
  })
  
  Dataudpipe <- reactive({
    if (is.null(input$file2)) {   # locate 'file1' from ui.R
      return(NULL) } else{
        language = udpipe_load_model(input$file2$datapath)  # file_model only needed
        return(language)
      }
  })
  udpipe_table <- reactive({
    x<- udpipe_annotate(Dataudpipe(), x = Dataset())
    #Encoding(x$conllu)
    #cat(x$conllu, file = "myannotation.conllu")
    x <- as.data.frame(x)
    return(x)
  })
  
 
  
  
  output$downloadData1 <- downloadHandler(
    
    filename = function(){
      "file1.csv"
    }, 
    content = function(file){
      write.csv(udpipe_table()[,-4],file,row.names = FALSE)
    }
  )
  # Calc and render plot   
  output$table = DT::renderDataTable({
      if(is.null(input$file1)){return(NULL)}
      else{
      #out = head(udpipe_table())
      out = DT::datatable(udpipe_table()[,-4], options = list(orderClasses = TRUE))
      return(out)
     }})
  output$wordcloud1 <- renderPlot({
    if(is.null(input$file1)){return(NULL)}
    else{
      nouns = subset(udpipe_table(),xpos %in% "NN" | upos %in% "NOUN")
      top_nouns = txt_freq(nouns$lemma)
    wordcloud(words = top_nouns$key, 
              freq = top_nouns$freq, 
              scale=c(3,1),
              min.freq = 2, 
              max.words = 100,
              random.order = FALSE, 
              colors = brewer.pal(8, "Dark2"))
    }
  })
  output$wordcloud2 <- renderPlot({
    if(is.null(input$file1)){return(NULL)}
    else{
      verbs = subset(udpipe_table(),xpos %in% "VB" | upos %in% "VERB")
      top_verbs = txt_freq(verbs$lemma)
      wordcloud(words = top_verbs$key, 
                freq = top_verbs$freq, 
                scale=c(3,1),
                min.freq = 2, 
                max.words = 100,
                random.order = FALSE, 
                colors = brewer.pal(8, "Dark2"))
    }
  })

  
  output$plot = renderPlot({ 
    
    
    xposvalues<- paste(input$inCheckboxGroup)
    vector=list()
    if ('JJ' %in% xposvalues)
      vector <- c(vector, 'ADJ')
    if ('NN' %in% xposvalues)
      vector <- c(vector, 'NOUN')
    if ('NNP' %in% xposvalues)
      vector <- c(vector, 'PROPN')
    if ('RB' %in% xposvalues)
      vector <- c(vector, 'ADV')
    if ('VB' %in% xposvalues)
      vector <- c(vector, 'VERB')
    
    
    nokia_cooc <- cooccurrence( 
      x = subset(udpipe_table(), xpos %in% input$inCheckboxGroup | upos %in% vector),
      term = "lemma", 
      group = c("doc_id", "paragraph_id", "sentence_id"))
    wordnetwork <- head(nokia_cooc, 50)
    wordnetwork <- igraph::graph_from_data_frame(wordnetwork) 
    
    ggraph(wordnetwork, layout = "fr") +  
      
      geom_edge_link(aes(width = cooc, edge_alpha = cooc), edge_colour = "orange") +  
      geom_node_text(aes(label = name), col = "darkgreen", size = 4) +
      
      theme_graph(base_family = "Arial Narrow") +  
      theme(legend.position = "none") +
      
      labs(title = "Cooccurrences within the words distance")
    
  })
  
  
})
