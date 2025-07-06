



#' Download backbone
#' @description
#' A short description...
#'
#' @detail
#' @param .bb_name backbone name. See details for a complete list of accepted entries.
#'
#' @returns
#' @export
#'
#' @examples
fct_download_backbones <- function(.path){

  .path <- "data"

  ## Backbone information setup ####
  bb_info <- list(
    LCVP_date = NULL,
    LCVP_version = NULL,
    LCVP_filename = NULL,
    WCVP_date = NULL,
    WCVP_version = NULL,
    WCVP_filename = NULL,
    WFO_date = NULL,
    WFO_version = NULL,
    WFO_filename = NULL,
    GTS_date = "2025-05-12", ## GTS get manually from webpage: https://tools.bgci.org/global_tree_search.php
    GTS_version = "v1.9",
    GTS_filename = NULL,
    TROP_date = NULL,
    TROP_version = NULL,
    TROP_filename = NULL,
    GBIF_date = NULL,
    GBIF_version = NULL,
    GBIF_filename = NULL
    )


  ## Setup folder ####
  ## MAY NOT BE NEEDED DEPENDING ON WHERE DATA SHOULD BE STORE IN A DATA PACKAGE
  if (!file.path(".", .path) %in% list.dirs()) dir.create(.path, recursive = T)


  ##
  ## LCVP - Leipzig Catalogue of Vascular Plants ####
  ##

  if (!require(remotes)) install.packages(remotes)
  if (!require(LCVP)) remotes::install_github("idiv-biodiversity/LCVP")
  if (!require(lcvplants)) remotes::install_github("idiv-biodiversity/lcvplants")

  bb_info$LCVP_version  <- paste0("v", packageVersion("LCVP")) |> stringr::str_replace_all("\\.", "_")
  bb_info$LCVP_date     <- packageDate("LCVP") |> stringr::str_remove_all("-")
  bb_info$LCVP_filename <- paste("bb_LCVP", bb_info$LCVP_version, bb_info$LCVP_date, sep = "_")

  if (!bb_info$LCVP_filename %in% list.files(.path)) {

    assign(bb_info$LCVP_filename, dplyr::as_tibble(LCVP::tab_lcvp))

    do.call(usethis::use_data, list(as.name(bb_info$LCVP_filename), overwrite = TRUE))

    writeLines(
      "
      #' World Health Organization TB data
      #'
      #' A subset of data from the World Health Organization Global Tuberculosis
      #' Report ...
      #'
      #' @format ## `who`
      #' A data frame with 7,240 rows and 60 columns:
      #' \\describe{
      #'   \\item{country}{Country name}
      #'   \\item{iso2, iso3}{2 & 3 letter ISO country codes}
      #'   \\item{year}{Year}
      #'   ...
      #' }
      #' @source <https://www.who.int/teams/global-tuberculosis-programme/data>
      'who'
      ",
      con = "data/data.R"
    )


  }

  ## Kew: World Checklist of Vascular Plants (WCVP)
  ## REF: Govaerts R (ed.). 2022. WCVP: World Checklist of Vascular Plants.
  ## Facilitated by the Royal Botanic Gardens, Kew. [WWW document] URL
  ## https://doi.org/10.34885/rar9-jx25 [accessed 28 February 2022].
  ## See also:
  ## Govaerts, R., Nic Lughadha, E. et al. The World Checklist of Vascular Plants, a
  ## continuously updated resource for exploring global plant diversity. Sci Data 8, 215 (2021).
  ## https://doi.org/10.1038/s41597-021-00997-6

  download.file()


}
