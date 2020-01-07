
mat_lc <- rbind(c(0,1,0), c(0,0,1), c(0,0,0))
mat_lc2 <- rbind(c(0,1,0), c(0,0,0), c(1,0,0))
mat_ac <- rbind(c(0,0,0), c(1,0,0), c(1,0,0))
mat_ec <- rbind(c(0,0,0), c(0,0,0), c(1,1,0))
mat_om <- rbind(c(0,0,0), c(1,0,0), c(1,1,0))
mat_om2 <- rbind(c(0,1,1), c(0,0,1), c(0,0,0))
mat_ci <- rbind(c(0,0,1), c(1,0,0), c(0,1,0))
mat_cb <- rbind(c(0,0,0,0), c(0,0,0,0), c(1,1,0,0), c(0,0,1,0))

test_that("expected error", {
  expect_error(motif_census(mat_lc[,-1]), "`mat` is not square", fixed = TRUE)
})


res_lc <- motif_census(t(mat_lc))
res_lc2 <- motif_census(mat_lc2)
res_ac <- motif_census(mat_ac)
res_ec <- motif_census(mat_ec)
res_om <- motif_census(mat_om)
res_om2 <- motif_census(mat_om2)
res_ci <- motif_census(mat_ci)
res_cb <- motif_census(mat_cb)

test_that("expected error", {
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

  expect_equal(sum(res_cb), 9)
  expect_equal(sum(res_cb[4,1]), 2)
  expect_equal(sum(res_cb[3,2]), 2)
  expect_true(res_cb[1,3] & res_cb[2,3])
  expect_true(res_cb[1,7] & res_cb[2,7] & res_cb[3,6])
})



