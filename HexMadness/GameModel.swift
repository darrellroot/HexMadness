//
//  GameModel.swift
//  HexMadness
//
//  Created by Darrell Root on 4/25/20.
//  Copyright © 2020 Darrell Root. All rights reserved.
//

import Foundation
import SwiftUI

class GameModel: ObservableObject {
    @Published var circles: [CircleModel]
    @Published var score: Int = 0
    public var pressedCircle: CircleModel? {
        didSet {
            for circle in circles {
                circle.pressed = false
            }
            pressedCircle?.pressed = true
        }
    }
    
    static let rows = 9 // must be odd
    static let columns = 8 // must be odd
    static let centerColumn = CGFloat(columns) / 2 // automatically rounds down
    static let centerRow = CGFloat(rows) / 2 // automaticaly rounds down

    func circle(row: Int, column: Int) -> CircleModel? {
        for circle in circles {
            if circle.row == row && circle.column == column {
                return circle
            }
        }
        return nil
    }
    func circle(hex: Hex) -> CircleModel? {
        for circle in circles {
            if circle.row == hex.row && circle.column == hex.column {
                return circle
            }
        }
        return nil
    }
    func occupied(row: Int, column: Int) -> Bool {
        for circle in circles {
            if circle.row == row && circle.column == column {
                return true
            }
        }
        return false
    }
    init() {
        circles = []
    }
    func newGame() {
        self.circles = []
        self.score = 0
        for _ in 0 ..< 6 {
            self.addCircle()
        }
    }
    static func allAdjacent(row: Int, column: Int) -> Set<Hex> {
    var adjacentHexes: Set<Hex> = []
        for candidateRow in 0 ..< GameModel.rows {
            for candidateColumn in 0 ..< GameModel.columns {
                if GameModel.adjacent(lrow: candidateRow, lcolumn: candidateColumn, rrow: row, rcolumn: column) {
                    let adjacentHex = Hex(row: candidateRow, column: candidateColumn)
                    adjacentHexes.insert(adjacentHex)
                }
            }
        }
        return adjacentHexes
    }
    
    func testForWin(pressedCircle: CircleModel) -> Bool {
        var winningCircles: [CircleModel] = [pressedCircle]
        var winningHexes: Set<Hex> = [pressedCircle.hex]
        var candidateHexes: Set<Hex> = [pressedCircle.hex]
        var analyzedHexes: Set<Hex> = [pressedCircle.hex]
        let pressedHex = Hex(row: pressedCircle.row, column: pressedCircle.column)
        while candidateHexes.count > 0 {
            let thisHex = candidateHexes.first!
            let adjacentHexes = thisHex.allAdjacent
            for adjacentHex in adjacentHexes {
                if !analyzedHexes.contains(adjacentHex) {
                    analyzedHexes.insert(adjacentHex)
                    if let adjacentCircle = circle(hex: adjacentHex), adjacentCircle.color == pressedCircle.color {
                        winningHexes.insert(adjacentHex)
                        winningCircles.append(adjacentCircle)
                        candidateHexes.insert(adjacentHex)
                    }
                } else {
                    // do nothing, neighbor hex already analyzed
                }
            }
            candidateHexes.remove(thisHex)
        }
        debugPrint("winningCircles count \(winningCircles.count)")
        if winningCircles.count >= 6 {
            debugPrint("you won!")
            for circle in winningCircles {
                if let index = circles.index(of: circle) {
                    circles.remove(at: index)
                } else {
                    debugPrint("unexpected remove error")
                }
            }
            return true
        } else {
            return false
        }
    }
    func testForValidMove(row: Int, column: Int) -> Bool {
        guard let pressedCircle = pressedCircle else {
            return false
        }
        var analyzedHexes: Set<Hex> = [pressedCircle.hex]
        var candidateHexes: Set<Hex> = pressedCircle.hex.allAdjacent
        candidateHexes: while candidateHexes.count > 0 {
            let candidateHex = candidateHexes.removeFirst()
            analyzedHexes.insert(candidateHex)
            guard circle(hex: candidateHex) == nil else {
                continue candidateHexes
            }
            if candidateHex.row == row && candidateHex.column == column {
                return true
            }
            let newCandidates = candidateHex.allAdjacent
            for newCandidate in newCandidates {
                if analyzedHexes.contains(newCandidate) {
                    // do nothing
                } else {
                    candidateHexes.insert(newCandidate)
                }
            }
        }
        return false
    }
    func move(row: Int, column: Int) {
        if let pressedCircle = pressedCircle, testForValidMove(row: row, column: column) {
            self.score += 1
            self.pressedCircle?.row = row
            self.pressedCircle?.column = column
            self.pressedCircle = nil
            let newCircles = Int.random(in: 3..<5)
            if testForWin(pressedCircle: pressedCircle) {
                // do nothing
            } else {
                // add circles
                for _ in 0..<newCircles {
                    self.addCircle()
                }
                
            }
            
        }
    }
    static func adjacent(lrow: Int, lcolumn: Int, rrow: Int, rcolumn: Int) -> Bool {
        if abs(lrow - rrow) >= 2 {
            return false
        }
        if abs(lcolumn - rcolumn) >= 2 {
            return false
        }
        if lrow == rrow && lcolumn == rcolumn {
            return false
        }
        // 2 cases
        if lcolumn == rcolumn && abs(lrow - rrow) == 1 {
            return true
        }
        // 2 cases
        if lrow == rrow && abs(lcolumn - rcolumn) == 1 {
            return true
        }
        if lcolumn % 2 == 0 && rcolumn % 2 == 1 && abs(lcolumn - rcolumn) == 1 && lrow == rrow - 1 {
            return true
        }
        if lcolumn % 2 == 1 && rcolumn % 2 == 0 && abs(lcolumn - rcolumn) == 1 && lrow == rrow - 1 {
            return true
        }
        return false
    }
    func addCircle() {
        //try 1000 times to add a circle
        // if that fails, we assume board is full and game over
        var row: Int = 0
        var column: Int = 0
        var added = false
        for _ in 0 ..< 1000 {
            row = Int.random(in: 0..<GameModel.rows)
            column = Int.random(in: 0..<GameModel.columns)
            if !occupied(row: row, column: column) {
                added = true
                break
            }
        }
        if !added {
            gameOver()
        } else {
            let circle = CircleModel(row: row, column: column)
            self.circles.append(circle)
            self.testForWin(pressedCircle: circle)
        }
    }
    func gameOver() {
        debugPrint("Game Over")
    }
    
    static func hexX(width: CGFloat, column: Int) -> CGFloat {
        let width = Int(width)
        let columnWidth = width / GameModel.columns
        return  (CGFloat(column) - GameModel.centerColumn) * CGFloat(columnWidth) + CGFloat(columnWidth) * 0.5
    }
    static func hexY(height: CGFloat, row: Int, column: Int) -> CGFloat {
        let height = Int(height)
        let rowHeight = height / GameModel.rows
        if  column % 2 == 0 {
            return (CGFloat(row) - GameModel.centerRow) * CGFloat(rowHeight) + CGFloat(rowHeight) / 2
        } else {
            return (CGFloat(row) - GameModel.centerRow) * CGFloat(rowHeight) + CGFloat(rowHeight)
        }
    }
    

}
