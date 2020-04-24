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
}
