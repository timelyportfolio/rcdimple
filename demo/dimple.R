..p. <- function() invisible(readline("\nPress <return> to continue: "))
library(rcdimple)

#get data used by dimple for all of its examples as a first test
ex_data <- read.delim(
  "http://pmsi-alignalytics.github.io/dimple/data/example_data.tsv"
)


#eliminate . to avoid confusion in javascript
colnames(ex_data) <- gsub("[.]","", colnames(ex_data))

## example 1 vt bar
ex_data %>%
  dimple(x ="Month", y = "UnitSales", type = "bar") %>%
  xAxis(orderRule = "Date") %>%
  add_title( html = "<h4>Unit Sales by Month for Fictional Store</h4>" )

..p.() # ================================

## example 2 vt stacked bar

ex_data %>%
  dimple(x ="Month", y = "UnitSales", groups = 'Channel',
    type = "bar", width = 590, height = 400 
  ) %>%
  set_bounds( x = 60, y = 30, width = 510, height = 290 ) %>% 
  xAxis(orderRule = "Date") %>%
  add_legend(  ) %>%
  add_title( text = "Unit Sales each Month by Channel" )

..p.()# ================================
## example 3 vt stacked bar 100%
dimple( x ="Month", y = "UnitSales", groups = "Channel",
  data = ex_data, type = "bar", width = 590, height = 400
) %>%
  set_bounds(65, 30, 505, 305) %>% 
  xAxis( orderRule = "Date" ) %>%
  yAxis( type = "addPctAxis" ) %>%
  add_legend( x = 60, y = 10, width = 510, height = 20,
    horizontalAlign = "right"
  )

..p.()# ================================
## example 4 vertical grouped bar
ex_data %>%
  dimple(
    x = c("PriceTier","Channel"), y = "UnitSales",
    groups = "Channel", type = "bar", width = 590, height = 400
  ) %>%
  add_legend( x = 60, y = 10, width = 520, height = 20,
    horizontalAlign = "left"
  ) %>%
  default_colors( rainbow(4) )


..p.()# ================================
### example 5 vertical stack grouped bar
dimple(
  x = c("PriceTier","Channel"),
  y = "UnitSales",
  groups = "Owner",
  data = ex_data,
  type = "bar"
) %>%
  add_legend(
    x = "60%", width = "30%", y = "10%", height = 50 
  )

..p.()# ================================
#example 6 vertical 100% Grouped Bar
dimple(
  x = c("PriceTier","Channel"),
  y = "UnitSales",
  groups = "Owner",
  data = ex_data,
  type = "bar"
) %>%
  add_legend(
    x = "30%",
    width = "60%",
    height = 20,
    horizontalAlign = "right"
  ) %>%
  #make percent axis
  yAxis(type = "addPctAxis")


..p.()# ================================
#example 7 horizontal bar
dimple(
  Month ~ UnitSales,
  data = ex_data,
  type = "bar"
) %>%
  xAxis(type = "addMeasureAxis") %>%
  #good test of orderRule on y instead of x
  yAxis(type = "addCategoryAxis", orderRule = "Date")

#example 8 horizontal stacked bar
dimple(
  Month ~ UnitSales,
  groups = "Channel",
  data = ex_data,
  type = "bar"
) %>%
  xAxis(type = "addMeasureAxis") %>%
  #good test of orderRule on y instead of x
  yAxis(type = "addCategoryAxis", orderRule = "Date") %>%
  add_legend(
    x = 200,
    y = 10,
    width = 400,
    height = 20,
    horizontalAlign = "right"
  )

..p.()# ================================
#example 9 horizontal 100% bar
dimple(
  Month ~ UnitSales,
  groups = "Channel",
  data = ex_data,
  type = "bar"
) %>%
  xAxis(type = "addMeasureAxis") %>%
  #good test of orderRule on y instead of x
  yAxis(type = "addCategoryAxis", orderRule = "Date") %>%
  add_legend(
    x = 200,
    y = 10,
    width = 400,
    height = 20,
    horizontalAlign = "right"
  ) %>%
  # note how this changes the already specified xAxis
  xAxis(type = "addPctAxis")


..p.()# ================================
#example 10 horizontal stacked bar
dimple(
  x = "UnitSales", 
  y = c("PriceTier","Channel"),
  groups = "Channel",
  data = ex_data,
  type = "bar"
) %>% 
  xAxis(type = "addMeasureAxis", outputFormat = ',.0f') %>%
  yAxis(type = "addCategoryAxis") %>%
  add_legend()


..p.()# ================================
#example 11 horizontal stacked grouped bar
dimple(
  x = "UnitSales", 
  y = c("PriceTier","Channel"),
  groups = "Owner",
  data = ex_data,
  type = "bar"
) %>%
  xAxis(type = "addMeasureAxis") %>%
  yAxis(type = "addCategoryAxis") %>%
  add_legend()

..p.()# ================================
#example 12 horizontal 100% grouped bar
dimple(
  x = "UnitSales", 
  y = c("PriceTier","Channel"),
  groups = "Owner",
  data = ex_data,
  type = "bar"
) %>%
  xAxis(type = "addPctAxis") %>%
  yAxis(type = "addCategoryAxis") %>%
  add_legend( ) %>%
  add_title( html = "
   <h3 style = 'margin-top:0;margin-bottom:0;'>
      Sales by Price Tier and Channel
    </h3>
    Grouped by Owner
    "
   )

..p.()# ================================
#example 13 vertical marimekko
dimple(
  UnitSales ~ Channel,
  groups = "Owner",
  data = ex_data,
  type = "bar",
  # storyboard example
  storyboard = "Date"
) %>%
  xAxis(type = "addAxis", measure = "UnitSales", showPercent = TRUE) %>%
  yAxis(type = "addPctAxis") %>%
  add_legend()


..p.()# ================================
#example 14 horizontal marimekko
dimple(
  Channel ~ UnitSales,
  groups = "Owner",
  data = ex_data,
  type = "bar"
) %>%
  yAxis(type = "addAxis", measure = "UnitSales", showPercent = TRUE) %>%
  xAxis(type = "addPctAxis") %>%
  add_legend( x = "30%", width = "60%")


..p.()# ================================
#example 15 block matrix
dimple(
  x = c("Channel","PriceTier"),
  y = "Owner",
  groups = "PriceTier",
  data = ex_data,
  type = "bar"
) %>%
  yAxis(type = "addCategoryAxis") %>%
  xAxis(type = "addCategoryAxis") %>%
  add_legend()


..p.()# ================================
#example 16 Scatter
dimple(
  OperatingProfit~UnitSales,
  groups = c("SKU","Channel"),
  data = ex_data,
  type = "bubble"
) %>%
  xAxis( type = "addMeasureAxis" ) %>%
  yAxis( type = "addMeasureAxis" ) %>%
  add_legend()


..p.()# ================================
#example 17 Vertical Lollipop
dimple(
  UnitSales ~ Month,
  groups = "Channel",
  data = ex_data,
  type = "bubble"
) %>%
  #defaults to yAxis (Measure) and xAxis (Category)
  xAxis( orderRule = "Date") %>%
  add_legend( )


..p.()# ================================
#example 18 Vertical Grouped Lollipop
dimple(
  y = "UnitSales",
  x = c("PriceTier","Channel"),
  groups = "Channel",
  data = ex_data,
  type = "bubble",
  height = 400,
  width = 600
) %>%
  #defaults to yAxis (Measure) and xAxis (Category)
  set_bounds( 50, 20 , 450, 300 ) %>%
  add_legend(
    x = 520,
    y = "35%",
    width = 80,
    height = "50%",
    horizontalAlign = "right"
  )

..p.()# ================================
#example 19 Horizontal Lollipop
dimple(
  x = "UnitSales",
  y = "Month",
  groups = "Channel",
  data = ex_data,
  type = "bubble"
) %>%
  xAxis( type = "addMeasureAxis" ) %>%
  yAxis( type = "addCategoryAxis", orderRule = "Date") %>%
  add_legend()


..p.()# ================================
#example 20 Horizontal Grouped Lollipop
dimple(
  x = "UnitSales",
  y = c("PriceTier","Channel"),
  groups = "Channel",
  data = ex_data,
  type = "bubble",
) %>%
  xAxis( type = "addMeasureAxis" ) %>%
  yAxis( type = "addCategoryAxis") %>%
  add_legend( )


..p.()# ================================
#example 21 Dot Matrix
dimple(
  y = "Owner",
  x = c("Channel","PriceTier"),
  groups = "PriceTier",
  data = ex_data,
  type = "bubble"
) %>%
  xAxis( type = "addCategoryAxis" ) %>%
  yAxis( type = "addCategoryAxis") %>%
  add_legend()


..p.()# ================================
#example 22 Bubble
dimple(
  x = "UnitSalesMonthlyChange",
  y = "PriceMonthlyChange",
  z = "OperatingProfit",
  groups = c("SKU","Channel"),
  data = ex_data,
  type = "bubble"
) %>%
  xAxis( type = "addMeasureAxis" ) %>%
  yAxis( type = "addMeasureAxis" ) %>%
  # zAxis will be "addMeasureAxis" by default
  zAxis( type = "addMeasureAxis" ) %>%
  add_legend()


..p.()# ================================
#example 23 Vertical Bubble Lollipop
dimple(
  x = "Month",
  y = "UnitSales",
  z = "OperatingProfit",
  groups = "Channel",
  data = ex_data,
  type = "bubble"
) %>%
  xAxis( orderRule = "Date" ) %>%
  add_legend( )


..p.()# ================================
##example 24 Vertical Grouped Bubble Lollipop
dimple(
  x = c("PriceTier","Channel"),
  y = "UnitSales",
  z = "OperatingProfit",
  groups = "Channel",
  data = ex_data,
  type = "bubble"
) %>%
  add_legend()

..p.()# ================================
#example 25 Horizontal Bubble Lollipop
dimple(
  y = "Month",
  x = "UnitSales",
  z = "OperatingProfit",
  groups = "Channel",
  data = ex_data,
  type = "bubble"
) %>%
  yAxis( type = "addCategoryAxis", orderRule = "Date" ) %>%
  xAxis( type = "addMeasureAxis" ) %>%
  add_legend()


..p.()# ================================
##example 26 Horizontal Grouped Bubble Lollipop
dimple(
  y = c("PriceTier","Channel"),
  x = "UnitSales",
  z = "OperatingProfit",
  groups = "Channel",
  data = ex_data,
  type = "bubble"
) %>%
  yAxis( type = "addCategoryAxis" ) %>%
  xAxis( type = "addMeasureAxis" ) %>%
  add_legend()

..p.()# ================================
#example 27 Bubble Matrix
dimple(
  x = c( "Channel", "PriceTier"),
  y = "Owner",
  z = "Distribution",
  groups = "PriceTier",
  data = ex_data,
  type = "bubble",
  aggregate = "dimple.aggregateMethod.max"
) %>%
  xAxis( type = "addCategoryAxis" ) %>%
  yAxis( type = "addCategoryAxis" ) %>%
  zAxis( type = "addMeasureAxis", overrideMax = 200 ) %>%
  add_legend()

..p.()# ================================
#example 28 Area
dimple(
  UnitSales ~ Month,
  data = subset(ex_data, Owner %in% c("Aperture","Black Mesa")),
  type = "area"
) %>%
  xAxis(orderRule = "Date")

..p.()# ================================
#example 29 Stacked Area
dimple(
  UnitSales ~ Month,
  groups = "Channel",
  data = subset(ex_data, Owner %in% c("Aperture","Black Mesa")),
  type = "area"
) %>%
  xAxis(orderRule = "Date") %>%
  add_legend()

..p.()# ================================
#example 30 100% Stacked Area
dimple(
  UnitSales ~ Month,
  groups = "Channel",
  data = subset(ex_data, Owner %in% c("Aperture","Black Mesa")),
  type = "area"
) %>%
  xAxis(orderRule = "Date") %>%
  add_legend() %>%
  #just change type to pct for y axis
  yAxis( type = "addPctAxis" )



..p.()# ================================
#example 31 Grouped Area
dimple(
  y = "UnitSales",
  x = c("Owner","Month"),
  groups = "Owner",
  data = subset(ex_data, Owner %in% c("Aperture","Black Mesa")),
  type = "area"
) %>%
  xAxis(grouporderRule = "Date") %>%
  add_legend()


..p.()# ================================
#example 32 Grouped Stacked Area
dimple(
  y = "UnitSales",
  x = c("Owner","Month"),
  groups = "SKU",
  data = subset(ex_data, Owner %in% c("Aperture","Black Mesa")),
  type = "area",
  bounds = list(x=70,y=30,height=310,width=330),
  barGap = 0.05,
  lineWeight = 1,
  height = 400,
  width = 590
) %>%
  xAxis(grouporderRule = "Date") %>%
  yAxis(type = "addMeasureAxis") %>%
  add_legend(
    x = 430,
    y = "10%",
    width = 100,
    height = "70%",
    horizontalAlign = "left"
  )


..p.()# ================================
#example 33 Grouped 100% Area
dimple(
  y = "UnitSales",
  x = c("Owner","Month"),
  groups = "SKU",
  data = subset(ex_data, Owner %in% c("Aperture","Black Mesa")),
  type = "area",
  bounds = list(x=70,y=30,height=340,width=330),
  barGap = 0.05,
  lineWeight = 1,
  height = 400,
  width = 590
) %>%
  xAxis(grouporderRule = "Date") %>%
  add_legend(
    x = 430,
    y = 20,
    width = 100,
    height = 300,
    horizontalAlign = "left"
  ) %>%
  yAxis( type = "addPctAxis" )

..p.()# ================================
#example 34 Vertical Area
dimple(
  x = "UnitSales",
  y = "Month",
  data = subset(ex_data, Owner %in% c("Aperture","Black Mesa")),
  type = "area",
) %>%
  xAxis(type = "addMeasureAxis") %>%
  yAxis(type = "addCategoryAxis", orderRule = "Date")

..p.()# ================================
#example 35 Vertical Stacked Area
dimple(
  x = "UnitSales",
  y = "Month",
  groups = "Channel",
  data = subset(ex_data, Owner %in% c("Aperture","Black Mesa")),
  type = "area",
) %>%
  xAxis(type = "addMeasureAxis") %>%
  yAxis(type = "addCategoryAxis", orderRule = "Date") %>%
  add_legend()

..p.()# ================================
#example 36 Vertical 100% Stacked Area
dimple(
  x = "UnitSales",
  y = "Month",
  groups = "Channel",
  data = subset(ex_data, Owner %in% c("Aperture","Black Mesa")),
  type = "area",
) %>%
  xAxis(type = "addPctAxis") %>%
  yAxis(type = "addCategoryAxis", grouporderRule = "Date") %>%
  add_legend()

..p.()# ================================
#example 37 Vertical Grouped Area
dimple(
  x = "UnitSales",
  y = c("Owner","Month"),
  groups = "Owner",
  data = subset(ex_data, Owner %in% c("Aperture","Black Mesa")),
  type = "area",
  lineWeight = 1,
  barGap = 0.05
) %>%
  xAxis(type = "addMeasureAxis") %>%
  yAxis(type = "addCategoryAxis", grouporderRule = "Date")

..p.()# ================================
#example 38 Vertical Grouped Stacked Area
dimple(
  x = "UnitSales",
  y = c("Owner","Month"),
  groups = "SKU",
  data = subset(ex_data, Owner %in% c("Aperture","Black Mesa")),
  type = "area",
  bounds = list(x=90,y=30,width=320,height=330),
  lineWeight = 1,
  barGap = 0.05,
  height = 450,
  width = 590
) %>%
  xAxis(type = "addMeasureAxis") %>%
  yAxis(type = "addCategoryAxis", grouporderRule = "Date") %>%
  add_legend(
    x = 430,
    y = 20,
    width = 100,
    height = 300,
    horizontalAlign = "left"
  )



..p.()# ================================
#example 39 Vertical Group 100% Area
ex_data %>%
  subset(Owner %in% c("Aperture","Black Mesa")) %>% 
  dimple(
    x = "UnitSales",
    y = c("Owner","Month"),
    groups = "SKU",
    type = "area",
    bounds = list(x=90,y=30,width=320,height=330),
    lineWeight = 1,
    barGap = 0.05,
    height = 450,
    width = 590
) %>%
  xAxis( type = "addPctAxis" ) %>%
  yAxis(type = "addCategoryAxis", grouporderRule = "Date") %>%
  add_legend(
    x = 430,
    y = 20,
    width = 100,
    height = 300,
    horizontalAlign = "left"
  )
  
..p.()# ================================
#example 40 Line
ex_data %>%
  subset(Owner %in% c("Aperture","Black Mesa")) %>%
  dimple(
    UnitSales ~ Month,
    type = "line"
  ) %>%
  xAxis(orderRule = "Date")

..p.()# ================================
#example 41 Multiple Line
ex_data %>%
  subset(Owner %in% c("Aperture","Black Mesa")) %>%
  dimple(
    UnitSales ~ Month,
    groups = "Channel",
    type = "line"
  ) %>%
  xAxis(orderRule = "Date") %>%
  add_legend()

..p.()# ================================
#example 42 Grouped Single Line
ex_data %>%
  subset(Owner %in% c("Aperture","Black Mesa")) %>%
  dimple(
    y = "UnitSales",
    x = c("Owner","Month"),
    groups = "Owner",
    type = "line",
    barGap = 0.05
) %>%
  xAxis(grouporderRule = "Date")


..p.()# ================================
#example 43 Grouped Multiple line
ex_data %>%
  subset(Owner %in% c("Aperture","Black Mesa")) %>%
  dimple(
    y = "UnitSales",
    x = c("Owner","Month"),
    groups = "Brand",
    type = "line",
    bounds = list(x=70,y=30,width=420,height=330),
    barGap = 0.05,
    height = 450,
    width = 590
  ) %>%
  xAxis(grouporderRule = "Date") %>%
  add_legend(
    x = 510,
    y = "10%",
    width = 100,
    height = "60%",
    horizontalAlign = "left"
  )

..p.()# ================================
#example 44 Vertical Line
ex_data %>%
  subset(Owner %in% c("Aperture","Black Mesa")) %>%
  dimple(
    x = "UnitSales",
    y = "Month",
    type = "line"
  ) %>%
  xAxis(type = "addMeasureAxis") %>%
  yAxis(type = "addCategoryAxis", orderRule = "Date")


..p.()# ================================
#example 45 Vertical Multiple Line
ex_data %>% 
  subset(Owner %in% c("Aperture","Black Mesa")) %>%
  dimple(
    x = "UnitSales",
    y = "Month",
    groups = "Channel",
    type = "line",
    bounds = list(x=80,y=30,width=480,height=330),
    height = 450,
    width = 590
  ) %>%
  xAxis(type = "addMeasureAxis") %>%
  yAxis(type = "addCategoryAxis", orderRule = "Date") %>%
  add_legend(
    x = 60,
    y = 10,
    width = 500,
    height = 20,
    horizontalAlign = "right"
  )

..p.()# ================================
#example 46 Vertical Grouped Line
ex_data %>% 
  subset(Owner %in% c("Aperture","Black Mesa")) %>%
  dimple(
    x = "UnitSales",
    y = c("Owner","Month"),
    groups = "Owner",
    type = "line",
    barGap = 0.05,
  ) %>%
  xAxis(type = "addMeasureAxis") %>%
  yAxis(type = "addCategoryAxis", grouporderRule = "Date") 

..p.()# ================================
#example 47 Vertical Grouped Multi Line
ex_data %>% 
  subset(Owner %in% c("Aperture","Black Mesa")) %>%
  dimple(
    x = "UnitSales",
    y = c("Owner","Month"),
    groups = "Brand",
    type = "line",
    bounds = list(x=90,y=30,width=320,height=330),
    barGap = 0.05,
    height = 450,
    width = 590
  ) %>%
  xAxis(type = "addMeasureAxis") %>%
  yAxis(type = "addCategoryAxis", grouporderRule = "Date") %>%
  add_legend(
    x = 430,
    y = 20,
    width = 100,
    height = 300,
    horizontalAlign = "left"
  ) -> d1
d1

#show how to change default_colors
..p.()# ================================
d1 %>% 
  default_colors(latticeExtra::theEconomist.theme()$superpose.line$col)
..p.()# ================================
d1 %>%
  default_colors( terrain.colors(8) )
..p.()# ================================
d1 %>%
  default_colors(RColorBrewer::brewer.pal(n=9,"Blues"))
..p.()# ================================
d1 %>%
  default_colors(htmlwidgets::JS('d3.scale.category20c()'))
..p.()# ================================
d1 %>%
  default_colors(htmlwidgets::JS('d3.scale.category20b()'))
..p.()# ================================
d1 %>%
  default_colors(htmlwidgets::JS('d3.scale.category10()'))

..p.()# ================================
#example 48 timeAxis
data( economics, package = "ggplot2" )
economics$date = format(economics$date, "%Y-%m-%d")
economics %>%
  dimple(
    uempmed ~ date,
    type = "line",
  ) %>%
  xAxis(
    type = "addTimeAxis",
    inputFormat = "%Y-%m-%d",
    outputFormat = "%b %Y",
    timePeriod = htmlwidgets::JS('d3.time.years'),
    timeInterval = 5
  )


#test out additional layer/series functionality
#d1$layer(
#  x = "date",
#  y = "psavert",
#  data = NULL,
#  type = "line"
#)
..p.()# ================================
#example 49 multiple layers qq style plot with 2 datasets
df <- data.frame(
  id = 1:100,
  x=ppoints(100),
  y=sort(rnorm(100)),   #100 random normal distributed points  
  normref=qnorm(ppoints(100))#lattice uses ppoints for the x
)

dimple(
  y ~ x,  #x ~ id for a different look
  groups = c("id","sample"),
  data = df[,c("id","x","y")],  #specify columns to prove diff data
  type = "bubble"
) %>%
  xAxis(type="addMeasureAxis",orderRule="x") -> d1
d1


#now add a layer with a line to represent normal distribution
#! note: this is buggy with Chrome, but works in IE (don't hear that often)
# will eventually add full layer integration for dimple
d1$x$options$layers = list(list(
  x = "x",
  y = "normref",
  groups = c("id","sample"),
  data=df[,c("id","x","normref")],  #specify columns to prove diff data
  type="line"
))
# layers don't line up
# for now to make it work, need overrideMin and overrideMax
d1 %>% 
  yAxis(
    overrideMin = min(df$y), overrideMax = max(df$y), outputFormat = "0.2f"
  ) %>%
  xAxis( overrideMin = 0, overrideMax = 1)



#example50 interpolation options from dimple v2.0.0
#see interpolate optionsfrom d3 docs
#https://github.com/mbostock/d3/wiki/SVG-Shapes
..p.()# ================================
#http://dimplejs.org/examples_viewer.html?id=steps_horizontal_stacked
#var myChart = new dimple.chart(svg, data);
dimple(
  data = subset(ex_data, Owner %in% c("Aperture","Black Mesa")),
  bounds = list(x=60,y=30,width=505,height=305),
  #myChart.set_bounds(60, 30, 505, 305);
  x = "Month",
  #var x = myChart.addCategoryAxis("x", "Month");
  xAxis = list(orderRule = "Date"),
  #x.addOrderRule("Date");
  y = "UnitSales",
  #myChart.addMeasureAxis("y", "Unit Sales");
  type = "line", groups = "Channel",
  #var s = myChart.addSeries("Channel", dimple.plot.line);,
  interpolation = "step",
  #s.interpolation = "step";
  legend = list(
    x = 60,
    y = 10,
    width = 500,
    height = 20,
    horizontalAlign = "right"
  )
  #myChart.add_legend(60, 10, 500, 20, "right");
)
#myChart.draw();
..p.()# ================================
#http://dimplejs.org/examples_viewer.html?id=area_steps_horizontal_grouped_100pct
dimple(
  data = subset(ex_data, Owner %in% c("Aperture","Black Mesa")),
  #var myChart = new dimple.chart(svg, data);
  bounds = list(x=70,y=30,width=340,height=330),
  #myChart.set_bounds(70, 30, 340, 330);
  x = c("Owner","Month"),
  #var x = myChart.addCategoryAxis("x", ["Owner", "Month"]);
  xAxis = list( grouporderRule = "Date" ),
  #x.addGroupOrderRule("Date");
  y = "UnitSales",
  yAxis = list( type = "addPctAxis" ),
  #myChart.addPctAxis("y", "Unit Sales");
  groups = "SKU",
  type = "area",
  #var s = myChart.addSeries("SKU", dimple.plot.area);
  interpolation = "step",
  #s.interpolation = "step";
  lineWeight = 1,
  #s.lineWeight = 1;
  barGap = 0.05,
  #s.barGap = 0.05;
  legend = list(
    x = 430,
    y = 20,
    width = 100,
    height = 300,
    horizontalAlign = "left"
  )
  #myChart.add_legend(430, 20, 100, 300, "left");
)
#myChart.draw();







library(pipeR)
library(htmltools)
library(rCharts2)
library(SVGAnnotation)

data("tips",package="reshape2")

# demo auto aggregate feature/bug
# demonstrate composability while also showing effect of groups,category

tips %>>%
  (data.frame(id = 1:nrow(.), ., tip_pct = .$tip/.$total_bill, group = round(runif(nrow(.)) * 4)) ) %>>%
  dimple(
    tip_pct ~ total_bill,
    groups = c("id","group"),
    type = "bubble",
    height = 250, width = 400
  ) %>>%
  xAxis( type = "addMeasureAxis" ) -> d1

tagList(
  lapply(
    list(
      # so a base plot for reference
      svgPlot({tips %>>%
                 (data.frame(., tip_pct = .$tip/.$total_bill)) %>>%
                 (plot(x=.$total_bill,y=.$tip_pct,pch=16,xlab=NA,ylab=NA)) %>>%
                 (~print)
      },height = 4, width = 4) %>>%  XML::saveXML() %>>% HTML 
      ,tips %>>%
        (data.frame(., tip_pct = .$tip/.$total_bill)) %>>%
        dimple(
          tip_pct ~ total_bill,
          type = "bubble",
          height = 200, width = 400
        ) %>>%
        xAxis( type = "addMeasureAxis") %>>%
        add_title("Only One Dot?")
      
      # demo what happens if we keep categorical x
      ,tips %>>%
        (data.frame(., tip_pct = .$tip/.$total_bill)) %>>%
        dimple(
          tip_pct ~ total_bill,
          type = "bubble",
          height = 200, width = 400
        )%>>%
        add_title("Partial Solve but x Axis Problems and some agg")
      ,d1 %>>% add_title("Use a Unique Id, But Lots of Colors")
      ,tack(d1, options = list(groups = "group") ) %>>% add_title("Use Groups as Feature, Colors Make Sense")
      ,default_colors(d1, list('#00ccff') ) %>>% add_title("Get Points with id all Same Color")
      ,default_colors(tack(d1, options = list(groups = "group")),list("#bb00cc")) %>>% add_title("Get Points with group all Same Color")
    ),function(x){ tags$div(x,style="float:left;") }
  )
) %>>% html_print