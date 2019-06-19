#' Compress sequential parts in a vector of prefixed numbers.
#'
#' @param xs a vector of prefixed numbers (character strings)
#' @param sep a character string to represent sequencial prefixed numbers
#' @param level sequencial parts of length longer than or equal to `level` are
#'        compressed
#' @return a vector of prefixed numbers in which sequential parts are
#'         compressed (character strings)
#' @export
#' @importFrom purrr %>%
#' @examples
#' compress(c("a1", "a2", "a3", "a5", "a6")) #=> c("a1--3", "a5", "a6")
#' compress(c("a1", "a2", "a3"), sep = "-") #=> "a1-3"
#' compress(c("a1", "a2", "a3", "a5", "a6"), level = 2) #=> c("a1--3", "a5--6")
compress <- function(xs, sep = "--", level = 3) {
    prefix <- guess_prefix(xs)
    suffixes <- stringr::str_remove(xs, paste0("^", prefix)) %>%
        unique

    if (!all(stringr::str_detect(suffixes, "^\\d+$")))
        stop("other than numbers found in suffixes")

    ix <- as.integer(suffixes)

    if (length(unique(ix)) != length(ix))
        stop("duplicated numbers in suffixes")

    map <- make_map(ix, suffixes)

    if (length(ix) < 2)
        return(paste0(prefix, map[[ix]]))

    group_seq(ix) %>%
        purrr::map(function(group) {
                       l <- length(group)
                       if (l < level)
                           map[group]
                       else
                           list(paste0(map[[group[1]]], sep, map[[group[l]]]))
                   }) %>%
        unlist(purrr::flatten(.)) %>%
        paste0(prefix, .)
}
