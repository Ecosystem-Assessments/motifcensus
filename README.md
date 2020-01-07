# Motifs census
[![Actions Status](https://github.com/KevCaz/motifscensus/workflows/Check%20Package/badge.svg)](https://github.com/KevCaz/motifscensus/actions)

## :question: Description 

So far, this package only includes `motif_census()`, a function that
counts the different positions occupied by the different species in all the **3
species motifs** of a given **unidirectional network**.

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
net <- rbind(c(0,0,0,0), c(0,0,0,0), c(1,1,0,0), c(0,0,1,0))
# meaning: 4 -> 3 -> 1 & 4 -> 3 -> 1 & 1 <- 3 -> 2
net
     [,1] [,2] [,3] [,4]
[1,]    0    0    0    0
[2,]    0    0    0    0
[3,]    1    1    0    0
[4,]    0    0    1    0

motifscensus::motif_census(net)
     [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11]
[1,]    0    0    1    0    0    0    1    0    0     0     0
[2,]    0    0    1    0    0    0    1    0    0     0     0
[3,]    0    2    0    0    0    1    0    0    0     0     0
[4,]    2    0    0    0    0    0    0    0    0     0     0
```