#' @importFrom utils data
#' @importFrom Rcpp evalCpp
#' @useDynLib motifcensus
#' @name motif_census
NULL

# Code used to generate table64

gen_table64 <- function() {

   out <- data.frame(
         n = 0:63,
         i_to_j = FALSE, j_to_i = FALSE,
         i_to_k = FALSE, k_to_i = FALSE,
         j_to_k = FALSE, k_to_j = FALSE,
         motifcensus::positions_motif3,
         sum_pos = NA_integer_,
         motif = NA_character_,
         name_uni = "",
         stringsAsFactors = FALSE
      )
   names(out)[8:10] <- paste0("pos_", names(out)[8:10])
   # the sum below identify motif
   out$sum_pos <- apply(out[8:10], 1, sum)

   # detail what interaction are on
   for (i in 0:63) {
      for (j in 0:5) {
         if (bitwAnd(bitwShiftR(i, j), 1)) out[i + 1, j + 2] = TRUE
      }
      out$motif[i + 1] <- paste(
         write_ntw(out[i + 1, 2] + 2 * out[i + 1, 3] + 1),
         write_ntw(out[i + 1, 4] + 2 * out[i + 1, 5] + 1, "i", "k"),
         write_ntw(out[i + 1, 6] + 2 * out[i + 1, 7] + 1, "j", "k"),
         sep = " + "
      )
   }

   # motifs name (unidirectional version)
   out$name_uni[out$sum_pos == 5] <- "exploitative competition"
   out$name_uni[out$sum_pos == 12] <- "linear chain"
   out$name_uni[out$sum_pos == 28] <- "apparent competition"
   out$name_uni[out$sum_pos == 36] <- "omnivory"

   out
}
# table64 <- gen_table64()
# save(table64, file = "data/table64.rdata")

write_ntw <- function(val, x = "i", y = "j") {
   arr <- switch(val,
   "   ",
   "-->",
   "<--",
   "<->")
   paste0(x, arr, y)
}
