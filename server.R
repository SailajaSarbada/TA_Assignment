
shinyServer(function(input, output) {
  
  options(shiny.maxRequestSize=30*1024^2)
  
  Dataset <- reactive({
    if (is.null(input$file1)) {   # locate 'file1' from ui.R
        return(NULL) } else{
          Data <- readLines(input$file1$datapath)
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
    x <- as.data.frame(x)
    return(x)
  })
  
  
  output$mytable2 <- DT::renderDataTable({
    DT::datatable(mtcars, options = list(orderClasses = TRUE))
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
  output$plot = renderPlot({ 
    nokia_cooc <- cooccurrence(     # try `?cooccurrence` for parm options
      x = subset(udpipe_table(), upos %in% input$inCheckboxGroup),#input$inCheckboxGroup), 
      term = "lemma", 
      group = c("doc_id", "paragraph_id", "sentence_id"))
    wordnetwork <- head(nokia_cooc, 50)
    wordnetwork <- igraph::graph_from_data_frame(wordnetwork) # needs edgelist in first 2 colms.
    
    ggraph(wordnetwork, layout = "fr") +  
      
      geom_edge_link(aes(width = cooc, edge_alpha = cooc), edge_colour = "orange") +  
      geom_node_text(aes(label = name), col = "darkgreen", size = 4) +
      
      theme_graph(base_family = "Arial Narrow") +  
      theme(legend.position = "none") +
      
      labs(title = "Cooccurrences within 3 words distance", subtitle = "Nouns & Adjective")
    
  })
  
  #clusters <- reactive({
   # kmeans(Dataset(), input$clusters)
  #})
  
  # output$clust_summary = renderTable({
  #   out = data.frame(Cluser = row.names(clusters()$centers),clusters()$centers)
  #   out
  # })
  
  #output$clust_data = renderDataTable({
  # out = data.frame(row_name = row.names(Dataset()),Dataset(),Cluster = clusters()$cluster)
  # out
  # })
  
})

