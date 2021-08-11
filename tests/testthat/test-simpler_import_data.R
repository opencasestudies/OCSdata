test_that("simpler_import_data works", {
  tmp = tempfile()
  dir.create(tmp)
  expect_equal(simpler_import_data('ocs-bp-opioid-rural-urban', outpath = tmp), TRUE)
})
