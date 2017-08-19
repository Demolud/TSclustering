
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)


shinyServer(function(input, output) {
  library(TSclust)

  output$distPlot <- renderImage({

    inFile <- input$file1
    if (is.null(inFile)){
      return (NULL)}
    file<-read.csv(file = inFile$datapath, sep = input$sep, dec = input$dec)
    clust<-diss(file, "CDM")
    clust <- hclust(clust, method = "ward.D")
    

    outfile <- tempfile(fileext='.png')
    png(outfile, width=input$w, height=input$h)
    par(cex=1)
         plot(clust, main=input$main, xlab = input$xlab, ylab = input$ylab, sub = "")
    if (input$rect == TRUE) {
      rect.hclust(clust, k=input$k, border = input$rectcol)
    }
        dev.off()

        list(src = outfile,
             contentType = 'image/png',
             width = input$w,
             height = input$h,
             alt = "Please upload a file")
  }, deleteFile = TRUE)
  

})
