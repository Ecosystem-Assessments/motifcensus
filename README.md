# Motifs census
[![Actions Status](https://github.com/KevCaz/motifscensus/workflows/Check%20Package/badge.svg)](https://github.com/KevCaz/motifscensus/actions)


[`igraph`](https://igraph.org/r/) 


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
     [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
[1,]    0    0    1    0    0    0    1    0    0     0
[2,]    0    0    1    0    0    0    1    0    0     0
[3,]    0    2    0    0    0    1    0    0    0     0
[4,]    2    0    0    0    0    0    0    0    0     0
```