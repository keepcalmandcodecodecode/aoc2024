import Algorithms
import RegexBuilder

struct Day03: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    func part1() -> Any {
        var result = 0
        let n0 = Reference(Int.self)
        let n1 = Reference(Int.self)
        let search = Regex {
            "mul("
            TryCapture(as: n0) {
                    OneOrMore(.digit)
            } transform: { match in
                    Int(match)
            }
            ","
            TryCapture(as: n1) {
                    OneOrMore(.digit)
            } transform: { match in
                    Int(match)
            }
            ")"
        }
        let matches = data.matches(of: search)
        for match in matches {
            result += match[n0] * match[n1]
        }
        return result
    }

    func part2() -> Any {
        var result = 0
        let n0 = Reference(Int.self)
        let n1 = Reference(Int.self)
        let search = Regex {
            "mul("
            TryCapture(as: n0) {
                    OneOrMore(.digit)
            } transform: { match in
                    Int(match)
            }
            ","
            TryCapture(as: n1) {
                    OneOrMore(.digit)
            } transform: { match in
                    Int(match)
            }
            ")"
        }
        let dos = Regex{
            "do()"
        }
        let donts = Regex {
            "don't()"
        }
        let doRanges = data.ranges(of: dos)
        let dontsRanges = data.ranges(of: donts)
        let matches = data.matches(of: search)

        for match in matches {
            let lb = match.range.lowerBound
            let doIndex = doRanges.last(where: {
                $0.lowerBound < lb
            })
            let dontIndex = dontsRanges.last(where: {
                $0.lowerBound < lb
            })
            var isSummarize = false
            if doIndex == nil && dontIndex == nil {
                isSummarize = true
            } else if let doIndex, let dontIndex {
                isSummarize = doIndex.lowerBound > dontIndex.lowerBound
            } else if (doIndex != nil), dontIndex == nil {
                isSummarize = true
            } else {
                isSummarize = false
            }
            if isSummarize {
                result += match[n0] * match[n1]
            }

        }
        return result
    }

}
