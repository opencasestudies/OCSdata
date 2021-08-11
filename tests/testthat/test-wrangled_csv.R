test_that("wrangled_csv works", {
  tmp = tempfile()
  dir.create(tmp)
  expect_equal(wrangled_csv('ocs-bp-opioid-rural-urban', outpath = tmp), TRUE)
})
