## Guess common prefix in a given vector of strings.
guess_prefix <- function(ss) {
    if (is.null(ss))
        stop("no elements found")

    go <- function(prefix, ss) {
        heads <- stringr::str_sub(ss, end = 1)
        if ( any(heads == "") || any(heads[1] != heads) )
            prefix
        else
            go(paste0(prefix, heads[1]), stringr::str_sub(ss, 2))
    }
    result <- go("", ss)

    numeral_in_tail <- stringr::str_extract(result, "\\d+$")
    if (is.na(numeral_in_tail))
        result
    else
        stringr::str_remove(result, paste0(numeral_in_tail, "$"))
}

#' Compress continuous parts in a vector of prefixed numbers.
#'
#' @param xs a vector of prefixed numbers (character strings)
#' @param sep a character string to represent continuation
#' @return a vector of prefixed numbers in which continuous parts are
#'         compressed (character strings)
#' @export
#' @importFrom purrr %>%
#' @examples
#' compress(c("a1", "a2", "a3", "a5", "a6")) #=> c("a1--3", "a5", "a6")
#' compress(c("a1", "a2", "a3"), sep = "-") #=> "a1-3"
compress <- function(xs, sep = "--") {
    prefix <- guess_prefix(xs)
    suffixes <- stringr::str_remove(xs, paste0("^", prefix))
    suffixes <- unique(suffixes)

    if (!all(stringr::str_detect(suffixes, "^\\d+$")))
        stop("other than numbers found in suffixes")

    ix <- as.integer(suffixes)

    if (length(unique(ix)) != length(ix))
        stop("duplicated numbers in suffixes")

    map <- list()
    for (i in seq_along(ix))
        map[[ix[i]]] <- suffixes[[i]]

    if (length(ix) < 2)
        return(paste0(prefix, map[[ix]]))

    ix <- sort(ix)
    purrr::reduce(ix[2:length(ix)], .init = list(ix[1]), .f = function(acc, i) {
        last <- length(acc)
        if (i <= acc[[last]][length(acc[[last]])] + 1)
            acc[[last]] <- c(acc[[last]], i)
        else
            acc <- c(acc, i)
        acc
    }) %>% purrr::map(function(part) {
        if (length(part) <= 2)
            map[part]
        else
            list(paste0(map[[part[1]]], sep, map[[part[length(part)]]]))
    }) %>% unlist(do.call(c, .)) %>%
    paste0(prefix, .)
}
