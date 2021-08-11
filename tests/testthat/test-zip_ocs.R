test_that("zip_ocs works", {
  tmp = tempfile()
  dir.create(tmp)
  expect_equal(zip_ocs('ocs-bp-co2-emissions', outpath = tmp), TRUE)
})
