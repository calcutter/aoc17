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
    
    func moveCol() -> Int {
        switch self {
        case .left:
            return -1
        case .right:
            return 1
        default:
            return 0
        }
    }
    
    func moveRow() -> Int {
        switch self {
        case .up:
            return -1
        case .down:
            return 1
        default:
            return 0
        }
    }
}

func calcSquareLength(_ ring: Int) -> Int {
    return 1 + ring * 2
}

func nextValueBeyond(_ value: Int) -> Int {
    var currentDirection = Direction.down
    var currentRing = 0
    var squareLength = calcSquareLength(currentRing)
    var grid = Array(repeating: Array(repeating: 0, count: squareLength), count: squareLength)
    
    //Let's get the party started
    grid[0][0] = 1
    var lastValue = grid[0][0]
    var col = 0, row = 0
    
    let addRing: () -> () = {
        let lastSquareLength = squareLength
        currentRing += 1
        squareLength = calcSquareLength(currentRing)

        var newGrid: [[Int]] = Array(repeating: Array(repeating: 0, count: squareLength), count: squareLength)
        //Copy over
        for row in 0..<lastSquareLength {
            for col in 0..<lastSquareLength {
                newGrid[row+1][col+1] = grid[row][col]
            }
        }
        grid = newGrid
        col += 1
        row += 1
    }

    let calcValue: () -> Int = {
        var value = 0
        //Left
        if col > 0 {
            value += grid[row][col-1]
        }
        //Right
        if col < squareLength - 1 {
            value += grid[row][col+1]
        }
        //Up
        if row > 0 {
            value += grid[row - 1][col]
        }
        //Down
        if row < squareLength - 1 {
            value += grid[row + 1][col]
        }
        
        //Top Left
        if col > 0  && row > 0 {
            value += grid[row-1][col-1]
        }
        //Top Right
        if row > 0 && col < squareLength - 1 {
            value += grid[row - 1][col + 1]
        }
        
        //Bottom Right
        if col < squareLength - 1 && row < squareLength - 1 {
            value += grid[row+1][col+1]
        }
        //Bottom Left
        if row < squareLength - 1  && col > 0{
            value += grid[row + 1][col - 1]
        }
        
        grid[row][col] = value
        print("VALUE: \(value)")
        
        return value
    }
    
    while(lastValue <= value) {
        var turnDirection = currentDirection.turnDirection()
        var turnCol = col + turnDirection.moveCol()
        var turnRow = row + turnDirection.moveRow()
        
        print("turnCol: \(turnCol) turnRow: \(turnRow) squareLength: \(squareLength)")
        
        //turn is successful
        if turnRow < 0 || turnRow >= squareLength || turnCol < 0 || turnCol >= squareLength || grid[turnRow][turnCol] == 0 {
            print("making a turn like a boss")
            currentDirection = turnDirection
            if currentDirection == .right {
                addRing()
            }
        }
        
        col = col + currentDirection.moveCol()
        row = row + currentDirection.moveRow()
        
        lastValue = calcValue()
    }

    return lastValue
}

nextValueBeyond(2) == 4
nextValueBeyond(10) == 11
nextValueBeyond(11) == 23
nextValueBeyond(15) == 23
nextValueBeyond(26) == 54
nextValueBeyond(53) == 54
nextValueBeyond(500) == 747
nextValueBeyond(347991) == 349975
