#' Find Pokémon by name pattern
#'
#' @param poke_name A character string to match against Pokémon names.
#' @return A tibble of matching Pokémon card names and their flavor text.
#' @importFrom dplyr filter select distinct
#' @importFrom stringi stri_trans_totitle stri_detect_regex
#' @export
find_poke <- function(poke_name, data = NULL) {
  if (is.null(data)) {
    data <- load_data()
    }

  poke_name <- stringi::stri_trans_totitle(poke_name)

  result <- data |>
    select(name, flavorText) |>
    filter(stringi::stri_detect_regex(name, poke_name)) |>
    distinct()

  return(result)
}

#' Find multiple Pokémon by name patterns
#'
#' @param poke_names A character vector of name patterns.
#' @return A tibble of matching Pokémon card names and flavor text.
#' @importFrom dplyr bind_rows distinct
#' @importFrom purrr map
#' @export
find_many_pokes <- function(poke_names) {

  data <- load_data()

  poke_names |>
    purrr::map(find_poke, data) |>
    dplyr::bind_rows() |>
    dplyr::distinct()

}
