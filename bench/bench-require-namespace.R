loadNamespace("scribe")

TIMES <- 100

do <- function(package) {
  if (!isNamespaceLoaded(package)) {
    on.exit(unloadNamespace(package), add = TRUE)
  }
  system.time(requireNamespace(package, versionCheck = list(">=", "0.0.1")))
}

base <- suppressPackageStartupMessages(replicate(TIMES, do("scribe")))
# fuj <- replicate(100, system.time(require_namespace("scribe >= 0.0.1")))
fuj <- replicate(
  TIMES,
  system.time(require_namespace(list("scribe", ">=", "0.0.1")))
)

my_summary <- function(x) {
  c(
    mean = mean(x),
    trimmed = mean(x, trim = 0.1),
    median = median(x),
    min = min(x),
    max = max(x)
  )
}

apply(base, 1, my_summary) - apply(fuj, 1, my_summary)

data.frame(
  version = rep(c("base", "fuj"), each = TIMES),
  time = c(base["elapsed", ], fuj["elapsed", ])
) |>
  ggplot2::ggplot(ggplot2::aes(y = version, x = time, col = version)) +
  ggbeeswarm::geom_beeswarm(
    orientation = "y",
  ) +
  # ggplot2::coord_transform(x = "log10") +
  ggplot2::labs()
