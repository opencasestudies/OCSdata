test_that("imported_data works", {
  tmp = tempfile()
  dir.create(tmp)
  expect_equal(imported_data('ocs-bp-opioid-rural-urban', outpath = tmp), TRUE)
})
