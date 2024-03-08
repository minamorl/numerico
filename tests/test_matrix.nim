# tests/test_matrix.nim
import unittest
import numerico/matrix

suite "Matrix":
  test "Initialization":
    var m = initMatrix[int](2, 2)
    check m[0, 0] == 0
    check m[0, 1] == 0
    check m[1, 0] == 0
    check m[1, 1] == 0

  test "Accessing and modifying elements":
    var m = initMatrix[int](2, 2)
    m[0, 0] = 1
    m[0, 1] = 2
    m[1, 0] = 3
    m[1, 1] = 4
    check m[0, 0] == 1
    check m[0, 1] == 2
    check m[1, 0] == 3
    check m[1, 1] == 4

  test "Matrix properties":
    var m = initMatrix[int](3, 4)
    check m.rows == 3
    check m.cols == 4
    check m.shape == (3, 4)

  test "Matrix equality":
    var m1 = initMatrix[int](2, 2, 1)
    var m2 = initMatrix[int](2, 2, 1)
    var m3 = initMatrix[int](2, 2, 0)
    check m1 == m2
    check m1 != m3

  test "Matrix Multiplication (Inner Product)":
    var a = initMatrix[int](2, 3, 1)
    var b = initMatrix[int](3, 2, 2)
    var expected = initMatrix[int](2, 2)
    expected[0, 0] = 6
    expected[0, 1] = 6
    expected[1, 0] = 6
    expected[1, 1] = 6
    check (a * b) == expected

  test "Outer Product":
    var a = initMatrix[int](2, 1, 2)
    var b = initMatrix[int](1, 3, 3)
    var expected = initMatrix[int](2, 3)
    expected[0, 0] = 6
    expected[0, 1] = 6
    expected[0, 2] = 6
    expected[1, 0] = 6
    expected[1, 1] = 6
    expected[1, 2] = 6
    check (a ^ b) == expected

  test "Inner Product":
    var a = initMatrix[int](2, 2, 1)
    var b = initMatrix[int](2, 2, 2)
    var expected = 8
    check innerProduct(a, b) == expected

  test "Matrix Multiplication Dimensions Mismatch":
    var a = initMatrix[int](2, 3)
    var b = initMatrix[int](2, 3)
    expect AssertionError:
      discard a * b

  test "Inner Product Dimensions Mismatch":
    var a = initMatrix[int](2, 3)
    var b = initMatrix[int](3, 2)
    expect AssertionError:
      discard innerProduct(a, b)

  test "Matrix Transposition":
    var m = initMatrix[int](2, 3)
    m[0, 0] = 1
    m[0, 1] = 2
    m[0, 2] = 3
    m[1, 0] = 4
    m[1, 1] = 5
    m[1, 2] = 6

    var expected = initMatrix[int](3, 2)
    expected[0, 0] = 1
    expected[0, 1] = 4
    expected[1, 0] = 2
    expected[1, 1] = 5
    expected[2, 0] = 3
    expected[2, 1] = 6

    check transpose(m) == expected

  test "Matrix Determinant":
    var m1 = initMatrix[float](2, 2)
    m1[0, 0] = 1.0
    m1[0, 1] = 2.0
    m1[1, 0] = 3.0
    m1[1, 1] = 4.0
    check determinant(m1) == -2.0

    var m2 = initMatrix[float](3, 3)
    m2[0, 0] = 1.0
    m2[0, 1] = 2.0
    m2[0, 2] = 3.0
    m2[1, 0] = 4.0
    m2[1, 1] = 5.0
    m2[1, 2] = 6.0
    m2[2, 0] = 7.0
    m2[2, 1] = 8.0
    m2[2, 2] = 9.0
    check determinant(m2) == 0.0

  test "Matrix Determinant - Non-square Matrix":
    var m = initMatrix[float](2, 3)
    expect AssertionDefect:
      discard determinant(m)
