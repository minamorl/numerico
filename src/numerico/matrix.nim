type
  Matrix*[T: SomeNumber] = object
    rows: int
    cols: int
    data: seq[T]

proc initMatrix*[T](rows, cols: int, value: T = 0.0): Matrix[T] =
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

proc printMatrix*[T](m: Matrix[T]) =
  for i in 0 ..< m.rows:
    for j in 0 ..< m.cols:
      stdout.write m[i, j], " "
    stdout.write "\n"
