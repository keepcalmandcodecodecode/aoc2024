import Algorithms
import RegexBuilder

struct Day05: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    func part1() -> Any {
        var result = 0
        let arrays = data.split(separator: "\n\n")
        let rules = arrays[0].split(separator: "\n")
        var ruleDictionary = [Int: [Int]]()
        for rule in rules {
            let splitted = rule.split(separator: "|").map({ Int($0) ?? 0 })
            var array = ruleDictionary[splitted[0]] ?? []
            array.append(splitted[1])
            ruleDictionary[splitted[0]] = array
        }
        let updates = arrays[1].split(separator: "\n").map({ $0.split(separator: ",").map({ Int($0) ?? 0 }) })
        for update in updates {
            let numbersCount = update.count
            let mid = numbersCount/2
            let midNumber = update[mid]
            if isCorrect(rules: ruleDictionary, update: update).0 {
                result += midNumber
            }
        }
        return result
    }

    func isCorrect(rules: [Int: [Int]], update: [Int]) -> (Bool,Int, Bool) {
        let count = update.count
        var result = true
        for i in 0..<count {
            let num = update[i]
            guard let rule = rules[num] else {
                continue
            }
            let subarray = update.suffix(from: i+1)
            let prearray = update.prefix(upTo: i)
            for subNum in subarray {
                result = result && rule.contains(subNum)
                if let subrule = rules[subNum] {
                    result = result && !subrule.contains(num)
                }
                if !result {
                    return (false,i,true)
                }
            }
            for preNum in prearray {
                result = result && !rule.contains(preNum)
                if !result {
                    return (false,i,false)
                }
            }


        }
        return (result,-1, false)
    }

    func part2() -> Any {
        var result = 0
        let arrays = data.split(separator: "\n\n")
        let rules = arrays[0].split(separator: "\n")
        var ruleDictionary = [Int: [Int]]()
        for rule in rules {
            let splitted = rule.split(separator: "|").map({ Int($0) ?? 0 })
            var array = ruleDictionary[splitted[0]] ?? []
            array.append(splitted[1])
            ruleDictionary[splitted[0]] = array
        }
        let updates = arrays[1].split(separator: "\n").map({ $0.split(separator: ",").map({ Int($0) ?? 0 }) })
        for update in updates {
            let numbersCount = update.count
            let mid = numbersCount/2

            let resIsCorrect = isCorrect(rules: ruleDictionary, update: update)

            if !resIsCorrect.0 {
                let updated = update.sorted { first, second in
                    let r1 = ruleDictionary[first] ?? []
                    return r1.contains(second)
                }
                let midNumber = updated[mid]
                result += midNumber
            }
        }
        return result
    }

}
