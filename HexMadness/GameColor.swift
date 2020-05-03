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
    case cyan = 3
    case yellow = 4
    case purple = 5
    
    static let count: Int = {
        var max: Int = 0
        while let _ = GameColor(rawValue: max) { max += 1}
        return max
    }()
    
    static var lineColorDay: Color {
        return Color.gray
    }
    static var lineColorNight: Color {
        return Color.gray
    }
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
            case .cyan:
                return Color(red: 0x21/256, green: 0xff/256, blue: 0xff/256)//cyan
            case .yellow:
                return Color.yellow
            case .purple:
                return Color.purple
            }
         }
    }
}
