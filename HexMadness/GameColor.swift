//
//  GameColor.swift
//  HexMadness
//
//  Created by Darrell Root on 4/25/20.
//  Copyright © 2020 Darrell Root. All rights reserved.
//

import Foundation

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
/*extension GameColor {
    var colorValue: UIColor {
        get {
            switch self {
            case .red:
                return UIColor.red
            case .blue:
                return UIColor.blue
            case .green:
                return UIColor.green
            case .orange:
                return UIColor.orange
            case .yellow:
                return UIColor.yellow
            case .purple:
                return UIColor.purple
            }
         }
    }
}*/
