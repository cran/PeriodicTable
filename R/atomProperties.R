#' Atomic Properties
#'
#' Determine atomic properties from atomic symbols, atomic numbers or atom
#' names.
#'
#' The functions documented here allow to get atomic properties, such as atomic
#' masses (\code{mass}), covalent radii (\code{rcov}), Van der Waals radii
#' (\code{rvdw}) and atom colors (\code{atomColor}), from atomic symbols, atomic
#' numbers or atom names.
#'
#' The methods for atomic number (integer or numeric values) and atom names
#' (character strings) first convert the values into atomic symbols (see
#' \code{\link{symb}}) and then match them with the \code{\link{periodicTable}}
#' dataset to determine the properties.
#'
#' @return Return a vector containing atomic properties.
#'
#' @seealso \code{\link{periodicTable}}, \code{\link{atomRecognition}},
#'   \code{\link{match}}
#'
#' @examples
#' # Display all chemical element properties
#' data(periodicTable)
#' periodicTable
#'
#' # From atomic symbols
#' mass(c("C","O","H"))
#' rcov(c("C","O","H"))
#' rvdw(c("C","O","H"))
#' atomColor(c("C","O","H"))
#'
#' # From atomic numbers
#' mass(c(6, 8, 1))
#' rcov(c(6, 8, 1))
#' rvdw(c(6, 8, 1))
#' atomColor(c(6, 8, 1))
#'
#' # From atom names
#' mass(c("CA","OD","H"))
#' rcov(c("CA","OD","H"))
#' rvdw(c("CA","OD","H"))
#' atomColor(c("CA","OD","H"))
#'
#' @keywords utilities
#'
#' @name atomProperties
#' @export
#' @param x an R object for which to get atomic properties.
mass <- function(x)
  UseMethod("mass")

#' @noRd
#' @export
mass.default <- function(x){
  m <- periodicTable$mass[match(symb(x), periodicTable$symb)]
  structure(m, dim = dim(x))
}

#' @rdname atomProperties
#' @export
rcov <- function(x)
  UseMethod("rcov")

#' @noRd
#' @export
rcov.default <- function(x){
  m <- periodicTable$rcov[match(symb(x), periodicTable$symb)]
  structure(m, dim = dim(x))
}

#' @rdname atomProperties
#' @export
rvdw <- function(x)
  UseMethod("rvdw")

#' @noRd
#' @export
rvdw.default <- function(x){
  m <- periodicTable$rvdw[match(symb(x), periodicTable$symb)]
  structure(m, dim = dim(x))
}

#' @rdname atomProperties
#' @export
atomColor <- function(x)
  UseMethod("atomColor")

#' @noRd
#' @export
atomColor.default <- function(x){
  m <- periodicTable$color[match(symb(x), periodicTable$symb)]
  structure(m, dim = dim(x))
}
