
mat_lc <- rbind(c(0,1,0), c(0,0,1), c(0,0,0))


test_that("expected error", {
  expect_error(motif_census(mat_lc[,-1]), "`mat` is not square", fixed = TRUE)
})


res_lc <- motif_census(mat_lc)

test_that("expected error", {
  expect_equal(sum(res_lc), 3)
  expect_true(res_lc[3,1] & res_lc[2,2] & res_lc[1,3])
})
