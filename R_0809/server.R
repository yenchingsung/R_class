
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })
  
  output$testPlot <- renderPlot({
    plot(1:(input$testin))
  })
  
  output$textPlot <- renderText({
    htmlSTR1 = "<h3><font color='red'>"
    htmlSTR2 = "</font></h3>"
    html = paste(htmlSTR1, input$Text,sep="")
    html = paste(html, htmlSTR2,sep="")
    print(html)
  })

})
