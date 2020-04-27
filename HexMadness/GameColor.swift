//
//  GameColor.swift
//  HexMadness
//
//  Created by Darrell Root on 4/25/20.
//  Copyright © 2020 Darrell Root. All rights reserved.
//

import Foundation
import SwiftUI

enum GameColor: Int, CaseIterable {
    case red = 0
    case blue = 1
    case green = 2
    case orange = 3
    case yellow = 4
    case purple = 5
    
    static let count: Int = {
        var max: Int = 0
        while let _ = GameColor(rawValue: max) { max += 1}
        return max
    }()
}
extension GameColor {
    var color: Color {
        get {
            switch self {
            case .red:
                return Color.red
            case .blue:
                return Color.blue
            case .green:
                return Color.green
            case .orange:
                return Color.orange
            case .yellow:
                return Color.yellow
            case .purple:
                return Color.purple
            }
         }
    }
}
