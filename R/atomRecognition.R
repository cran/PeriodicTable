#' Atom Recognition
#'
#' Determine atomic symbols from atom names or atomic numbers.
#'
#' In some files, atom names/types are specified instead of atomic symbols. It
#' is then useful to convert atom names/types into atomic symbols. The
#' \code{symb} function allow to perform this convertion by using the
#' \code{\link{atomNames}} and \code{\link{periodicTable}} data sets.
#'
#' Atom recognition from character vector is performed as follow: \itemize{
#' \item Remove numbers from character strings. \item Search for matching atom
#' types in \code{\link{atomNames}} dataset. \item Truncate to first character
#' and translate to upper case. \item Search for matching atomic symbols in
#' \code{\link{periodicTable}} dataset. \item Unrecognized atoms are considered as
#' dummy atoms (\code{"Xx"}).}
#'
#' Function \code{symb} can also convert atomic numbers into atomic symbols.
#' Atomic numbers are first checked to be whole numbers and then searched into
#' the \code{\link{periodicTable}} dataset to determine atomic symbols.
#'
#' Function \code{areSymb} can be used to check if the values in a vector are
#' atomic symbols.\cr Function \code{isSymb} can be used to check if all the
#' values in a vector are atomic symbols.
#'
#' @return \code{symb} returns a character vector containing atomic symbols.
#'   \code{areSymb} returns a logical vector. \code{isSymb} returns TRUE if
#'   \code{x} contains only atomic symbols or \code{FALSE} otherwise.
#'
#' @seealso \code{\link{atomNames}}, \code{\link{periodicTable}},
#'   \code{\link{atomProperties}}, \code{\link[base]{match}}
#'
#' @examples
#' # Display atomNames
#' data(atomNames)
#' atomNames
#'
#' # Get atomic symbols from atom names
#' symb(c("CA", "CB", "N", "NZ", "OXT"))
#'
#' # Get atomic symbols from atomic numbers
#' symb(1:4)
#'
#' @keywords utilities
#'
#' @name atomRecognition
#' @export
#'
#' @param x an R object for which to determine atomic symbols or to be tested.
#' @param na.as.dummy a logical value. Whether to consider \code{NA} values as
#'   dummy atoms or not.
symb <- function(x, na.as.dummy = FALSE)
  UseMethod("symb")

#' @noRd
#' @export
symb.character <- function(x, na.as.dummy = FALSE){
  toSymb <- function(x)
    atomNames$symb[match(x, atomNames$atmtype)]

  if(na.as.dummy)
    x[is.na(x)] <- "Xx"

  s <- gsub("[0-9]", "", x)
  are.unk <- !areSymb(s, na.action = TRUE)
  s[are.unk] <- toSymb(s[are.unk])
  #
  #   are.unk <- is.na(s)
  #   s[are.unk] <- toupper(substr(x[are.unk], 1, 3))
  #
  #   are.unk <- is.na(s)
  #   s[are.unk] <- toupper(substr(x[are.unk], 1, 2))

  are.unk <- is.na(s) & !is.na(x)
  s[are.unk] <- toupper(substr(x[are.unk], 1, 1))

  are.unk <- !areSymb(s, na.action = TRUE)
  if(any(are.unk[!is.na(x)])) {
    warning("Unrecognized atoms have been considered as dummy atoms ('Xx'): ",
            paste(unique(x[are.unk]), collapse = ", "))
    s[are.unk] <- "Xx"
  }
  structure(s, dim = dim(x))
}

#' @noRd
#' @export
symb.factor <- function(x, na.as.dummy = FALSE){
  symb(as.character(x), na.as.dummy = na.as.dummy)
}

#' @noRd
#' @export
symb.integer <- function(x, na.as.dummy = FALSE){
  if(na.as.dummy)
    x[is.na(x)] <- 0L
  out <- (x < 0L) | (x > 117L)
  if(any(out, na.rm = TRUE)){
    warning("Unrecognized atoms have been considered as dummy atoms ('Xx'): ",
            paste(unique(x[out]), collapse = ", "))
    x[out] <- 0L
  }

  s <- match(x, periodicTable$num)
  s[!is.na(s)] <- periodicTable$symb[s[!is.na(s)]]

  structure(s, dim = dim(x))
}

#' @noRd
#' @export
symb.numeric <- function(x, na.as.dummy = FALSE){
  if(!all(x == as.integer(x), na.rm = TRUE))
    stop("'x' must contain atomic numbers (whole numbers)")
  symb(as.integer(x), na.as.dummy = na.as.dummy)
}

#' @noRd
#' @export
symb.logical <- function(x, na.as.dummy = FALSE){
  # symb.integer(rep(NA_integer_, length(x)), na.as.dummy = na.as.dummy)
  x[is.na(x)] <- na.as.dummy
  ifelse(x, yes = "Xx", no = NA)
}

#' @rdname atomRecognition
#' @export
#' @param na.action a logical value or \code{NA}. \code{NA} values will be set to this value.
areSymb <- function(x, na.action = FALSE){
  M <- x %in% periodicTable$symb
  M[is.na(x)] <- na.action
  structure(M, dim = dim(x))
}

#' @rdname atomRecognition
#' @export
isSymb <- function(x, na.action = FALSE){
  all(areSymb(x, na.action = na.action))
}
