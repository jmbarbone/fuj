#' Extract and replace aliases
#'
#' @name alias_extract
#' @return See [base::Extract]
NULL

#' @export
#' @rdname alias_extract
subset1 <- `[`

#' @export
#' @rdname alias_extract
subset2 <- `[[`

#' @export
#' @rdname alias_extract
subset2 <- `$`

#' @export
#' @rdname alias_extract
subassign1 <- `[<-`

#' @export
#' @rdname alias_extract
subassign2 <- `[[<-`

#' @export
#' @rdname alias_extract
subassign3 <- `$<-`
