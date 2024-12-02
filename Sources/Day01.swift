import Algorithms

struct Day01: AdventDay {
  var data: String
  
  var entities: ([Int], [Int]) {
    data
      .split(separator: "\n")
      .compactMap { line -> (Int, Int)? in
        guard
          let match = line.wholeMatch(of: /(?<l>\d+)\s{3}(?<r>\d+)/),
          let l = Int(match.output.l),
          let r = Int(match.output.r)
        else { return nil }
        
        return (l, r)
      }
      .reduce(into: ([Int](), [Int]())) { acc, i in
        let (l, r) = i
        acc.0.append(l)
        acc.1.append(r)
      }
  }
  
  func part1() -> Any {
    let (l, r) = entities
    
    let lSort = l.sorted()
    let rSort = r.sorted()
    
    return zip(lSort, rSort)
      .map { abs($0.0 - $0.1) }
      .reduce(0, +)
  }
  
  func part2() -> Any {
    let (l, r) = entities
    
    let map = Dictionary
      .init(grouping: r, by: { $0 })
      .mapValues(\.count)
    
    return l
      .map { $0 * map[$0, default: 0] }
      .reduce(0, +)
  }
}
