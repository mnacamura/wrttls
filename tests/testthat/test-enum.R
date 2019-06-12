context("test-enum")

test_that("empty vector is translated to empty string", {
    expect_equal(enum_inline(c()), "")
    expect_equal(enum_bullet(c()), "")
    expect_equal(enum_numbered(c()), "")
})

test_that("inline enumeration has default punctuation ','", {
    expect_equal(enum_inline(1:3), "1, 2, and 3")
})

test_that("inline enumeration works correctly", {
    expect_equal(enum_inline(1), "1")
    expect_equal(enum_inline(1:2), "1 and 2")
    expect_equal(enum_inline(1:3, sep = ";"), "1; 2; and 3")
})

test_that("bullet lists have default bullet '-'", {
    expect_equal(enum_bullet(1:2), "- 1\n- 2")
})

test_that("bullet lists can have any bullet point", {
    expect_equal(enum_bullet(1:2, bullet = "*"), "* 1\n* 2")
})

test_that("numbered lists have default initial number 1", {
    expect_equal(enum_numbered(1:2), "1. 1\n2. 2")
})

test_that("numbered lists can be started with any initial number", {
    expect_equal(enum_numbered(1:3, init = 4), "4. 1\n5. 2\n6. 3")
})

test_that("numbered lists have numbers justified left", {
    expect_equal(enum_numbered(1:3, init = 8), "8.  1\n9.  2\n10. 3")
})

test_that("enum works correctly", {
    expect_equal(enum(1:3), "1, 2, and 3")
    expect_equal(enum(1:3, bullet = F), "1, 2, and 3")
    expect_equal(enum(1:3, init = F), "1, 2, and 3")
    expect_equal(enum(1:3, bullet = T), "- 1\n- 2\n- 3")
    expect_equal(enum(1:3, bullet = "+"), "+ 1\n+ 2\n+ 3")
    expect_equal(enum(1:3, init = T), "1. 1\n2. 2\n3. 3")
    expect_equal(enum(1:3, init = 10), "10. 1\n11. 2\n12. 3")
})

test_that("in enum, init lists precede bullet lists", {
    expect_equal(enum(1:3, bullet = T, init = 10), "10. 1\n11. 2\n12. 3")
})
