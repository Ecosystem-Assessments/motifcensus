
mat_lc <- rbind(c(0,1,0), c(0,0,1), c(0,0,0))
mat_ac <- rbind(c(0,0,0), c(1,0,0), c(1,0,0))

test_that("expected error", {
  expect_error(motif_census(mat_lc[,-1]), "`mat` is not square", fixed = TRUE)
})


res_lc <- motif_census(t(mat_lc))
res_ac <- motif_census(mat_ac)

test_that("expected error", {
  expect_equal(sum(res_lc), 3)
  expect_true(res_lc[3,1] & res_lc[2,2] & res_lc[1,3])
  expect_equal(sum(res_ac), 3)
  expect_true(res_ac[1,5] & res_ac[2,4] & res_ac[3,4])
})



