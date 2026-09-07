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

all_packages <- available.packages()
packages <- sample(
  c(rownames(all_packages), as.character(OlsonNames())),
  TIMES * 100,
  TRUE
)
versions <- sample(
  unname(as.package_version(all_packages[, "Version"])),
  TIMES * 100,
  TRUE
)
ops <- sample(c(">", ">=", "==", "<=", "<", "!="), TIMES * 100, TRUE)

res <- bench::press(
  .grid = data.frame(
    package = packages,
    op = ops,
    version = versions
  ),
  .quiet = TRUE,
  bench::mark(
    base = requireNamespace(
      package,
      versionCheck = list(op, version),
      quietly = TRUE
    ),
    fuj = available_namespace(list(package, op, version)),
    iterations = 2,
    check = FALSE
  )
)

res |>
  dplyr::summarise(
    min = base::min(min),
    median = stats::median(median),
    `itr/sec` = 1 / mean(1 / `itr/sec`),
    mem_alloc = sum(mem_alloc),
    `gc/sec` = 1 / mean(1 / `gc/sec`),
    n_gc = sum(n_gc),
    total_time = sum(total_time),
    n_itr = sum(n_itr),
    .by = "expression"
  )
