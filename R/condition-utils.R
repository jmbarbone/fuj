# unepxorted helper conditions

cond_internal_switch <- function() {
  s <- sys.call()
  switches <- as.list(str2lang(as.character(attr(s, "srcref"))))
  selected <- switches[[2]]
  provided <- names(switches)
  provided <- provided[provided != ""]

  new_condition(
    msg = sprintf(
      "internalSwitch value [%s] does not match provided values [%s]",
      collapse(selected, sep = ", "),
      collapse(provided, sep = ", ")
    ),
    class = "internal_switch"
  )
}
