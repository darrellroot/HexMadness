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
    public var pressedCircle: CircleModel?
    
    static let rows = 9 // must be odd
    static let columns = 8 // must be odd
    static let centerColumn = CGFloat(columns) / 2 // automatically rounds down
    static let centerRow = CGFloat(rows) / 2 // automaticaly rounds down

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
    func move(row: Int, column: Int) {
        if pressedCircle != nil {
            self.score += 1
            self.pressedCircle?.row = row
            self.pressedCircle?.column = column
            self.pressedCircle = nil
            let newCircles = Int.random(in: 3..<5)
            for _ in 0..<newCircles {
                self.addCircle()
            }
        }
    }
    func adjacent(lrow: Int, lcolumn: Int, rrow: Int, rcolumn: Int) -> Bool {
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
