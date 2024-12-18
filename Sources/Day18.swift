import Algorithms
import Foundation

struct Day18: AdventDay {

    enum Size {
        static let maxRow = 71
        static let maxColumn = 71
        static let maxCorrupted = 1024
    }

    struct Position {
        let row: Int
        let column: Int
    }

    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {

        let grid = makeGrid()
        var path: [[Int]] = (0 ..< Size.maxRow).map({ _ in (0 ..< Size.maxColumn).map { _ in -1 } })

        var stop = false
        var d = 0
        var i = 0
        var j = 0
        path[i][j] = d
        var waves: [Int: [Position]] = [Int: [Position]]()
        waves[d] = [Position]()
        waves[d]?.append(Position(row: 0, column: 0))
        while (!stop) {
            let currentWave = waves[d] ?? []
            for pos in currentWave {
                i = pos.row
                j = pos.column
                if waves[d+1] == nil {
                    waves[d+1] = [Position]()
                }
                // top
                if (i-1) >= 0 {
                    if path[i-1][j] == -1 && grid[i-1][j] == "." {
                        path[i-1][j] = d + 1
                        waves[d+1]?.append(Position(row: i-1, column: j))
                    }
                }
                // right
                if (j+1) < Size.maxColumn {
                    if path[i][j+1] == -1 && grid[i][j+1] == "." {
                        path[i][j+1] = d + 1
                        waves[d+1]?.append(Position(row: i, column: j+1))
                    }
                }
                // left
                if (j-1) >= 0 {
                    if path[i][j-1] == -1 && grid[i][j-1] == "." {
                        path[i][j-1] = d + 1
                        waves[d+1]?.append(Position(row: i, column: j-1))
                    }
                }
                // bottom
                if (i+1) < Size.maxRow {
                    if path[i+1][j] == -1 && grid[i+1][j] == "." {
                        path[i+1][j] = d + 1
                        waves[d+1]?.append(Position(row: i+1, column: j))
                    }
                }
            }
            d = d + 1
            stop = (path[Size.maxRow-1][Size.maxColumn-1] != -1) || waves[d] == nil
        }
        return path[Size.maxRow-1][Size.maxColumn-1]
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let corrupted = corruptedCutted()
        var grid = makeGrid()
        for corrupt in corrupted {
            grid[corrupt.row][corrupt.column] = "#"
            if !hasPath(grid: grid) {
                return "\(corrupt.column),\(corrupt.row)"
            }
        }
        return "-1,-1"
    }
    
    private func hasPath(grid: [[Character]]) -> Bool {
        var path: [[Int]] = (0 ..< Size.maxRow).map({ _ in (0 ..< Size.maxColumn).map { _ in -1 } })
        var stop = false
        var d = 0
        var i = 0
        var j = 0
        path[i][j] = d
        var waves: [Int: [Position]] = [Int: [Position]]()
        waves[d] = [Position]()
        waves[d]?.append(Position(row: 0, column: 0))
        while (!stop) {
            let currentWave = waves[d] ?? []
            for pos in currentWave {
                i = pos.row
                j = pos.column
                if waves[d+1] == nil {
                    waves[d+1] = [Position]()
                }
                // top
                if (i-1) >= 0 {
                    if path[i-1][j] == -1 && grid[i-1][j] == "." {
                        path[i-1][j] = d + 1
                        waves[d+1]?.append(Position(row: i-1, column: j))
                    }
                }
                // right
                if (j+1) < Size.maxColumn {
                    if path[i][j+1] == -1 && grid[i][j+1] == "." {
                        path[i][j+1] = d + 1
                        waves[d+1]?.append(Position(row: i, column: j+1))
                    }
                }
                // left
                if (j-1) >= 0 {
                    if path[i][j-1] == -1 && grid[i][j-1] == "." {
                        path[i][j-1] = d + 1
                        waves[d+1]?.append(Position(row: i, column: j-1))
                    }
                }
                // bottom
                if (i+1) < Size.maxRow {
                    if path[i+1][j] == -1 && grid[i+1][j] == "." {
                        path[i+1][j] = d + 1
                        waves[d+1]?.append(Position(row: i+1, column: j))
                    }
                }
            }
            d = d + 1
            stop = (path[Size.maxRow-1][Size.maxColumn-1] != -1) || waves[d] == nil
        }
        return path[Size.maxRow-1][Size.maxColumn-1] != -1
    }

    private func findFirstFall(d: Int, waves: [Int: [Position]]) -> Position {
        for i in (1...d).reversed() {
            if i != d, let wave = waves[i], wave.count == 1, let pos = wave.first {
                return pos
            }
        }
        return .init(row: -1, column: -1)
    }

    func corruptedCutted() -> [Position] {
        let corrupted = data.split(separator: "\n").map({
            let result = $0.split(separator: ",").map({ Int($0) ?? 0 })
            return Position(row: result[1], column: result[0])
        })
        return Array(corrupted.suffix(from: Size.maxCorrupted-1))
    }

    func makeGrid() -> [[Character]] {
        let corrupted = data.split(separator: "\n").map({
            let result = $0.split(separator: ",").map({ Int($0) ?? 0 })
            return Position(row: result[1], column: result[0])
        })
        var gridArray: [[Character]] = (0 ..< Size.maxRow).map({ _ in (0 ..< Size.maxColumn).map { _ in "." } })
        let firstCorrupted = corrupted.prefix(Size.maxCorrupted)
        for corrupt in firstCorrupted {
            gridArray[corrupt.row][corrupt.column] = "#"
        }
        return gridArray
    }

}
