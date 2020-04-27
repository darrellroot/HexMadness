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
    
    static let rows = 9 // must be odd
    static let columns = 8 // must be odd
    static let centerColumn = CGFloat(columns) / 2 // automatically rounds down
    static let centerRow = CGFloat(rows) / 2 // automaticaly rounds down

    init() {
        circles = []
    }
    func addCircle() {
        let row = Int.random(in: 0..<GameModel.rows)
        let column = Int.random(in: 0..<GameModel.columns)
        let circle = CircleModel(row: row, column: column)
        self.circles.append(circle)
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
            return (CGFloat(row) - GameModel.centerRow) * CGFloat(rowHeight)
        } else {
            return (CGFloat(row) - GameModel.centerRow) * CGFloat(rowHeight) - CGFloat(rowHeight) / 2
        }
    }

}
