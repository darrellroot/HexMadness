//
//  GameCircle.swift
//  HexMadness
//
//  Created by Darrell Root on 12/10/19.
//  Copyright © 2019 Darrell Root. All rights reserved.
//

import Foundation

class CircleModel {
    var row: Int
    var column: Int
    let color = GameColor.allCases.randomElement()
    let id = UUID()
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}
