#' S3 Method to get  layer
#' 
#' @importFrom lattice latticeParseFormula
#' @keywords internal
#' @noRd
#' @examples
#' getLayer(mpg ~ wt, data = mtcars)
#' getLayer('mpg', 'wt', data = mtcars, color = 'cyl')
#' @export
getLayer <- function(x, ...){
  UseMethod('getLayer')
}

#' @export
getLayer.formula <- function(x, data, ...){
  fml = lattice::latticeParseFormula(x, data = data)
  if (length(fml$left.name) > 0){
    data[[fml$left.name]] = fml$left
  }
  data[[fml$right.name]] = fml$right
  params_ = modifyList(list(...), list(x = fml$right.name,
    y = fml$left.name, data = data, facet = names(fml$condition)                     
  ))
  fixLayer(params_) 
}

#' @export
getLayer.default <- function(x, y, data, ...){
  params_ = list(x = x, y = y, data = data, ...)
  fixLayer(params_)
}

#' Fix an incomplete layer by adding relevant summaries and modifying the data
#' 
#' @keywords internal
#' @noRd
#' 
fixLayer <- function(params_){
  if (length(params_$y) == 0){
    variables = c(params_$x, params_$group)
    params_$data = plyr::count(params_$data, variables[variables != ""])
    params_$y = 'freq'
  }
  return(params_)
}


#' @export
tack <- function(x, ...){
  UseMethod('tack')
}

#' @export
tack.dimple <- function(x, ...){
  x$x = modifyList(x$x, list(...), keep.null=T)
  return(x)
}



`%||%` <- function(x, y){
  if (is.null(x)) y else x
}