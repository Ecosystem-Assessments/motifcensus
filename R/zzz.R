#' @importFrom utils data
#' @importFrom Rcpp evalCpp
#' @useDynLib motifcensus
#' @name motif_census
NULL

# Code used to generate bidirectional_motifs3

gen_bidirectional_motifs3 <- function() {
   out <- data.frame(
      mid = 0:63,
      i_to_j = FALSE, j_to_i = FALSE,
      i_to_k = FALSE, k_to_i = FALSE,
      j_to_k = FALSE, k_to_j = FALSE,
      motifcensus::positions_motif3,
      psum = NA_integer_,
      motif = NA_character_,
      name_uni = "",
      stringsAsFactors = FALSE
   )
   names(out)[8:10] <- paste0("pid_", names(out)[8:10])
   # the sum below identify motif
   out$psum <- apply(out[8:10], 1, sum)

   # detail what interaction are on
   for (i in 0:63) {
      for (j in 0:5) {
         if (bitwAnd(bitwShiftR(i, j), 1)) out[i + 1, j + 2] <- TRUE
      }
      out$motif[i + 1] <- paste(
         write_ntw(out[i + 1, 2] + 2 * out[i + 1, 3] + 1),
         write_ntw(out[i + 1, 4] + 2 * out[i + 1, 5] + 1, "i", "k"),
         write_ntw(out[i + 1, 6] + 2 * out[i + 1, 7] + 1, "j", "k"),
         sep = " + "
      )
   }

   # motifs name (unidirectional version)
   out$name_uni[out$psum == 5] <- "exploitative competition"
   out$name_uni[out$psum == 12] <- "linear chain"
   out$name_uni[out$psum == 28] <- "apparent competition"
   out$name_uni[out$psum == 36] <- "omnivory"

   out
}
# bidirectional_motifs3 <- gen_bidirectional_motifs3()
# save(bidirectional_motifs3, file = "data/bidirectional_motifs3.rda")

write_ntw <- function(val, x = "i", y = "j") {
   arr <- switch(val,
      "   ",
      "-->",
      "<--",
      "<->"
   )
   paste0(x, arr, y)
}
