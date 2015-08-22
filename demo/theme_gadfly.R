library(rcdimple)
library(pipeR)

data.frame(x = 1:10, y = 1:10) %>>%
  dimple( 
    y ~ x
    ,type = "bubble"
  ) %>>%
  xAxis (showGridlines = TRUE) %>>%
  yAxis (showGridlines = TRUE) -> d1

d1$dependencies = list(htmlDependency(
  name = "dimple-gadfly"
  ,version = "0.1.0"
  ,src = c(file=system.file("htmlwidgets/lib/dimple-themes",package="rcdimple"))
  ,stylesheet = "theme_gadfly.css"
))

d1$x$options$tasks = list(htmlwidgets::JS(
'
function(){
  d3.select(this).selectAll( ".dimple-custom-series-bubble" )
    .attr("r","0.25em")
}
'
))

d1



default_stroke_color <- function (fill_color=NA) {
  if (is.na (fill_color)) fill_color <- polarLab(70, 60, 240)
  polarLab(fill_color.L - 15, fill_color.C, fill_color.H)
}
