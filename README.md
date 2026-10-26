# Survey-Weighted Analysis of BRFSS 2024

[Read the book online](https://aspect-lab.github.io/survey-weighted-analyses/).

A Quarto book, titled **survey-weighted-analyses**, that walks through a complete analysis of complex survey data in R, using the
2024 Behavioral Risk Factor Surveillance System (BRFSS):

1. importing a large survey file;
2. cleaning and recoding with explicit checks;
3. survey-weighted descriptive statistics;
4. multiple imputation that respects the survey design;
5. bivariate (crude) models;
6. multivariable (adjusted) models, a sensitivity analysis, and reporting.

The research question: is household income associated with diabetes among US adults?
Models report survey-weighted prevalence ratios, pooled across imputations with Rubin's
rules.

## What you need

- [R](https://cran.r-project.org/) (the book was built with R 4.6.1)
- [Quarto](https://quarto.org/docs/get-started/)
- An editor such as [RStudio](https://posit.co/download/rstudio-desktop/) or
  [Positron](https://positron.posit.co/)
- Several GB of free disk space for the data, results and caches, and at least 8 GB of
  memory. Reduce the number of parallel workers in Chapter 4 if memory is limited.

## Setup

1. **Get the project.** Clone this repository or download it as a zip file and unzip it.
2. **Open it.** Double-click `survey-weighted-analyses.Rproj` (RStudio) or open the folder
   (Positron). R starts `renv` automatically.
3. **Install the packages.** In the R console, run:

   ```r
   renv::restore()
   ```

   This installs the exact package versions the book was built with into the project's own
   library (`renv/library/`), without touching your other R projects.
4. **Download the data.** For interactive R chunks, first run `setwd("book")` in the
   R console. Open `book/01-import.qmd` and run the chunk labeled `download` once.
   Alternatively, download "2024 BRFSS Data (SAS Transport Format)" from the
   [CDC BRFSS 2024 page](https://www.cdc.gov/brfss/annual_data/annual_2024.html), unzip it, and
   save the file as `data/raw/LLCP2024.XPT`. Raw data, processed data and caches are
   excluded from Git.

## Render the book

The book's source and configuration live in `book/`; data and the shared R
environment stay at the repository root.

From a terminal in the project folder:

```sh
quarto render book
```

If your terminal is already inside `book/`, use `quarto render` instead.

Open `book/_book/index.html` to read the result. Rendering time depends on available
memory, processor cores and the number of imputations. You can also run each chapter's
code chunk by chunk, in order (`book/01-import.qmd`
to `book/06-multivariable.qmd`); each chapter saves what the next one needs in `data/processed/`.

`book/_quarto.yml` defines one book with the six chapters in analysis order, two
appendices, shared navigation and search. Use `quarto preview book` to serve the book
locally with automatic updates as you edit.

**Quick test first.** A smoke test runs the whole book with 2 imputations
instead of 20 and writes to separate folders (`book/_book-smoke/`, `data/processed-smoke/`), so it
never replaces the real results:

```sh
quarto render book --profile smoke
```

## Working on descriptive statistics

After downloading the data, you can stop after the first three chapters:

```sh
quarto render book/01-import.qmd
quarto render book/02-cleaning.qmd
quarto render book/03-descriptives.qmd
```

You do not need to run multiple imputation or modeling to build Tables 1 and 2.
Chapter 3 explains the integer stratum–PSU identifiers, explicit categorical types,
survey tests, missing values and caching. Rerender just that chapter while editing
your descriptive analysis.

Expensive chunks use Quarto's built-in R cache. Later renders reuse unchanged
calculations; changes to data, analysis code, settings or packages invalidate
them. Full and smoke caches are separate. To force recalculation:

```sh
quarto render book --cache-refresh
```

The first render still performs the analysis. Caching speeds up subsequent
renders; it does not apply to running individual lines in the R console.

## Layout

| Path | Contents |
|---|---|
| `book/index.qmd` | Preface: the question, setup, chapter map |
| `book/01-import.qmd` ... `book/06-multivariable.qmd` | The six chapters |
| `book/decisions.qmd`, `book/reproducibility.qmd` | Appendices: coding decisions with counts; packages, seeds, session information |
| `book/_common.R` | Settings every chapter uses: seed, number of imputations, folders |
| `book/_quarto.yml`, `book/_quarto-smoke.yml`, `book/_environment-smoke` | Book configuration and the smoke-test profile |
| `.github/workflows/publish.yml` | Manually triggered full-book build and GitHub Pages deployment |
| `DESCRIPTION`, `renv.lock`, `renv/` | Package list and the recorded package versions |
| `data/` | Your local copy of the data and the files the chapters save (see `data/README.md`) |

## Data source

Centers for Disease Control and Prevention (CDC). Behavioral Risk Factor Surveillance System
Survey Data, 2024. Atlanta, Georgia: U.S. Department of Health and Human Services, Centers for
Disease Control and Prevention. <https://www.cdc.gov/brfss/annual_data/annual_2024.html>

## License

Apache License 2.0 (see `LICENSE`). The BRFSS data are public and are not included.
