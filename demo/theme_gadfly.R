library(rcdimple)
library(pipeR)

data.frame(x = 1:10, y = 1:10, groups = letters[round(runif(10,1,5))]) %>>%
  dimple( 
    y ~ x
    ,groups = "groups"
    ,type = "bubble"
  ) %>>%
  xAxis (showGridlines = TRUE) %>>%
  yAxis (showGridlines = TRUE) %>>% 
  default_colors ( c("#00BFFF","#D4CA3A","#FF5EA0","#00E5B2","#F6A6FF") ) -> d1

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

d2 <- data.frame(HairEyeColor) %>>%
   dimple(
     y = "Freq"
     , x = "Hair"
     , groups = "Eye"
     , type = "line"
   ) %>>%
     default_colors ( c("#00BFFF","#D4CA3A","#FF5EA0","#00E5B2","#F6A6FF") )

d2$dependencies = list(htmlDependency(
  name = "dimple-gadfly"
  ,version = "0.1.0"
  ,src = c(file=system.file("htmlwidgets/lib/dimple-themes",package="rcdimple"))
  ,stylesheet = "theme_gadfly.css"
))

d2