#' Enumerate elements inline.
#'
#' @param xs a vector of elements to be enumerated
#' @param sep a character string to separate the elements
#' @return a character string enumerating the elements
#' @export
#' @examples
#' enum_inline(1:2) #=> "1 and 2"
#' enum_inline(1:3) #=> "1, 2, and 3"
#' enum_inline(1:3, sep = ";") #=> "1; 2; and 3"
enum_inline <- function(xs, sep = ",") {
    n <- length(xs)
    if (n == 0)
        ""
    else if (n == 1)
        paste0(xs)
    else if (n == 2)
        paste(xs[1], "and", xs[2])
    else {
        xs_ <- do.call(paste, c(xs[seq(n-1)], list(sep = paste0(sep, " "))))
        do.call(paste, c(xs_, xs[n], list(sep = paste0(sep, " and "))))
    }
}

#' Enumerate elements in a bullet list.
#'
#' @param xs a vector of elements to be enumerated
#' @param bullet a character string to be used as bullet points
#' @return a character string enumerating the elements in a bullet list
#' @export
#' @examples
#' enum_bullet(1:3) #=> "- 1\n- 2\n- 3"
#' enum_bullet(1:3, bullet = "*") #=> "* 1\n* 2\n* 3"
enum_bullet <- function(xs, bullet = "-") {
    n <- length(xs)
    if (n == 0)
        ""
    else
        do.call(paste, c(paste(bullet, xs), list(sep = "\n")))
}

#' Enumerate elements in a numbered list.
#'
#' @param xs a vector of elements to be enumerated
#' @param init initial number to begin enumeration
#' @return a character string enumerating the elements in a numbered list
#' @export
#' @examples
#' enum_numbered(1:3) #=> "1. 1\n2. 2\n3. 3"
#' enum_numbered(1:3, init = 10) #=> "10. 1\n11. 2\n12. 3"
enum_numbered <- function(xs, init = 1) {
    n <- length(xs)
    if (n == 0)
        ""
    else {
        ix <- format(paste0(init - 1 + seq_along(xs), "."))
        do.call(paste, c(paste(ix, xs), list(sep = "\n")))
    }
}

#' Enumerate elements inline, in bullet-list, or in numbered-list form.
#'
#' This is a wrapper for functions `enum_inline`, `enum_bullet`, and
#' `enum_numbered`. If `bullet` or `init` option is neither `NULL` nor
#' `FALSE`, then it generates a bullet list or a numbered list appropriately.
#' Otherwise, it enumerates the elements inline.
#' If both `bullet` and `init` options are neither `NULL` nor `FALSE`, a
#' numbered list precedes a bullet list.
#'
#' @param xs a vector of elements to be enumerated
#' @param sep a character string to separate the elements if inline
#' @param bullet possibly bool or a character string. If `TRUE`, returns a
#'        bullet list with default bullet points. If a character string is
#'        given, uses the string as bullet points.
#' @param init possibly bool or a number. If `TRUE`, returns a numbered list
#'        with default numbers. If a number is given, uses the number to start
#'        enumeration with.
#' @return a character string enumerating the elements
#' @export
#' @examples
#' enum(1:3) #=> "1, 2, and 3"
#' enum(1:3, bullet = TRUE) #=> "- 1\n- 2\n- 3"
#' enum(1:3, init = 2) #=> "2. 1\n3. 2\n4. 3"
enum <- function(xs, sep = ",", bullet = NULL, init = NULL) {
    if (is.logical(init) && init)
        return(enum_numbered(xs))

    if (!is.null(init) && !is.logical(init))
        return(enum_numbered(xs, init))

    if (is.logical(bullet) && bullet)
        return(enum_bullet(xs))

    if (!is.null(bullet) && !is.logical(bullet))
        return(enum_bullet(xs, bullet))

    enum_inline(xs, sep)
}
