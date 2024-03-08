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
  ## Multiplies two matrices using matrix multiplication (inner product).
  assert a.cols == b.rows, "Matrix dimensions do not match for multiplication"
  result = initMatrix[T](a.rows, b.cols)
  for i in 0 ..< a.rows:
    for j in 0 ..< b.cols:
      for k in 0 ..< a.cols:
        result[i, j] = result[i, j] + T(a[i, k] * b[k, j])

proc `^`*[T: SomeNumber](a, b: Matrix[T]): Matrix[T] =
  ## Performs the outer product of two matrices.
  result = initMatrix[T](a.rows, b.cols)
  for i in 0 ..< a.rows:
    for j in 0 ..< b.cols:
      result[i, j] = a[i, 0] * b[0, j]

proc innerProduct*[T: SomeNumber](a, b: Matrix[T]): T =
  ## Calculates the inner product (dot product) of two matrices.
  assert a.rows == b.rows and a.cols == b.cols, "Matrix dimensions do not match for inner product"
  result = T(0)  # Initialize the result to zero
  for i in 0 ..< a.rows:
    for j in 0 ..< a.cols:
      result += a[i, j] * b[i, j]
