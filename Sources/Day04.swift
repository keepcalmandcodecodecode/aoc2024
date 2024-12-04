import Algorithms
import RegexBuilder

struct Day04: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    var dataArray: [[Character]] {
        data.split(separator: "\n").map {
            return Array($0)
        }
    }

    func part1() -> Any {
        var result = 0
        let array = dataArray
        for i in 0..<array.count {
            let row = array[i]
            for j in 0..<row.count {
                if row[j] != "X" {
                    continue
                }
                if isWest(i: i, j: j, array: array) {
                    result += 1
                }
                if isEast(i: i, j: j, array: array) {
                    result += 1
                }
                if isNorth(i: i, j: j, array: array) {
                    result += 1
                }
                if isSouth(i: i, j: j, array: array) {
                    result += 1
                }

                if isWestSouth(i: i, j: j, array: array) {
                    result += 1
                }
                if isWestNorth(i: i, j: j, array: array) {
                    result += 1
                }
                if isEastSouth(i: i, j: j, array: array) {
                    result += 1
                }
                if isEastNorth(i: i, j: j, array: array) {
                    result += 1
                }
            }
        }
        return result
    }

    private func isWest(i: Int, j: Int, array: [[Character]]) -> Bool {
        let row = array[i]
        guard (j - 3) >= 0 else {
            return false
        }
        return row[j-1] == "M" && row[j-2] == "A" && row[j-3] == "S"
    }

    private func isEast(i: Int, j: Int, array: [[Character]]) -> Bool {
        let row = array[i]
        guard (j + 3) < row.count else {
            return false
        }
        return row[j+1] == "M" && row[j+2] == "A" && row[j+3] == "S"
    }

    private func isNorth(i: Int, j: Int, array: [[Character]]) -> Bool {
        guard (i - 3) >= 0 else {
            return false
        }
        return array[i-1][j] == "M" && array[i-2][j] == "A" && array[i-3][j] == "S"
    }

    private func isSouth(i: Int, j: Int, array: [[Character]]) -> Bool {
        guard (i + 3) < array.count else {
            return false
        }
        return array[i+1][j] == "M" && array[i+2][j] == "A" && array[i+3][j] == "S"
    }

    private func isWestNorth(i: Int, j: Int, array: [[Character]]) -> Bool {
        guard (i - 3) >= 0 && (j - 3) >= 0 else {
            return false
        }
        return array[i-1][j-1] == "M" && array[i-2][j-2] == "A" && array[i-3][j-3] == "S"
    }

    private func isEastNorth(i: Int, j: Int, array: [[Character]]) -> Bool {
        guard (i - 3) >= 0 && (j + 3) < array[i].count else {
            return false
        }
        return array[i-1][j+1] == "M" && array[i-2][j+2] == "A" && array[i-3][j+3] == "S"
    }

    private func isWestSouth(i: Int, j: Int, array: [[Character]]) -> Bool {
        guard (i + 3) < array.count && (j - 3) >= 0 else {
            return false
        }
        return array[i+1][j-1] == "M" && array[i+2][j-2] == "A" && array[i+3][j-3] == "S"
    }

    private func isEastSouth(i: Int, j: Int, array: [[Character]]) -> Bool {
        guard (i + 3) < array.count && (j + 3) < array[i].count else {
            return false
        }
        return array[i+1][j+1] == "M" && array[i+2][j+2] == "A" && array[i+3][j+3] == "S"
    }

    func part2() -> Any {
        var result = 0
        let array = dataArray
        for i in 0..<array.count {
            let row = array[i]
            for j in 0..<row.count {
                if row[j] != "A" {
                    continue
                }
                guard j-1 >= 0,
                      j+1 < row.count,
                      i-1 >= 0,
                      i+1 < array.count else {
                    continue
                }

                if (array[i-1][j-1] == "M" && array[i+1][j+1] == "S" ||
                    array[i-1][j-1] == "S" && array[i+1][j+1] == "M") &&
                    (array[i-1][j+1] == "M" && array[i+1][j-1] == "S" ||
                    array[i-1][j+1] == "S" && array[i+1][j-1] == "M") {
                    result += 1
                }
            }
        }
        return result
    }

}
