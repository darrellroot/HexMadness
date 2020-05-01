//
//  GameCircle.swift
//  HexMadness
//
//  Created by Darrell Root on 12/10/19.
//  Copyright © 2019 Darrell Root. All rights reserved.
//

import Foundation

class CircleModel: ObservableObject, Equatable, Hashable {
    static func == (lhs: CircleModel, rhs: CircleModel) -> Bool {
        if lhs.row == rhs.row && lhs.column == rhs.column && lhs.color == rhs.color {
            return true
        } else {
            return false
        }
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(column)
        hasher.combine(color)
    }
    
    @Published var row: Int
    @Published var column: Int
    @Published var pressed = false
    let color = GameColor.allCases.randomElement()!
    let id = UUID()
    
    var hex: Hex {
        return Hex(row: self.row, column: self.column)
    }
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}
