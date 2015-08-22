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

# this is the least favored route, so wrap it in function
(function(d){
  d$dependencies = list(htmlDependency(
    name = "dimple-gadfly"
    ,version = "0.1.0"
    ,src = c(file=system.file("htmlwidgets/lib/dimple-themes",package="rcdimple"))
    ,stylesheet = "theme_gadfly.css"
  ))
  d
})(d1) #->d1

# tasks probably best to handle, but wonder about other implications
#   this effectively namespaces the styling to the chart
#   also with an array of objects this could be made extensible
#   for other themes
d1$x$options$tasks = list(htmlwidgets::JS(
'
function(){
  var chart = d3.select(this);

  chart.selectAll( ".dimple-custom-axis-label" )
    .style("font-size", "1.15em")
    .style("color", "#564a55");
  chart.selectAll(".dimple-custom-axis-title")
    .style("font-size", "0.95em")
    .style("color","#564a55");
  // tooltip does not work since gets added on the fly
  //  how to handle
  chart.selectAll(".dimple-custom-tooltip-box")
    .style("stroke","none")
    .style("opacity","0.8");
  chart.selectAll(".dimple-custom-tooltip-label")
    .style("font-size", "0.9em");
  chart.selectAll(".dimple-custom-series-bubble")
    .style("stroke","none");
  chart.selectAll(".dimple-custom-series-line")
    .style("stroke-width", "0.3mm");
  chart.selectAll(".dimple-custom-gridline, .dimple-custom-axis-line")
    .style("stroke", "#D0D0E0")
    .style("stroke-width", "0.08em")
    .style("fill", "none");
  chart.selectAll(".dimple-custom-gridline")
    .style("stroke-dasharray", "0.2em, 0.2em");
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

d2
