positions_motif3 <- matrix(0, 64, 3)

# Below 1 + xx is used to bear in mind the converstion between c++/R

# **motif 1** expoitative competition, 3 cases
# 2 positions -- bottom (1): 1 and top (2): 2
positions_motif3[1 + 5,] <- c(1, 2, 2)
positions_motif3[1 + 18,] <- c(2, 1, 2)
positions_motif3[1 + 40,] <- c(2, 2, 1)

# **motif 2** linear chain, 6 cases
# 3 positions -- bottom: 3, middle: 4 and top: 5
positions_motif3[1 + 6,] <- c(4, 3, 5) # j->i->k
positions_motif3[1 + 9,] <- c(4, 5, 3) # k->i->j
positions_motif3[1 + 17,] <- 3:5 # i->j->k
positions_motif3[1 + 24,] <- c(5, 3, 4) # j->k->i
positions_motif3[1 + 34,] <- c(5, 4, 3) # k->j->i
positions_motif3[1 + 36,] <- c(3, 5, 4) # i->k->j 

# **motif 3** A->B->C + B->A, 6 cases
# 3 positions -- bottom: 6, middle: 7 and top: 8
positions_motif3[1 + 7 ,] <- c(7, 6, 8) # j<=>i->k
positions_motif3[1 + 13,] <- c(7, 8, 6) # k<=>i->j 
positions_motif3[1 + 19,] <- c(6, 7, 8) # i<=>j->k 
positions_motif3[1 + 56,] <- c(8, 6, 7) # j<=>k->i 
positions_motif3[1 + 50,] <- c(8, 7, 6) # k<=>j->i 
positions_motif3[1 + 44,] <- c(6, 8, 7) # i<=>k->j

# **motif 4** apparent competition, 3 cases 
# 2 positions -- bottom (2): 9 and top (1): 10
positions_motif3[1 + 10,] <- c(10, 9, 9) # k->i<-j
positions_motif3[1 + 20,] <- c(9, 9, 10) # i->k<-j
positions_motif3[1 + 33,] <- c(9, 10, 9) # k->j<-i

# **motif 5** omnivory, 6 cases 
# 3 positions -- bottom: 11 middle: 12 top: 13
positions_motif3[1 + 21,] <- c(11, 12, 13) # i->k<-j + j->i
positions_motif3[1 + 22,] <- c(12, 11, 13) # i->k<-j + i->j 
positions_motif3[1 + 26,] <- c(13, 11, 12) # j->i<-k + j->k
positions_motif3[1 + 37,] <- c(11, 13, 12) # k->j<-j + i->k
positions_motif3[1 + 41,] <- c(12, 13, 11) # k->j<-i + k->i
positions_motif3[1 + 42,] <- c(13, 12, 11) # k->i<-j + k->j

# **motif 6** omnivory, 3 cases 
# 2 positions -- bottom (2): 14 top (2): 15
positions_motif3[1 + 23,] <- c(14, 14, 15) # i->k<-j + j<=>i
positions_motif3[1 + 45,] <- c(14, 15, 14) # i->j<-k + i<=>k 
positions_motif3[1 + 58,] <- c(15, 14, 14) # j->i<-k + j<=>k


# **motif 7** A <=> B => C, 3 cases 
# 3 positions -- 3 links: 16,  2 links: 17, 1 link:: 18
positions_motif3[1 + 11,] <- c(16, 17, 18) # j<=>i<- k
positions_motif3[1 + 14,] <- c(16, 18, 17) # k<=>i<- j 
positions_motif3[1 + 28,] <- c(17, 18, 16) # i<=>k<- j
positions_motif3[1 + 35,] <- c(17, 16, 18) # i<=>j<- k
positions_motif3[1 + 49,] <- c(18, 16, 17) # k<=>j<- i
positions_motif3[1 + 52,] <- c(18, 17, 16) # j<=>k<- i


# **motif 8** A <=> B <=> C, 3 cases 
# 2 positions -- 4 links: 19,  2 links: 20
positions_motif3[1 + 15,] <- c(19, 20, 20) # j<=>i<=>k
positions_motif3[1 + 51,] <- c(20, 19, 20) # i<=>j<=>k 
positions_motif3[1 + 60,] <- c(20, 20, 19) # j<=>k<=>i


# **motif 9** circluar, 2 cases
# 1 unique position -- 21
positions_motif3[1 + c(25, 38),] <- 21


# **motif 10** A -> B <=> C + C -> A
# 3 positions -- A: 22 B: 23 C: 24 (did not find a good way to name those)
positions_motif3[1 + 27,] <- c(23, 24, 22) # k->i<=>j + j->k
positions_motif3[1 + 29,] <- c(24, 22, 23) # j->k<=>i + i->j 
positions_motif3[1 + 39,] <- c(24, 23, 22) # k->j<=>i + i->k
positions_motif3[1 + 46,] <- c(23, 22, 24) # j->i<=>k + k->j
positions_motif3[1 + 54,] <- c(22, 24, 23) # i->k<=>j + j->i
positions_motif3[1 + 57,] <- c(22, 23, 24) # i->j<=>k + k->i


# **motif 11**  C <- A -> B + B <=> C, 3 cases
# 2 positions -- bottom (1): 25  top (2): 26 
positions_motif3[1 + 30,] <- c(26, 25, 26) # i<-j->k + i<=>k
positions_motif3[1 + 43,] <- c(26, 26, 25) # i<-k->j + i<=>j
positions_motif3[1 + 53,] <- c(25, 26, 26) # j<-i->k + j<=>k


# **motif 12**  A <=> B <=> C + A -> C
# 3 positions -- B: 27 A: 28 A: 29 (did not find a good way to name those)
positions_motif3[1 + 31,] <- c(27, 29, 28) # k<=>i<=>j + j->k 
positions_motif3[1 + 47,] <- c(27, 28, 29) # j<=>i<=>k + k->j  
positions_motif3[1 + 55,] <- c(29, 27, 28) # k<=>j<=>i + i->j 
positions_motif3[1 + 59,] <- c(28, 27, 29) # i<=>j<=>k + k->i 
positions_motif3[1 + 61,] <- c(29, 28, 27) # j<=>k<=>i + i->j 
positions_motif3[1 + 62,] <- c(28, 29, 27) # i<=>k<=>j + j->i 


## **motif 13** fully connected, 1 case
## position: 30
positions_motif3[1 + 63,] <- 30
colnames(positions_motif3) <- c("i", "j", "k")


# write.csv(positions_motif3, file = "data/positions_motif3.csv", 
#     row.names = FALSE)
save(positions_motif3, file="data/positions_motif3.rdata", 
    compress = "xz", version = 2)
