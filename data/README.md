# Data

Nothing in this folder except this file is shared through git. Each reader downloads the
data from CDC and keeps it on their own computer.

| Folder | Contents | Made by |
|---|---|---|
| `raw/` | `LLCP2024.XPT`: the BRFSS 2024 SAS transport file (83 MB zipped, 1.1 GB unzipped) | You: run the `download` chunk in `book/01-import.qmd` once, or download the zip from the [CDC BRFSS 2024 page](https://www.cdc.gov/brfss/annual_data/annual_2024.html) and unzip it here as `LLCP2024.XPT` |
| `processed/` | One file per chapter: `01-brfss.rds`, `02-brfss-clean.rds`, `02-crosswalk.rds`, `04-imputed.rds`, `05-crude.rds` | Rendering the book (or running the chapters in order) |
| `processed-smoke/` | The same files from a smoke test (`quarto render book --profile smoke`); not for reporting | A smoke test |
| `processed/cache/`, `processed-smoke/cache/` | Quarto/knitr chunk caches; separate full/smoke entries | Expensive chunks marked `cache: true` |

BRFSS data are public. Source: Centers for Disease Control and Prevention (CDC), Behavioral
Risk Factor Surveillance System Survey Data, 2024.
