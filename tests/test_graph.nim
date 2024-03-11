import unittest
import numerico/graph

suite "Graph":
  test "Initialize graph":
    let g = initGraph(5)
    check(g.numVertices == 5)
    check(g.numEdges == 0)

  test "Add edges":
    var g = initGraph(5)
    g.addEdge(0, 1)
    g.addEdge(0, 4)
    g.addEdge(1, 2)
    g.addEdge(1, 3)
    g.addEdge(1, 4)
    g.addEdge(2, 3)
    g.addEdge(3, 4)
    check(g.numEdges == 7)

  test "Has edge":
    var g = initGraph(5)
    g.addEdge(0, 1)
    g.addEdge(1, 2)
    check(g.hasEdge(0, 1) == true)
    check(g.hasEdge(1, 2) == true)
    check(g.hasEdge(0, 2) == false)

  test "Degree":
    var g = initGraph(5)
    g.addEdge(0, 1)
    g.addEdge(0, 4)
    g.addEdge(1, 2)
    g.addEdge(1, 3)
    check(g.degree(0) == 2)
    check(g.degree(1) == 3)
    check(g.degree(2) == 1)

  test "Neighbors":
    var g = initGraph(5)
    g.addEdge(0, 1)
    g.addEdge(0, 4)
    g.addEdge(1, 2)
    g.addEdge(1, 3)
    check(g.neighbors(0) == @[1, 4])
    check(g.neighbors(1) == @[0, 2, 3])
    check(g.neighbors(2) == @[1])

  test "DFS traversal":
    var g = initGraph(5)
    g.addEdge(0, 1)
    g.addEdge(0, 2)
    g.addEdge(1, 2)
    g.addEdge(2, 0)
    g.addEdge(2, 3)
    g.addEdge(3, 3)
    let dfsOrder = g.dfsTraversal(2)
    check(dfsOrder == @[2, 0, 1, 3])

  test "BFS traversal":
    var g = initGraph(5)
    g.addEdge(0, 1)
    g.addEdge(0, 2)
    g.addEdge(1, 2)
    g.addEdge(2, 3)
    g.addEdge(2, 0)
    g.addEdge(3, 3)
    let bfsOrder = g.bfsTraversal(2)
    check(bfsOrder == @[2, 0, 1, 3])

  test "Count components":
    var g = initGraph(5)
    g.addEdge(0, 1)
    g.addEdge(1, 2)
    g.addEdge(3, 4)
    check(g.countComponents == 2)
