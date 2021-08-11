test_that("raw_data works", {
  tmp = tempfile()
  dir.create(tmp)
  expect_equal(raw_data('ocs-bp-opioid-rural-urban', outpath = tmp), TRUE)
})
