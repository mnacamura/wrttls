## Common prefix of a given vector of strings without decimals in its tail.
##
## @param ss a vector of strings
## @return the common prefix without decimals in its tail (string)
guess_prefix <- function(ss) {
    prefix <- longest_common_prefix(ss)
    dec_in_tail <- stringr::str_extract(prefix, "\\d+$")
    if (is.na(dec_in_tail))
        prefix
    else
        stringr::str_remove(prefix, paste0(dec_in_tail, "$"))
}

#' Compress sequential parts in a vector of prefixed numbers.
#'
#' @param xs a vector of prefixed numbers (character strings)
#' @param sep a character string to represent sequencial prefixed numbers
#' @return a vector of prefixed numbers in which sequential parts are
#'         compressed (character strings)
#' @export
#' @importFrom purrr %>%
#' @examples
#' compress(c("a1", "a2", "a3", "a5", "a6")) #=> c("a1--3", "a5", "a6")
#' compress(c("a1", "a2", "a3"), sep = "-") #=> "a1-3"
compress <- function(xs, sep = "--") {
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
                       if (l <= 2)
                           map[group]
                       else
                           list(paste0(map[[group[1]]], sep, map[[group[l]]]))
                   }) %>%
        unlist(purrr::flatten(.)) %>%
        paste0(prefix, .)
}
