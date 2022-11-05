#' Extract and replace aliases
#'
#' @name alias_extract
#' @return See [base::Extract]
#' @examples
#' df <- quick_dfl(a = 1:5, b = 6:10)
#' # alias of `[`
#' subset1(df, 1)
#' subset1(df, 1, )
#' subset1(df, , 1)
#' subset1(df, , 1, drop = FALSE)
#'
#' # alias of `[[`
#' subset2(df, 1)
#' subset2(df, 1, 2)
#'
#' # alias of `$`
#' subset3(df, a)
#' subset3(df, "b")
#' subset3(df, "foo")
#'
#' # alias of `[<-`
#' subassign1(df, "a", , 2)
NULL

#' @export
#' @rdname alias_extract
#' @usage NULL
subset1 <- `[`

#' @export
#' @rdname alias_extract
#' @usage NULL
subset2 <- `[[`

#' @export
#' @rdname alias_extract
#' @usage NULL
subset3 <- `$`

#' @export
#' @rdname alias_extract
#' @usage NULL
subassign1 <- `[<-`

#' @export
#' @rdname alias_extract
#' @usage NULL
subassign2 <- `[[<-`

#' @export
#' @rdname alias_extract
#' @usage NULL
subassign3 <- `$<-`
