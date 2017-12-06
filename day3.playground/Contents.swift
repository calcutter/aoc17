//Advent of Code: Day 3
//http://adventofcode.com/2017/day/3
import Foundation

func calcMoveDistance(_ value: Int) -> Int {
    let root = sqrt(Double(value))
    let rootRoundedUp = Int(ceil(root))
    let ring = rootRoundedUp / 2 //NOTE: A value's ring is also the minimum possible number of steps
    let maxSteps = ring * 2
    
    let minValueSteps = maxSteps - 1
    let minValueForRing = minValueSteps * minValueSteps + 1
    
    let offsetWithinRing = value - minValueForRing
    
    //hmmmmmmmmmm
    if ring == 0 {
        return 0
    }
    
    let linearPosition = offsetWithinRing % maxSteps
    let linearMidpoint = minValueSteps / 2
    
    return ring + abs(linearMidpoint - linearPosition)
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

//PART 2
class Node {
    var value: Int
    var right: Node?
    var up: Node?
    var left: Node?
    var down: Node?
    
    init(_ value: Int = 0) {
        self.value = value
    }
    
    func calculateValue() {
        value = 0
        
        if let left = left {
            value += left.value
        }
        //value += top?.value
        //value += right?.value
        //value += down?.value
    }
}

func nextValueBeyond(_ value: Int) -> Int {
    var currentNode: Node = Node(1)
    var allocatorCounter: Int = 1
    var ring = 0
    var ringPosition = 0
    
    while currentNode.value <= value {
        var ringMaxSteps = (ring * 2)
        var ringMaxPosition = (ringMaxSteps + 1) * (ringMaxSteps + 1)
        
        ringPosition += 1
        //Shift right into new ring
        if ringPosition >= ringMaxPosition {
            ring += 1
            ringPosition = 0
            
            let newNode = Node()
            currentNode.right = newNode
            newNode.left = currentNode
            newNode.calculateValue()
            currentNode = newNode
        } else { //Keep spiraling ... out of control
            
        }
        break
    }
    
    return currentNode.value
}

nextValueBeyond(2) == 4
nextValueBeyond(10) == 11
nextValueBeyond(11) == 23
nextValueBeyond(15) == 23
nextValueBeyond(26) == 54
nextValueBeyond(53) == 54
nextValueBeyond(500) == 747
nextValueBeyond(347991)
