
# linear chain 
mat_lc <- rbind(c(0,1,0), c(0,0,1), c(0,0,0))
mat_lc2 <- rbind(c(0,1,0), c(0,0,0), c(1,0,0))
# apparent competition
mat_ac <- rbind(c(0,0,0), c(1,0,0), c(1,0,0))
# exploitative competition 
mat_ec <- rbind(c(0,0,0), c(0,0,0), c(1,1,0))
# omnivory 
mat_om <- rbind(c(0,0,0), c(1,0,0), c(1,1,0))
mat_om2 <- rbind(c(0,1,1), c(0,0,1), c(0,0,0))
# circular
mat_ci <- rbind(c(0,0,1), c(1,0,0), c(0,1,0))
# 2 linear chain and one exploitative 
mat_cb <- rbind(c(0,0,0,0), c(0,0,0,0), c(1,1,0,0), c(0,0,1,0))

test_that("expected error", {
  expect_error(motif_census(mat_lc[,-1], unidirectional = TRUE), 
    "`mat` is not square", fixed = TRUE)
})


res_lc <- motif_census(t(mat_lc), unidirectional = TRUE)$positions
res_lc2 <- motif_census(mat_lc2, unidirectional = TRUE)$positions
res_ac <- motif_census(mat_ac, unidirectional = TRUE)$positions
res_ec <- motif_census(mat_ec, unidirectional = TRUE)$positions
res_om <- motif_census(mat_om, unidirectional = TRUE)$positions
res_om2 <- motif_census(mat_om2, unidirectional = TRUE)$positions
res_ci <- motif_census(mat_ci, unidirectional = TRUE)$positions
res_cb <- motif_census(mat_cb, unidirectional = TRUE)

test_that("position for unidirectional networks", {
  expect_equal(sum(res_lc), 3)
  expect_true(res_lc[1,3] & res_lc[2,2] & res_lc[3,1])
  expect_equal(sum(res_lc2), 3)
  expect_true(res_lc2[3,1] & res_lc2[1,2] & res_lc2[2,3])
  expect_equal(sum(res_ac), 3)
  expect_true(res_ac[1,5] & res_ac[2,4] & res_ac[3,4])
  expect_equal(sum(res_ec), 3)
  expect_true(res_ec[1,7] & res_ec[2,7] & res_ec[3,6])
  expect_equal(sum(res_om), 3)
  expect_true(res_om[1,10] & res_om[2,9] & res_om[3,8])
  expect_equal(sum(res_om2), 3)
  expect_true(res_om2[1,8] & res_om2[2,9] & res_om2[3,10])
  expect_equal(sum(res_ci), 3)
  expect_true(all(res_ci[,11] == 1))

  cb_pos <- res_cb$positions
  expect_equal(sum(cb_pos), 9)
  expect_equal(sum(cb_pos[4,1]), 2)
  expect_equal(sum(cb_pos[3,2]), 2)
  expect_true(cb_pos[1,3] & cb_pos[2,3])
  expect_true(cb_pos[1,7] & cb_pos[2,7] &cb_pos[3,6])
})

test_that("motifs for unidirectional networks", {
  expect_true(all(res_cb$motifs == c(2, 0, 1, 0, 0))) 
})


test_that("positions for bidirectional networks", {
  expect_identical(motif_census(mat_ci), motif_census(t(mat_ci))) 
})
