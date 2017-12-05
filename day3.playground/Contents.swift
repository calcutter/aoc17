//Advent of Code: Day 3
//http://adventofcode.com/2017/day/3
import Foundation

func calcMoveDistance(_ step: Int) -> Int {
    let root = sqrt(Double(step))
    let ceiling = Int(ceil(root))
    let halfCeiling = ceiling / 2
    let offset = step % 2 == 0 ? 0 : 1
    
    return halfCeiling + offset
}

calcMoveDistance(1) == 0
calcMoveDistance(2) == 1
calcMoveDistance(3) == 2
calcMoveDistance(4) == 1
calcMoveDistance(5) == 2
calcMoveDistance(6) == 1
calcMoveDistance(7) == 2
calcMoveDistance(8) == 1
calcMoveDistance(9) == 2
calcMoveDistance(12) //== 3
calcMoveDistance(23) //== 2
calcMoveDistance(24) //== 3
calcMoveDistance(25) //== 4
calcMoveDistance(1024) //== 31
calcMoveDistance(347991) // ?
