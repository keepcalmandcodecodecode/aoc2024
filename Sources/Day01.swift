import Algorithms

struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Splits input data into its component parts and convert from string.
    var entities: [[Int]] {
        var array = [[Int]]()
        array.append([])
        array.append([])
        data.split(separator: "\n").map {
            let result = $0.split(separator: " ").compactMap { Int($0) }
            array[0].append(result[0])
            array[1].append(result[1])
        }
        return array
    }

    func part1() -> Any {
        let sortedArray1 = entities[0].sorted()
        let sortedArray2 = entities[1].sorted()
        var sum = 0
        for i in 0..<sortedArray1.count {
            sum += abs(sortedArray1[i]-sortedArray2[i])
        }
        return sum
    }

    func part2() -> Any {
        let array1 = entities[0]
        let array2 = entities[1]
        let result = array1.reduce(0) { partialResult, item in
            partialResult + array2.filter({ $0 == item }).count * item
        }
        return result
    }

}
