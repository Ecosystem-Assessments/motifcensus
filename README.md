# Motifs census

## Installation

```r
install.packages("remotes")
install_github("KevCaz/motifscensus")
```

## Example

```r
mat_test <- rbind(c(0,1,0,0), c(0,0,0,1), c(0,0,0,1),c(0,0,0,0))
mat_test
     [,1] [,2] [,3] [,4]
[1,]    0    1    0    0
[2,]    0    0    0    1
[3,]    0    0    0    1
[4,]    0    0    0    0

motif_census(mat_test)
    [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
[1,]    0    0    1    0    0    0    0    0    0     0
[2,]    0    1    0    0    0    0    1    0    0     0
[3,]    0    0    0    0    0    0    1    0    0     0
[4,]    1    0    0    0    0    1    0    0    0     0
```