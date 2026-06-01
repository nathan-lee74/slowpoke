#' Load bundled Pokémon TCG dataset
#'
#' @return A tibble containing Pokémon TCG data.
#' @importFrom readr read_csv
#' @importFrom here here
#' @export
load_data <- function() {

  dir <- here::here("data", "pokemon.parquet")

  if (file.exists(dir)) {
    return(arrow::read_parquet(dir))
  }

  path <- "https://www.dropbox.com/scl/fi/tnl4wcmgduu3bnmmllz2u/pokemon_cards.csv?rlkey=h7evg3hr4ckzqrxrzoy458ojs&st=uzrlktbc&dl=1"
  poke_data <- readr::read_csv(path, show_col_types = FALSE)
  dir.create(here::here("data"), recursive = TRUE, showWarnings = FALSE)
  arrow::write_parquet(poke_data, dir)
  return(poke_data)

}
