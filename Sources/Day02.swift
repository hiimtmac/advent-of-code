import Algorithms

struct Day02: AdventDay {
  var data: String

  var entities: [[Int]] {
    data.split(separator: "\n").map {
      $0.split(separator: " ").compactMap { Int($0) }
    }
  }

  func part1() -> Any {
    entities
      .filter(\.isSafe)
      .count
  }

  func part2() -> Any {
    entities
      .filter(\.safeIfRemoved)
      .count
  }
}

extension Array<Int> {
  fileprivate var isSafe: Bool {
    let differences = zip(self, self.dropFirst()).map { $0 - $1 }
    
    return differences.dropFirst().allSatisfy { difference in
      let og = differences[0]
      return difference.safe && og.safe && difference.signum() == og.signum()
    }
  }
  
  fileprivate var safeIfRemoved: Bool {
    let sequences = self.enumerated().map { idx, _ in
      self.enumerated().compactMap { i, val in
        i == idx ? nil : val
      }
    }
    
    return sequences.contains { $0.isSafe }
  }
}

extension Int {
  var safe: Bool {
    (1...3).contains(abs(self))
  }
}
