import Algorithms
import Foundation

struct Day23: AdventDay {

    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        let connections = parseConnections()
        var connectionTree = [String: [String]]()
        for connection in connections {
            if let part = connectionTree[connection[0]] {
                var part = part
                part.append(connection[1])
                connectionTree[connection[0]] = part
            } else {
                connectionTree[connection[0]] = [connection[1]]
            }
            if let part = connectionTree[connection[1]] {
                var part = part
                part.append(connection[0])
                connectionTree[connection[1]] = part
            } else {
                connectionTree[connection[1]] = [connection[0]]
            }
        }
        var trisets = [[String]]()
        for key in connectionTree.keys {
            if let nodes = connectionTree[key] {
                if nodes.count < 2 {
                    continue
                }
                for node1 in nodes {
                    for node2 in nodes {
                        if (connectionTree[node1] ?? []).contains(key) && (connectionTree[node2] ?? []).contains(key) && (connectionTree[node1] ?? []).contains(node2) && (connectionTree[node2] ?? []).contains(node1) {
                            let c = [key,node1,node2].sorted()
                            if !trisets.contains(c) {
                                trisets.append(c)
                            }
                        }
                    }
                }
            }

        }
        var result = 0
        for triset in trisets {
            if triset.first(where: { $0.starts(with: "t")}) != nil {
                result += 1
            }
        }
        return result
    }

    // Replace this with your solution for the second part of the day's challenge.

    func part2() -> Any {
        let connections = parseConnections()
        var connectionTree = [String: [String]]()
        for connection in connections {
            if let part = connectionTree[connection[0]] {
                var part = part
                part.append(connection[1])
                connectionTree[connection[0]] = part
            } else {
                connectionTree[connection[0]] = [connection[1]]
            }
            if let part = connectionTree[connection[1]] {
                var part = part
                part.append(connection[0])
                connectionTree[connection[1]] = part
            } else {
                connectionTree[connection[1]] = [connection[0]]
            }
        }

        var candidates: [[String]] = []
        for key in connectionTree.keys {
            if let connectionsByKey = connectionTree[key] {
                var connectionsByKey = connectionsByKey
                for c in connectionsByKey {
                    var withoutC = connectionsByKey
                    withoutC.removeAll(where: { $0 == c })
                    var candidate = [String]()
                    for wC in withoutC {
                        if let con = connectionTree[c] {
                            if con.contains(wC) && check(tree: connectionTree, candidate: candidate, newC: wC) {
                                candidate.append(wC)
                            }
                        }
                    }
                    candidate.append(c)
                    candidate.append(key)
                    let cSorted = candidate.sorted()
                    if !candidates.contains(cSorted) {
                        candidates.append(cSorted)
                    }
                }
            }
        }
        let sorted = candidates.sorted(by: { $0.count > $1.count } )
        var first = sorted[0]
        first.sort()
        let result = first.joined(separator: ",")
        return result
    }

    func check(tree: [String: [String]], candidate: [String], newC: String) -> Bool {
        for c in candidate {
            if let node = tree[c] {
                if !node.contains(newC) {
                    return false
                }
            }
        }
        return true
    }

    func parseConnections() -> [[String]] {
        var result = [[String]]()
        let strings = data.split(separator: "\n")
        for str in strings {
            let parts = str.split(separator: "-").map({ String($0) })
            result.append([parts[0], parts[1]])
        }
        return result
    }
}
