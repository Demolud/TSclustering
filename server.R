library(shiny)
library(TSclust)

shinyServer(function(input, output) {


  output$distPlot <- renderImage({

    inFile <- input$file1
    if (is.null(inFile)){
      return (NULL)}
    file<-read.csv(file = inFile$datapath, sep = input$sep, dec = input$dec)
    clust<-diss(file, "CDM")                     # applying distance metrics
    clust <- hclust(clust, method = "ward.D")    # calculating distances
    

    outfile <- tempfile(fileext='.png')          # this format is better for this type of graphs
    png(outfile, width=input$w, height=input$h)  # and is ready to use in papers.
    par(cex=1)
         plot(clust, main=input$main, xlab = input$xlab, ylab = input$ylab, sub = "")
    if (input$rect == TRUE) {
      rect.hclust(clust, k=input$k, border = input$rectcol) # cluster highlighting
    }
        dev.off()

        list(src = outfile,
             contentType = 'image/png',
             width = input$w,
             height = input$h,
             alt = "Please upload a file")
  }, deleteFile = TRUE)
  

})
