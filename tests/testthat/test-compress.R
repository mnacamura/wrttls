context("test-compress")

test_that("non-numeral suffixes fail", {
  expect_error(compress("a"), "other than numbers found in suffixes")
})

test_that("one element is left as is", {
  expect_equal(compress("a1"), "a1")
})

test_that("continuous two elements are not compressed", {
  expect_equal(compress(c("a1", "a2")), c("a1", "a2"))
})

test_that("continuous more-than-two elements are compressed", {
  expect_equal(compress(c("a1", "a2", "a3")), "a1--3")
})

test_that("discontinuous blocks are not compressed", {
  expect_equal(compress(paste0("a", c(1:3, 5:6))), c("a1--3", "a5", "a6"))
})

test_that("suffixes with different character lengths have correct order", {
  expect_equal(compress(paste0("a", 1:10)), "a1--10")
})

test_that("elements are sorted", {
  expect_equal(compress(c("a3", "a1", "a2")), "a1--3")
})

test_that("duplicatad elements are omitted", {
  expect_equal(compress(c("a1", "a1", "a2")), c("a1", "a2"))
})

test_that("filled zeros are left as they are", {
  expect_equal(compress(c("a001", "a002", "a003")), c("a001--003"))
})

test_that("numerals are not included in the prefix", {
  expect_equal(compress(c("101", "102", "103")), c("101--103"))
})

test_that("prefix containing numerals are correctly detected", {
  expect_equal(compress(paste0("a10y_", 101:103)), c("a10y_101--103"))
})

test_that("suffixes with duplicated numbers fail", {
  expect_error(compress(c("a1", "a001")), "duplicated numbers in suffixes")
})
