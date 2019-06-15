## Longest common prefix of a given vector of strings.
##
## @param ss a vector of strings
## @return the longest common prefix (string)
longest_common_prefix <- function(ss) {
    if (is.null(ss))
        stop("no elements found")

    prefix <- ""
    repeat {
        heads <- stringr::str_sub(ss, end = 1)
        if (any(heads == "") || any(heads[1] != heads))
            return(prefix)
        prefix <- paste0(prefix, heads[1])
        ss <- stringr::str_sub(ss, start = 2)
    }
}

## Make a map from keys to values.
##
## @param keys a vector of keys
## @param values a vector of values
## @return a list which maps keys to values
make_map <- function(keys, values) {
    map <- list()
    purrr::walk2(keys, values,
        function(key, value) {
            map[[key]] <<- value
        })
    map
}

## Group numbers to sequential subsets.
##
## @param ns a vector of numbers
## @return a list of vectors, each of which contains a subset of the given
##         numbers. In each subset, numbers are monotonically increasing by
##         one.
group_seq <- function(ns) {
    if (is.null(ns))
        return(list())

    ns <- sort(ns)
    purrr::reduce(ns[-1], .init = list(ns[1]),
        .f = function(subsets, i) {
                 l <- length(subsets)
                 last_subset <- subsets[[l]]
                 if (i <= tail(last_subset, n = 1) + 1)
                     subsets[[l]] <- c(last_subset, i)
                 else
                     subsets <- c(subsets, i)
                 subsets
             })
}
