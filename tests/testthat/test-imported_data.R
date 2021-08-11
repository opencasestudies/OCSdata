test_that("imported_data works", {
  tmp = tempfile()
  dir.create(tmp)
  imported_data('ocs-bp-opioid-rural-urban', outpath = tmp)
  fpath = file.path(tmp,"OCS_data","data","imported","county_annual.rda")
  expect_equal(file.exists(fpath), TRUE)
})
