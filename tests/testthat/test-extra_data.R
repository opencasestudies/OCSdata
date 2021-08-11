test_that("extra_data works", {
  tmp = tempfile()
  dir.create(tmp)
  expect_equal(extra_data('ocs-bp-opioid-rural-urban', outpath = tmp), TRUE)
})
