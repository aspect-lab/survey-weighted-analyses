# Settings shared by every chapter. Quarto runs each chapter in a fresh R session, so every
# chapter starts by sourcing this file.

# Seed: every chapter starts from the same random-number state.
seed <- 2024
set.seed(seed)

# Number of imputations. The book uses 5. A smoke test (`quarto render --profile smoke`)
# sets N_IMPUTATIONS=2 through the file `_environment-smoke`.
n_imputations_book <- 5L
n_imputations <- as.integer(Sys.getenv(
  "N_IMPUTATIONS",
  unset = n_imputations_book
))
smoke_test <- n_imputations != n_imputations_book

# Any other number of imputations is a test run. Its results go to their own folder, so they
# can never replace the book's results.
processed_dir <- if (smoke_test) {
  "../data/processed-smoke"
} else {
  "../data/processed"
}
dir.create(processed_dir, showWarnings = FALSE, recursive = TRUE)

# Strata with a single PSU: center them on the overall mean when estimating variances.
options(survey.lonely.psu = "adjust")

# Cache only the expensive chunks marked `cache: true` in each chapter.
# Code, data, settings and package changes invalidate their results.
loadNamespace("survey")
cache_context <- list(
  code = knitr::knit_code$get(),
  settings = tools::md5sum(c("_common.R", "../renv.lock")),
  packages = utils::installed.packages()[, c("Package", "Version")],
  R = R.version.string,
  imputations = n_imputations,
  survey_options = options()[grep("^survey[.]", names(options()))]
)
knitr::opts_chunk$set(
  cache.path = paste0(
    processed_dir,
    "/cache/",
    tools::file_path_sans_ext(knitr::current_input()),
    "/"
  ),
  cache.extra = cache_context
)
options(sass.cache = file.path(processed_dir, "cache", "sass"))
