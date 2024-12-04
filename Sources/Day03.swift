import Algorithms

struct Day03: AdventDay {
  var data: String
  
  var entities: [(Int, Int, Range<String.Index>)] {
    data
      .matches(of: /mul\((?<lhs>\d+),(?<rhs>\d+)\)/)
      .compactMap { match in
        guard
          let lhs = Int(match.output.lhs),
          let rhs = Int(match.output.rhs)
        else { return nil }
        return (lhs, rhs, match.range)
      }
  }

  func part1() -> Any {
    entities
      .map { $0.0 * $0.1 }
      .reduce(0, +)
  }

  func part2() -> Any {
    let pos = data
      .matches(of: /(?<dont>don't\(\))|(?<do>do\(\))/)
      .compactMap { match -> (Bool, Range<String.Index>)? in
        if match.output.dont != nil {
          return (false, match.range)
        } else if match.output.do != nil {
          return (true, match.range)
        }
        return nil
      }

    let first: (Bool, Range<String.Index>) = (true, data.startIndex..<pos.first!.1.lowerBound)
    let last: (Bool, Range<String.Index>) = (pos.last!.0, pos.last!.1.upperBound..<data.endIndex)
    let middle = pos.adjacentPairs().map { ($0.0.0, $0.0.1.upperBound..<$0.1.1.lowerBound) }
    let ranges = [first] + middle + [last]
    
    return entities
      .filter { mul in
        ranges.first(where: { $0.1 ~= mul.2 })?.0 ?? false
      }
      .map { $0.0 * $0.1 }
      .reduce(0, +)
  }
}

fileprivate func ~=(lhs: Range<String.Index>, rhs: Range<String.Index>) -> Bool {
  lhs.lowerBound <= rhs.lowerBound && lhs.upperBound >= rhs.upperBound
}
