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
enum Direction {
    case left, up, down, right
    
    func turnDirection() -> Direction {
        switch self {
        case .left:
            return .down
        case .up:
            return .left
        case .down:
            return .right
        case .right:
            return .up
        }
    }
}

class Node {
    var value: Int
    var topLeft, top, topRight, left, right, bottomLeft, bottom, bottomRight: Node?

    init(_ value: Int = 0) {
        self.value = value
    }
    
    func calculateValue() {
        value = 0

        value += topLeft?.value ?? 0
        value += top?.value ?? 0
        value += topRight?.value ?? 0
        value += left?.value ?? 0
        value += right?.value ?? 0
        value += bottomLeft?.value ?? 0
        value += bottom?.value ?? 0
        value += bottomRight?.value ?? 0
    }
    
    func getNeighbor(_ direction: Direction) -> Node? {
        switch direction {
        case .left:
            return left
        case .up:
            return top
        case .down:
            return bottom
        case .right:
            return right
        }
    }
    
    func setNeighbor(_ direction: Direction, _ node: Node) {
        switch direction {
        case .left:
            left = node
            node.right = self
            node.top = topLeft
            node.bottom = bottomLeft
            node.topRight = top
            node.bottomRight = bottom
        case .up:
            top = node
            node.bottom = self
            node.left = topLeft
            node.right = topRight
            node.bottomLeft = left
            node.bottomRight = right
        case .down:
            bottom = node
            node.top = self
            node.left = bottomLeft
            node.right = bottomRight
            node.topLeft = left
            node.topRight = right
        case .right:
            right = node
            node.left = self
            node.top = topRight
            node.bottom = bottomRight
            node.topLeft = top
            node.bottomLeft = bottom
        }
    }
}

func nextValueBeyond(_ value: Int) -> Int {
    var currentNode: Node = Node(1)
    var currentDirection = Direction.down
    
    while currentNode.value <= value {
        var turnDirection = currentDirection.turnDirection()
        if currentNode.getNeighbor(turnDirection) == nil {
            print("Turning from \(currentDirection) to \(turnDirection)")
            currentDirection = turnDirection
        } else {
            print("Marching \(currentDirection)")
        }
        
        let newNode = Node()
        currentNode.setNeighbor(currentDirection, newNode)
        newNode.calculateValue()
        currentNode = newNode
        
        print("Current Node Value: \(currentNode.value) and Direction: \(currentDirection)")
    }
    
    return currentNode.value
}

//nextValueBeyond(2) == 4
//nextValueBeyond(10) == 11
nextValueBeyond(11) == 23
nextValueBeyond(15) == 23
nextValueBeyond(26) == 54
nextValueBeyond(53) == 54
nextValueBeyond(500) == 747
nextValueBeyond(347991)
