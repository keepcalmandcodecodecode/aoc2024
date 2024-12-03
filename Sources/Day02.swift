import Algorithms

struct Day02: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Splits input data into its component parts and convert from string.
    var entities: [[Int]] {
        data.split(separator: "\n").map {
            $0.split(separator: " ").compactMap { Int($0) }
        }
    }

    func part1() -> Any {
        let entities = self.entities
        var count = 0
        for j in 0..<entities.count {
            let row = entities[j]
            if isCorrectReport(row: row) {
                count += 1
            }
        }

        return count
    }

    func isCorrectReport(row: [Int]) -> Bool {
        indexOfError(row: row) == -1
    }

    func indexOfError(row: [Int]) -> Int {
        var isIncreasing: Bool? = nil

        var i = 0
        var isExit = false
        while i < row.count && !isExit {
            if i == 0 {
                i = i + 1
                continue
            } else {
                let diff = row[i] - row[i-1]
                var isSafe = true
                if let isIncreasing {
                    isSafe = isIncreasing == (diff > 0)
                } else {
                    isIncreasing = diff > 0
                }
                isSafe = isSafe && (abs(diff) >= 1 && abs(diff) <= 3)
                if isSafe && (i == row.count - 1) {
                    return -1
                } else if !isSafe {
                    isExit = true
                    return i
                }
            }
            i = i + 1
        }
        return -1
    }

    func part2() -> Any {
        let entities = self.entities
        var count = 0
        for j in 0..<entities.count {
            var row = entities[j]
            var index = indexOfError(row: row)
            if index == -1 {
                count += 1
                continue
            }
            let index2 = indexOfError(row: row.reversed())
            row.remove(at: index)
            index = indexOfError(row: row)
            if index == -1 {
                count += 1
                continue
            }
            row = entities[j].reversed()
            row.remove(at: index2)
            index = indexOfError(row: row)
            if index == -1 {
                count += 1
                continue
            }
        }

        return count
    }

}
