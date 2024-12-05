import Algorithms

struct Day04: AdventDay {
  var data: String
  
  enum Direction: CaseIterable {
    case u, d, l, r, ul, ur, dl, dr
    
    func next(from: (Int, Int), for map: [[Character]]) -> (Int, Int)? {
      switch self {
      case .u: from.1 - 1 >= 0 ? (from.0, y: from.1 - 1) : nil
      case .d: from.1 + 1 < map.count ? (from.0, y: from.1 + 1) : nil
      case .l: from.0 - 1 >= 0 ? (from.0 - 1, y: from.1) : nil
      case .r: from.0 + 1 < map[0].count ? (from.0 + 1, y: from.1) : nil
      case .ul: from.0 - 1 >= 0 && from.1 - 1 >= 0 ? (from.0 - 1, y: from.1 - 1) : nil
      case .ur: from.0 + 1 < map[0].count && from.1 - 1 >= 0 ? (from.0 + 1, y: from.1 - 1) : nil
      case .dl: from.0 - 1 >= 0 && from.1 + 1 < map.count ? (from.0 - 1, y: from.1 + 1) : nil
      case .dr: from.0 + 1 < map[0].count && from.1 + 1 < map.count ? (from.0 + 1, y: from.1 + 1) : nil
      }
    }
    
    func xmas(from: (Int, Int), with map: [[Character]]) -> Bool {
      guard let mPos = next(from: from, for: map) else { return false }
      let m = map[mPos.1][mPos.0]
      guard m == "M", let aPos = next(from: mPos, for: map) else { return false }
      let a = map[aPos.1][aPos.0]
      guard a == "A", let sPos = next(from: aPos, for: map) else { return false }
      return map[sPos.1][sPos.0] == "S"
    }
  }
  
  var entities: [[Character]] {
    data.split(separator: "\n").map {
      Array($0)
    }
  }

  func part1() -> Any {
    var count = 0
    let e = entities
    for (y, row) in e.enumerated() {
      for (x, char) in row.enumerated() {
        if char == "X" {
          count += Direction.allCases.count { $0.xmas(from: (x, y), with: e) }
        }
      }
    }
    
    return count
  }

  func part2() -> Any {
    var count = 0
    let e = entities
    for (y, row) in e.enumerated() {
      for (x, char) in row.enumerated() {
        if char == "A" {
          guard
            let ul = Direction.ul.next(from: (x, y), for: e),
            let dr = Direction.dr.next(from: (x, y), for: e),
            let ur = Direction.ur.next(from: (x, y), for: e),
            let dl = Direction.dl.next(from: (x, y), for: e)
          else { continue }
          
          let ulc = e[ul.1][ul.0]
          let drc = e[dr.1][dr.0]
          
          let urc = e[ur.1][ur.0]
          let dlc = e[dl.1][dl.0]
          
          let one = (urc == "M" && dlc == "S") || (urc == "S" && dlc == "M")
          let two = (ulc == "M" && drc == "S") || (ulc == "S" && drc == "M")
          count += one && two ? 1 : 0
        }
      }
    }
    
    return count
  }
}
