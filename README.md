# Motif census
[![Actions Status](https://github.com/KevCaz/motifscensus/workflows/Check%20Package/badge.svg)](https://github.com/KevCaz/motifscensus/actions)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

## :question: Description 

So far, this package only includes `motif_census()`, a function that
counts the different positions occupied by the different species in all the **3
species motifs** of a given **unipartite network**.

Note that `count_motif()` in [`igraph`](https://igraph.org/r/) counts motifs of
size 3 and 4 of different kind networks, but does not accounts for the different
positions occupied within a motif.



## Installation

```r
install.packages("remotes")
install_github("KevCaz/motifscensus")
```


## Example

```r
R> library(motifcensus)
R> # Network net: 4->3->1 & 4->3->2 & 1<-3->2 ; meaning 2 linear chains 
R> # (motif 2 in Milo (2002)) and 1 exploitative exploitation (motif 1)
R> net <- rbind(c(0,0,0,0), c(0,0,0,0), c(1,1,0,0), c(0,0,1,0))
net
     [,1] [,2] [,3] [,4]
[1,]    0    0    0    0
[2,]    0    0    0    0
[3,]    1    1    0    0
[4,]    0    0    1    0

R> motif_census(net, unidirectional = TRUE) 
$motifs
1 2 3 4 5 
2 0 1 0 0 

$motifs_node
     1 2 3 4 5
[1,] 1 0 1 0 0
[2,] 1 0 1 0 0
[3,] 2 0 1 0 0
[4,] 2 0 0 0 0

$positions
 [1] 2 2 2 0 0 1 2 0 0 0 0

$positions_node
     [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11]
[1,]    0    0    1    0    0    0    1    0    0     0     0
[2,]    0    0    1    0    0    0    1    0    0     0     0
[3,]    0    2    0    0    0    1    0    0    0     0     0
[4,]    2    0    0    0    0    0    0    0    0     0     0


R> motif_census(net) # net is treated as bidirectional network
$motifs
 1  2  3  4  5  6  7  8  9 10 11 12 13 
 1  2  0  0  0  0  0  0  0  0  0  0  0 

$motifs_node
     1 2 3 4 5 6 7 8 9 10 11 12 13
[1,] 1 1 0 0 0 0 0 0 0  0  0  0  0
[2,] 1 1 0 0 0 0 0 0 0  0  0  0  0
[3,] 1 2 0 0 0 0 0 0 0  0  0  0  0
[4,] 0 2 0 0 0 0 0 0 0  0  0  0  0

$positions
 [1] 1 2 2 2 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

$positions_node
     [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11]
[1,]    0    1    0    0    1    0    0    0    0     0     0
[2,]    0    1    0    0    1    0    0    0    0     0     0
[3,]    1    0    0    2    0    0    0    0    0     0     0
[4,]    0    0    2    0    0    0    0    0    0     0     0
     [,12] [,13] [,14] [,15] [,16] [,17] [,18] [,19] [,20] [,21]
[1,]     0     0     0     0     0     0     0     0     0     0
[2,]     0     0     0     0     0     0     0     0     0     0
[3,]     0     0     0     0     0     0     0     0     0     0
[4,]     0     0     0     0     0     0     0     0     0     0
     [,22] [,23] [,24] [,25] [,26] [,27] [,28] [,29] [,30]
[1,]     0     0     0     0     0     0     0     0     0
[2,]     0     0     0     0     0     0     0     0     0
[3,]     0     0     0     0     0     0     0     0     0
[4,]     0     0     0     0     0     0     0     0     0

```
