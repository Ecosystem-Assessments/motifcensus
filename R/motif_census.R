#' motif_census
#'
#' Compute 3-nodes motif census for unidirection and bidirectional
#' unipartite networks.
#'
#' @param mat a square matrix of logical describing a network.
#' @param unidirectional a logical. Is the network considered unidirectional.
#' Default is set to `FALSE` meaning that the network is bidirectional.
#'
#' @references
#' Milo, R. (2002). Network Motifs: Simple Building Blocks of Complex Networks. Science, 298(5594), 824–827. https://doi.org/10.1126/science.298.5594.824
#'
#' @export
#'
#' @return
#' A list of two elements:
#' * `motifs`: total motif count.
#' * `motifs_node`: motif count per node.
#' * `positions`: total position count.
#' * `positions_node`: position count per nodes
#'
#' If `unidirectional` is `TRUE`, then motifs ordered as follows:
#'  * 1 linear chains bottom;
#'	* 2 apparent competition;
#'	* 3 exploitative competition;
#'	* 4 omnivory;
#'	* 5 circular;
#' and positions are as follows:
#'	* 1 linear chains bottom;
#'	* 2 linear chains middle;
#'	* 3 linear chains top;
#'	* 4 apparent competition botton;
#'	* 5 apparent competition top;
#'	* 6 exploitative competition bottom;
#'	* 7 exploitative competition top;
#'	* 8 omnivory bottom;
#'	* 9 omnivory middle;
#'	* 10 omnivory top;
#'	* 11 circular (e.g. 1->2->3->1).
#'
#' If `mat` corresponds to a bidirectional network, then the 13 motifs are
#' ordered following Milo (2002). Positions to be detailed.
#' @examples
#' net <- rbind(c(0,0,0,0), c(0,0,0,0), c(1,1,0,0), c(0,0,1,0))
#' motif_census(net, unidirectional = TRUE)
#' motif_census_triplet(net)

motif_census <- function(mat, unidirectional = FALSE) {
    if (unidirectional) {
        pos <- motif_census_uni(mat)
        pos2mot <- rep(seq_len(5), c(3, 2, 2, 3, 1))
    } else {
        pos <- motif_census_bi(mat, motifcensus::positions_motif3)
        pos2mot <- rep(seq_len(13), c(2, 3, 3, 2, 3, 2, 3, 2, 1, 3, 2, 3, 1))
    }
    tmp_mot <- split(t(pos), pos2mot)
    mot <- unlist(lapply(tmp_mot, function(x) sum(x)/3))
    motsp <- motifs_node(tmp_mot, nrow(mat))
    list(
        motifs = mot,
        motifs_node = motsp,
        positions = apply(pos, 2, sum),
        positions_node = pos
    )
}



motifs_node <- function(x, nsp) {
    t(do.call(rbind,
        lapply(x, function(y) apply(matrix(y, ncol = nsp), 2, sum))
    ))
}


#' @export
#' @describeIn motif_census return details for all motifs
motif_census_triplet <- function(mat) {
    out <- as.data.frame(motif_census_all_triplets(mat, choose(nrow(mat), 3)))
    names(out) <- c("i", "j", "k", "n")
    merge(out, motifcensus::table64)
}
