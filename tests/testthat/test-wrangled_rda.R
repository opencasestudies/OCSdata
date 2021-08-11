test_that("wrangled_rda works", {
  tmp = tempfile()
  dir.create(tmp)
  expect_equal(wrangled_rda('ocs-bp-opioid-rural-urban', outpath = tmp), TRUE)
})
