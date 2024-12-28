import Algorithms
import Foundation

struct Day11: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    static var resultCash = [Int: [Int]]()
    static var countCash = [Int: [Int: Int]]()//stone, iteration, count

    // Splits input data into its component parts and convert from string.
    var stones: [Int] {
        let result = data.split(separator: " ")
        let st = result.compactMap { Int($0.replacing("\n", with: "")) }
        return st
    }

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        return calc(stones: stones, iterationCount: 25)
    }

    private func calc(stones: [Int], iterationCount: Int) -> Int {
        if iterationCount == 0 {
            return 0
        }
        if iterationCount == 1 {
            var result = 0
            for stone in stones {
                if let cached = Day11.resultCash[stone] {
                    result += cached.count
                } else {
                    let blink = calcBlink(stone: stone)
                    Day11.resultCash[stone] = blink
                    result += blink.count
                }
            }
            return result
        }
        var result = 0
        for stone in stones {
            if let c = Day11.countCash[stone], let count = c[iterationCount] {
                result += count
                continue
            }
            let blink: [Int]
            if let cached = Day11.resultCash[stone] {
                blink = cached
            } else {
                blink = calcBlink(stone: stone)
                Day11.resultCash[stone] = blink
            }
            let current = calc(stones: blink, iterationCount: iterationCount - 1)
            if Day11.countCash[stone] != nil {
                Day11.countCash[stone]?[iterationCount] = current
            } else {
                Day11.countCash[stone] = [iterationCount: current]
            }
            result += current
        }
        return result
    }

    private func calcBlink(stone: Int) -> [Int] {
        let stoneString = String(stone)
        if stone == 0 {
            return [1]
        } else if stoneString.count%2 == 0 {
            let index = stoneString.index(stoneString.startIndex, offsetBy: stoneString.count/2)
            let prefix = stoneString.prefix(upTo: index)
            let suffix = stoneString.suffix(from: index)
            return [Int(prefix) ?? 0, Int(suffix) ?? 0]
        } else {
            return [stone*2024]
        }
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() async -> Any {
        let stones = self.stones
        let result = calc(stones: stones, iterationCount: 75)
        return result
    }
}
