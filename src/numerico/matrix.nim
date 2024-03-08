type
  Matrix*[T: SomeNumber] = object
    rows: int
    cols: int
    data: seq[T]

proc initMatrix*[T: SomeNumber](rows, cols: int, value: T = 0): Matrix[T] =
  result.rows = rows
  result.cols = cols
  result.data = newSeq[T](rows * cols)
  for i in 0 ..< rows * cols:
    result.data[i] = value

proc `[]`*[T](m: Matrix[T], i, j: int): T =
  m.data[i * m.cols + j]

proc `[]=`*[T](m: var Matrix[T], i, j: int, value: T) =
  m.data[i * m.cols + j] = value

proc rows*[T](m: Matrix[T]): int =
  m.rows

proc cols*[T](m: Matrix[T]): int =
  m.cols

proc shape*[T](m: Matrix[T]): (int, int) =
  (m.rows, m.cols)

proc `$`*[T](m: Matrix[T]): string =
  result = ""
  for i in 0 ..< m.rows:
    result &= "["
    for j in 0 ..< m.cols:
      result &= $m[i, j]
      if j < m.cols - 1:
        result &= ", "
    result &= "]\n"

proc `*`*[T: SomeNumber](a, b: Matrix[T]): Matrix[T] =
  assert a.cols == b.rows, "Matrix dimensions do not match for multiplication"
  result = initMatrix[T](a.rows, b.cols)
  for i in 0 ..< a.rows:
    for j in 0 ..< b.cols:
      for k in 0 ..< a.cols:
        result[i, j] = result[i, j] + T(a[i, k] * b[k, j])

proc `^`*[T: SomeNumber](a, b: Matrix[T]): Matrix[T] =
  result = initMatrix[T](a.rows, b.cols)
  for i in 0 ..< a.rows:
    for j in 0 ..< b.cols:
      result[i, j] = a[i, 0] * b[0, j]

proc innerProduct*[T: SomeNumber](a, b: Matrix[T]): T =
  assert a.rows == b.rows and a.cols == b.cols, "Matrix dimensions do not match for inner product"
  result = T(0)
  for i in 0 ..< a.rows:
    for j in 0 ..< a.cols:
      result += a[i, j] * b[i, j]

proc transpose*[T](m: Matrix[T]): Matrix[T] =
  ## Returns the transpose of a matrix.
  result = initMatrix[T](m.cols, m.rows)
  for i in 0 ..< m.rows:
    for j in 0 ..< m.cols:
      result[j, i] = m[i, j]

proc toFloat[T: SomeNumber](x: T): float =
  when T is SomeFloat:
    result = x
  else:
    result = x.float

proc determinant*[T: SomeFloat](m: Matrix[T]): T =
  ## Calculates the determinant of a square matrix using Gaussian elimination.
  assert m.rows == m.cols, "Matrix must be square to calculate the determinant"
  var a = m
  var det = T(1)
  for i in 0 ..< a.rows:
    var pivotRow = i
    for j in i+1 ..< a.rows:
      if abs(a[j, i]) > abs(a[pivotRow, i]):
        pivotRow = j
    if pivotRow != i:
      for k in 0 ..< a.cols:
        let temp = a[i, k]
        a[i, k] = a[pivotRow, k]
        a[pivotRow, k] = temp
      det = -det
    let pivot = a[i, i]
    if pivot == 0:
      return T(0)
    for j in i+1 ..< a.rows:
      let factor = a[j, i] / pivot
      for k in i+1 ..< a.cols:
        a[j, k] = a[j, k] - factor * a[i, k]
    det *= pivot
  return det

proc `*`*[T: SomeNumber](m: Matrix[T], scalar: T): Matrix[T] =
  ## Multiplies a matrix by a scalar value.
  result = initMatrix[T](m.rows, m.cols)
  for i in 0 ..< m.rows:
    for j in 0 ..< m.cols:
      result[i, j] = m[i, j] * scalar
