#' Create a new ggcyto plot
#'
#' \code{ggcyto()} initializes a ggcyto object that inherits ggplot class.
#' Similarly the + operator can be used to add layers to the
#' existing ggcyto object. 
#'
#' To invoke \code{ggcyto}:
#' \itemize{
#'    \item \code{ggcyto(fs, aes(x, y, <other aesthetics>))}
#'   }
#' @export
#' @keywords internal
#' @param data default cytometry data set.(flowSet,flowFrame)
#' @param ... other arguments passed to specific methods
#' @examples
#' 
#' #construct the `ggcyto` object (inherits from `ggplot` class)
#' p <- ggcyto(fs, aes(x = `FSC-H`)) 
#' p + geom_histogram() 
#'
#' # display density/area
#' p + geom_density()
#' p + geom_area(stat = "density") 
#' 
#' # 2d scatter plot
#' p <- ggcyto(fs, aes(x = `FSC-H`, y =  `SSC-H`))
#' p + stat_binhex(bin = 128)
ggcyto <- function(data = NULL, ...) UseMethod("ggcyto")

#' Reports whether x is a ggcyto object
#' @param x An object to test
#' @export
is.ggcyto <- function(x) inherits(x, "ggcyto")

#' @export
ggcyto.default <- function(data = NULL, mapping = aes(), ...) {
  ggcyto.flowSet(fortify_fs(data, ...), mapping)
}

#' Draw ggcyto on current graphics device.
#'
#' A wrapper for print.ggplot. 
#' @param x ggcyto object to display
#' @param ... other arguments not used by this method
#' @export
#' @method print ggcyto
print.ggcyto <- function(x, ...) {
  
    #fortify plot data here instead
    x <- as.ggplot(x)
    ggplot2:::print.ggplot(x)
}

#' It simply fortifies data and return a regular ggplot object.
#' 
#' The orginal data format is preserved during the ggcyo constructor because they still need to be used during the plot building process.
#' 
#' @param x ggcyto object with the data that has not yet been fortified to data.frame.
#' 
#' @export
as.ggplot <- function(x){
#   browser()
  x$data <- fortify(x$data)
  x
}
#' @rdname print.ggcyto
#' @method plot ggcyto
#' @export
plot.ggcyto <- print.ggcyto