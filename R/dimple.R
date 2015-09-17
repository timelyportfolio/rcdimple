#' Plot R data with dimple
#' 
#' Use \href{http://dimplejs.org}{Dimple} with this \code{htmlwidget}.  Dimple is a powerful javascript library
#'  based on \href{http://d3js.org}{d3.js}.  Dimple supports numerous chart \href{http://dimplejs.org/examples_index.html}{types} and is
#'  well \href{https://github.com/PMSI-AlignAlytics/dimple/wiki}{documented}.
#'
#' @param data a \code{\link[base]{data.frame}} with the data to plot
#' @param x formula \code{y ~ x} or column name(s) of \code{x} variable.  Dimple can accept either a single or multiple column name(s)
#'   as \code{x} or \code{y}.  If multiple column names for either \code{x} or \code{y}, then the formula method cannot be used.
#' @param y column name(s) of \code{y} variable if \code{x} is not a \code{formula}.  Dimple can accept either a single or multiple column name(s)
#'   as \code{y} or \code{y}.  If multiple column names for either \code{x} or \code{y}, then the formula method cannot be used.
#' @param group column name(s) of \code{groups}.  Dimple differs from other \code{rCharts2} libraries
#'   in its ability to handle multiple fields or column names as \code{groups}.
#' @param groups see \code{group}
#' @param type a string indicating plot type ( \href{http://github.com/PMSI-AlignAlytics/dimple/wiki/dimple.plot}{bar, line, area, or bubble} ) 
#' @param storyboard column name(s) with data for \href{https://github.com/PMSI-AlignAlytics/dimple/wiki/dimple.storyboard}{dimple.storyboard}
#' @param ... various additional arguments to future-proof and provide
#'          undocumented functionality.
#' @param pipe \code{logical} to return a \code{\link[pipeR]{Pipe}}.
#' @param width width in pixels of the plot container.  Plot \code{width} can be set separately (see \code{\link{setBounds}}).
#' @param height height in pixels of the plot container.  Plot \code{height} can be set separately (see \code{\link{setBounds}}).
#' @param elementId \code{string} css selector id for the chart.  If the \code{elementId} is \code{NULL}, 
#'           a semi-random id will be assigned.
#' 
#' @family dimple
#' @export
#' @import htmltools
#' @import htmlwidgets
dimple <- function( data, x, type = "bubble"
  , y = NULL, z = NULL, p = NULL, groups = NULL, group = NULL, storyboard = NULL
  , ...
  , pipe = F, width = NULL, height = NULL, elementId = NULL) {
  
    # set up defaults for missing params
    options = list(
      chart = list(),
      xAxis = list(type="addCategoryAxis"),
      yAxis = list(type="addMeasureAxis"),
      zAxis = if(is.null(z)) { list() } else { list(type = "addMeasureAxis") },
      pAxis = if(is.null(p)) { list() } else { list(type = "addMeasureAxis") },
      colorAxis = list(),
      defaultColors = list(),
      layers = list(),
      legend = list()
    )
    
    # now we will use the args to override the defaults
    # specified above
    options = modifyList(
      options
      , getLayer(x = x, y = y, data = data, type = type, 
         groups = groups %||% group, z = z, p = p, storyboard = storyboard, ...
    ))
    
    options$data <- NULL
    
    d <- htmlwidgets::createWidget('dimple', list(options = options, data = data), 
        width = width, height = height
       , package = 'rcdimple'
       , elementId = elementId
    )
    if (pipe) pipeR::Pipe(d) else d
}

#' Modify plot elements that relate to the x-axis.
#' 
#' This is an S3 method.
#' @family xAxis
#' @export
xAxis <- function(x, ...){
  UseMethod('xAxis')
}

#' Modify plot elements that relate to the x and y axes of a dimple chart
#'
#' \code{xAxis}, \code{yAxis}, \code{zAxis} configure the x, y, and z axis properties of the chart.
#' In most cases, parameters closely match those of \href{https://github.com/PMSI-AlignAlytics/dimple/wiki/dimple.axis}{dimple.axis}.
#' 
#' @param type "addMeasureAxis", "addCategoryAxis", "addTimeAxis", or "addPctAxis"
#' @param orderRule defines how to sort a categorical axis.  \code{orderRule} can either be a field name as a string or a vector of values in the desired order.
#'          \code{desc} is by default \code{FALSE}.  To change \code{desc} to true, use a list for this argument in the following form
#'          \code{list(ordering = "SalesValue", desc = TRUE)}.
#' @param grouporderRule defines how to the values in a group.  \code{orderRule} can either be a field name as a string or a vector of values in the desired order.
#'          \code{desc} is by default \code{FALSE}.  To change \code{desc} to true, use a list for this argument in the following form
#'          \code{list(ordering = "SalesValue", desc = TRUE)}.
#' @param overrideMin manually specify a minimum axis value.  See \href{https://github.com/PMSI-AlignAlytics/dimple/wiki/dimple.axis#overrideMin}{dimple.axis.overrrideMin}.
#' @param overrideMax manually specify a maximum axis value.  See \href{https://github.com/PMSI-AlignAlytics/dimple/wiki/dimple.axis#overrideMax}{dimple.axis.overrrideMax}.
#' @param inputFormat the d3 time format of the values in a field if an axis is \code{addTimeAxis}.  See \href{https://github.com/PMSI-AlignAlytics/dimple/wiki/dimple.axis#dateParseFormat}{dimple.axis.dateParseFormat}.
#' @param outputFormat the d3 format of an axis.  See \href{https://github.com/PMSI-AlignAlytics/dimple/wiki/dimple.axis#tickFormat}{dimple.axis.tickFormat}.
#' @param timePeriod for time axis periodicity of ticks. See \href{https://github.com/PMSI-AlignAlytics/dimple/wiki/dimple.axis#timePeriod}{dimple.axis.timePeriod}.
#' @param timeInterval for time axis number of periods between ticks.  See \href{https://github.com/PMSI-AlignAlytics/dimple/wiki/dimple.axis#timeInterval}{dimple.axis.timeInterval}.
#' @param fontSize for font size of axis.  Any valid CSS \code{font-size} will work.
#' @param fontFamily for font size of axis.  Any valid CSS \code{font-family} will work.
#' @param useLog for logarithmic axis.
#' @param logBase for base of log if axis is logarithmic \code{useLog = TRUE}.
#' @param ... other properties for dimple axis.  See \href{https://github.com/PMSI-AlignAlytics/dimple/wiki/dimple.axis#properties-1}{Properties}.
#' 
#' @family dimple
#' @family axis
#'
#' @export
xAxis.dimple <- function(viz, ...){
  viz$x$options$xAxis = modifyList(viz$x$options$xAxis, list(...))
  return(viz)
}

#' Modify plot elements that relate to the x-axis.
#' 
#' This is an S3 method.
#' @family axis
#' @export
yAxis <- function(x, ...){
  UseMethod('yAxis')
}

#' @rdname xAxis.dimple
#' @export
yAxis.dimple <- function(viz, ...){
  viz$x$options$yAxis = modifyList(viz$x$options$yAxis, list(...))
  return(viz)
}

#' Modify plot elements that relate to the z-axis.
#' 
#' This is an S3 method.
#' @family axis
#' @export
zAxis <- function(x, ...){
  UseMethod('zAxis')
}

#' @rdname xAxis.dimple
#' @export
zAxis.dimple <- function(viz, ...){
  viz$x$options$zAxis = modifyList(viz$x$options$zAxis, list(...))
  return(viz)
}

#' Modify plot elements that relate to the p-axis.
#' 
#' This is an S3 method.
#' @family axis
#' @export
pAxis <- function(x, ...){
  UseMethod('pAxis')
}

#' @rdname xAxis.dimple
#' @export
pAxis.dimple <- function(viz, ...){
  viz$x$options$pAxis = modifyList(viz$x$options$pAxis, list(...))
  return(viz)
}


#' @family dimple
#' @family axis
#' @export
colorAxis = function(viz, ...){
  viz$x$options$colorAxis = list(...)
  return(viz)
}


#' Add a legend to a dimple chart
#' 
#' Parameters provided should match those for \href{https://github.com/PMSI-AlignAlytics/dimple/wiki/dimple.legend}{dimple.legend constructor}.
#'   If incomplete parameters are provided then some sane defaults will be applied.
#' @param x
#' @param y
#' @param width
#' @param height
#' @param horizontalAlign
#' 
#' @examples
#' dimple( weight ~ Time, groups = "Diet" , type = "line", data = ChickWeight, width = 600, height = 400 ) %>%
#'   add_legend( )
#'   
#' dimple( weight ~ Time, groups = "Diet" , type = "line", data = ChickWeight, width = 600, height = 400 ) %>%
#'   add_legend( x = 50, y = 390, width = 500, horizontalAlign = "right" )
#' 
#' @family dimple
#' @family legend
#' 
#' @export
add_legend <- function(viz, ...){
  # set some sane defaults so use modifyList
  viz$x$options$legend = modifyList(
    list(
      x = '45%'
      ,y = '0'
      ,width = '45%'
      ,height = '10%'
      ,horizontalAlign = "right"
    )
    , list(...)
  )
  return(viz)
}

#' Modify colors used in Dimple charts
#' 
#' @param viz a dimple object
#' @param colors a vector of colors in hex or a \code{\link[htmlwidgets]{JS}} function, such as a \href{https://github.com/mbostock/d3/wiki/Ordinal-Scales#categorical-colors}{d3 color scale}.
#' 
#' @examples
#' ChickWeight %>%
#'   dimple( x = c("Time", "Diet"), y = "weight", groups = "Diet", type = "bar" ) %>%
#'   defaultColors( rainbow(10) )
#'   
#' ChickWeight %>%
#'   dimple( x = c("Time", "Diet"), y = "weight", groups = "Diet", type = "bar" ) %>%
#'   defaultColors( htmlwidgets::JS( 'd3.scale.category10()' ) )
#'   
#'
#' @family dimple
#' @export
default_colors = function(viz, ...){
  viz$x$options$defaultColors = list(...)
  return(viz)
}

#' Modify plot elements that relate to the x-axis.
#' 
#' This is an S3 method.
#' @export
facet <- function(...){
  UseMethod('facet')
}

#' Add facets to a Dimple chart
#' @family dimple
#' @export
facet.dimple <- function(viz, x = NULL, y = NULL, removeAxes = F){
  viz$x$options$facet = list( x = x, y = y, removeAxes = removeAxes )
  return(viz)
}

#' Set the \href{https://github.com/PMSI-AlignAlytics/dimple/wiki/dimple.chart#setBounds}{bounds} or size of the chart within the svg container.
#' 
#' The chart size can be set independently from the size of the containing node.
#' 
#' @param viz a dimple object
#' @param x value in pixels where the chart starts on the left
#' @param y value in pixels where the chart starts on the bottom
#' @param width value in pixels of the width of chart.  Note this is not
#'  the right edge.  Rather the right edge will be x + width.
#' @param height height value in pixels of the height of chart.  Note this is
#'  not the top.  Rather the top will be y + height.
#'  
#' @examples
#' ChickWeight %>%
#'   dimple( weight ~ Time, groups = "Diet", type = "bubble", width = 600, height = 600 ) %>%
#'   setBounds( x = 200, y = 100, width = 250, height = 300 )
#' 
#' @family dimple
#' @export
set_bounds <- function( viz, x, y, width, height ){
  viz$x$options$bounds = list( x = x, y = y, width = width, height = height )
  return(viz)
}

#' Add a title to your chart
#'
#' @param viz \code{rCharts2} chart to which you would like to add a title
#' @param text \code{string} of text to provide in the title
#' @param html \code{string} of html for your title.  Providing \code{html} instead of
#'                \code{text} to the title allows the potential to custom format your
#'                title or provide multiple lines.
#' @param ... other arguments for consistency with \code{rCharts2} methods.
#' 
#' @family dimple
#' @export
add_title <- function(viz, text = NULL, html = NULL, ...){
  viz$x$options$title = list(text = text, html = html, ...)
  return(viz)
}

#' Add a series to your dimple chart
#' @param viz \code{rCharts2} chart to which you would like to add a series
#' 
#' @export
add_series <- function(viz, ...)
{
  viz$x$options$layers[[length(viz$x$options$layers) + 1]] <- list(...)
  return(viz)
}

#' @export
dimpleOutput <- function(outputId, width = "100%", height = "500px"){
  htmlwidgets::shinyWidgetOutput(outputId, "dimple", width, height, package = 'rcdimple')
}

#' @export
renderDimple <- function(expr, env = parent.frame(), quoted = FALSE){
  if (!quoted){expr <- substitute(expr)}
  htmlwidgets::shinyRenderWidget(expr, dimpleOutput, env, quoted = TRUE)
}

