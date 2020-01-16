#' motif_census
#'
#' Compute 3 species motif census for unidirection and bidirectional 
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
#' * motifs: motif count.
#' * positions: position count.
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
#' If `mat` corresponds to a  bidirectional network, then the 13 motifs are 
#' ordered following Milo (2002). Positions to be detailed. 


motif_census <- function(mat, unidirectional = FALSE) {
    if (unidirectional) {
        pos <- motif_census_uni(mat)
        pos2mot <- rep(1:5, c(3, 2, 2, 3, 1))
    } else {
        pos <- motif_census_bi(mat, motifcensus::positions_motif3)
        pos2mot <- rep(1:13, c(2, 3, 3, 2, 3, 2, 3, 2, 1, 3, 2, 3, 1))
    }
    mot <- unlist(lapply(split(t(pos), pos2mot), function(x) sum(x)/3))
    list(motifs = mot, positions = pos)
}