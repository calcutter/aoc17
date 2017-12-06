//Advent of Code: Day 3
//http://adventofcode.com/2017/day/3
import Foundation

func calcMoveDistance(_ value: Int) -> Int {
    let root = sqrt(Double(value))
    let ceiling = Int(ceil(root))
    let ring = ceiling / 2 //also minSteps
    let maxStepsForRing = ring * 2
    
    let minValueForRing = (ring * 2 - 1) * (ring * 2 - 1) + 1
    
    let squareLength = ring * 2 + 1
    
    let offsetWithinRing = value - minValueForRing
    
    if ring == 0 {
        return 0
    }
    
    let ringPosition = offsetWithinRing % maxStepsForRing
    
    let pivot = (maxStepsForRing - 1) / 2
    
    return ring + abs(pivot - ringPosition)
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
calcMoveDistance(12) == 3
calcMoveDistance(23) == 2
calcMoveDistance(24) == 3
calcMoveDistance(25) == 4
calcMoveDistance(49) == 6
calcMoveDistance(50) == 7
calcMoveDistance(1024) == 31
calcMoveDistance(347991) == 480
