#' potisions_motifs
#'
#' Table giving the motifs positions associated with all the 64 combinations
#' of interactions for 3 species motifs.
#'
#' @docType data
#' @keywords datasets
#' @name positions_motif3
#' @usage positions_motif3
#' @format a matrix of 64 rows and 3 columns
"positions_motif3"


#' Table of motifs
#'
#' Display all the 64 bidirectional 3-species motifs, for every motif,  details interactions and name notable motifs.
#'
#' @docType data
#' @keywords datasets
#' @name bidirectional_motifs3
#' @usage bidirectional_motifs3
#' @references
#' * Milo, R. (2002). Network Motifs: Simple Building Blocks of Complex Networks. Science, 298(5594), 824–827. https://doi.org/10.1126/science.298.5594.824
#' @format a matrix of 64 rows (1 row per motif) and 13 columns: 
#' * `mid`: motif identifier
#' * `i_to_j`: a logical, is there an interaction from `i` to ``j``;
#' * `j_to_i`: a logical, is there an interaction from `j` to ``i``;
#' * `i_to_k`: a logical, is there an interaction from `i` to ``k``;
#' * `k_to_i`: a logical, is there an interaction from `k` to ``i``;
#' * `j_to_k`: a logical, is there an interaction from `j` to ``k``;
#' * `k_to_j`: a logical, is there an interaction from `k` to ``j``;
#' * `pid_i`: position identifier of `i`;
#' * `pid_j`: position identifier of `j`;
#' * `pid_k`: position identifier of `k`;
#' * `psum`: sum of positions (could be used to identify motifs);
#' * `motif`: motifs description using ascii characters;
#' * `name_uni`: motif name (in unidirectionnal networks).
"bidirectional_motifs3"