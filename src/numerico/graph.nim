import matrix, deques, algorithm

type
  Graph* = object
    vertices: int
    adj_matrix: Matrix[int]

proc initGraph*(vertices: int): Graph =
  result.vertices = vertices
  result.adj_matrix = initMatrix[int](vertices, vertices, 0)

proc addEdge*(g: var Graph, src, dest: int, weight: int = 1) =
  g.adj_matrix[src, dest] = weight
  g.adj_matrix[dest, src] = weight

proc hasEdge*(g: Graph, src, dest: int): bool =
  g.adj_matrix[src, dest] != 0

proc numVertices*(g: Graph): int =
  g.vertices

proc numEdges*(g: Graph): int =
  var count = 0
  for i in 0 ..< g.vertices:
    for j in i+1 ..< g.vertices:
      if g.adj_matrix[i, j] != 0:
        count += 1
  count

proc degree*(g: Graph, vertex: int): int =
  var count = 0
  for i in 0 ..< g.vertices:
    if g.adj_matrix[vertex, i] != 0:
      count += 1
  count

proc neighbors*(g: Graph, vertex: int): seq[int] =
  result = @[]
  for i in 0 ..< g.vertices:
    if g.adj_matrix[vertex, i] != 0:
      result.add(i)

proc dfs*(g: Graph, start: int, visited: var seq[bool], order: var seq[int]) =
  visited[start] = true
  order.add(start)
  for neighbor in g.neighbors(start):
    if not visited[neighbor]:
      g.dfs(neighbor, visited, order)

proc dfsTraversal*(g: Graph, start: int): seq[int] =
  var visited = newSeq[bool](g.vertices)
  var order: seq[int] = @[]
  g.dfs(start, visited, order)
  order

proc bfs*(g: Graph, start: int, visited: var seq[bool], order: var seq[int]) =
  var queue = initDeque[int]()
  visited[start] = true
  queue.addLast(start)
  while queue.len > 0:
    let vertex = queue.popFirst()
    order.add(vertex)
    for i in 0..<g.vertices:
      if g.hasEdge(vertex, i) and not visited[i]:
        visited[i] = true
        queue.addLast(i)

proc bfsTraversal*(g: Graph, start: int): seq[int] =
  var visited = newSeq[bool](g.vertices)
  var order: seq[int] = @[]
  g.bfs(start, visited, order)
  order

proc countComponents*(g: Graph): int =
  var visited = newSeq[bool](g.vertices)
  var count = 0
  for v in 0 ..< g.vertices:
    if not visited[v]:
      var order: seq[int] = @[]
      g.dfs(v, visited, order)
      count += 1
  count
