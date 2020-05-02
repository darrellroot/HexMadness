//
//  Hex.swift
//  HexMadness
//
//  Created by Darrell Root on 4/23/20.
//  Copyright © 2020 Darrell Root. All rights reserved.
//

import Foundation

struct Hex: Hashable, CustomStringConvertible {
    var description: String {
        return "Hex row \(row) column \(column)"
    }
    
    let row: Int
    let column: Int
    
    var allAdjacent: Set<Hex> {
        return GameModel.allAdjacent(row: self.row, column: self.column)
    }
}
