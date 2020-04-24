//
//  GameSize.swift
//  HexMadness
//
//  Created by Darrell Root on 12/10/19.
//  Copyright © 2019 Darrell Root. All rights reserved.
//

import Foundation
import SwiftUI

class GameSize: ObservableObject {
    static let rows = 9 // must be odd
    static let columns = 8 // must be odd
    static let centerColumn = CGFloat(GameSize.columns) / 2 // automatically rounds down
    static let centerRow = CGFloat(GameSize.rows) / 2 // automaticaly rounds down
    
    static func hexX(width: CGFloat, column: Int) -> CGFloat {
        let width = Int(width)
        let columnWidth = width / GameSize.columns
        return  (CGFloat(column) - GameSize.centerColumn) * CGFloat(columnWidth) + CGFloat(columnWidth) * 0.5
    }
    static func hexY(height: CGFloat, row: Int, column: Int) -> CGFloat {
        let height = Int(height)
        let rowHeight = height / GameSize.rows
        if  column % 2 == 0 {
            return (CGFloat(row) - GameSize.centerRow) * CGFloat(rowHeight)
        } else {
            return (CGFloat(row) - GameSize.centerRow) * CGFloat(rowHeight) - CGFloat(rowHeight) / 2
        }
    }

}
