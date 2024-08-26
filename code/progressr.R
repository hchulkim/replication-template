progressr::handlers(global = TRUE)  ## automatically report on progress
progressr::handlers("cli")          ## ... using a 'cli' progress bar

options(cli.progress_bar_style = list(
  complete = cli::col_yellow("\u2605"),
  incomplete = cli::col_grey("\u00b7")
))

library(progressr)
y <- slow_sum(1:10)
