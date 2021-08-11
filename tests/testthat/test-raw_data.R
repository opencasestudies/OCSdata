test_that("raw_data works", {
  tmp = tempfile()
  dir.create(tmp)
  raw_data('ocs-bp-opioid-rural-urban', outpath = tmp)
  fpath = file.path(tmp,"OCS_data","data","raw","LND01.xls")
  expect_equal(file.exists(fpath), TRUE)
})
