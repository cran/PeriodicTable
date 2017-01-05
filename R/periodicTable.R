#' Periodic Table of the Elements
#'
#' A dataset containing chemical element properties.
#'
#' @format A data.frame with the following columns:
#' \describe{
#'   \item{numb}{an integer vector. Atomic numbers.}
#'   \item{symb}{a character vector. Atomic symbols.}
#'   \item{name}{a character vector. Name of chemical elements.}
#'   \item{mass}{a numeric vector. Atomic masses.}
#'   \item{rcov}{a numeric vector. Covalent radii.}
#'   \item{rvdw}{a numeric vector. Van der Waals radii.}
#'   \item{rion}{a numeric vector. Ionic radii.}
#'   \item{red, green, blue}{numeric vectors. rgb colors.}
#'   \item{period}{an integer vector. Element periods.}
#'   \item{group}{an integer vector. Element groups}
#'   \item{type}{a character vector. Element types.}
#'   \item{phase}{a character vector. Most stable crystal.}
#'   \item{crystal}{a character vector. Type of crystalline phases.}
#'   \item{Eneg}{a numerci vector. Electronegativity.}
#'   \item{IP}{a numeric vector. First ionization potential.}
#'   \item{density}{a numeric vector. Densities.}
#'   \item{melting}{a numeric vector. Melting points.}
#'   \item{boiling}{a numeric vector. Boiling points.}
#'   \item{isotopes}{an integer vector. Number of isotopes.}
#'   \item{discoverer}{a character vector. Discoverer names.}
#'   \item{year}{an integer vector. Discovery dates.}
#'   \item{C}{a numeric vector. Heat capacities.}
#'   \item{config}{a character vector. Electronic configurations}
#'   \item{row}{an integer vector. Display rows.}
#'   \item{col}{an integer vector. Display columns.}
#' }
#'
#' @source http://www.data-explorer.com/content/data/periodic-table-of-elements-csv.zip
#' @name periodicTable
"periodicTable"
