//
//  HexView.swift
//  HexMadness
//
//  Created by Darrell Root on 4/23/20.
//  Copyright © 2020 Darrell Root. All rights reserved.
//

import SwiftUI

struct HexView: View {
    static func == (lhs: HexView, rhs: HexView) -> Bool {
        if lhs.row == rhs.row && lhs.column == rhs.column {
            return true
        } else {
            return false
        }
    }
    
    let row: Int
    let column: Int
    @EnvironmentObject var gameModel: GameModel

    var body: some View {
        GeometryReader { geo in
            Path { path in
                path.move(to: CGPoint(x: -0.15 * geo.size.width, y: 0.5 * geo.size.height))
                path.addLine(to: CGPoint(x: 0.15 * geo.size.width, y: 0 * geo.size.height))
                path.addLine(to: CGPoint(x: 0.85 * geo.size.width, y: 0 * geo.size.height))
                path.addLine(to: CGPoint(x: 1.15 * geo.size.width, y: 0.5 * geo.size.height))
                path.addLine(to: CGPoint(x: 0.85 * geo.size.width, y: 1.0 * geo.size.height))
                path.addLine(to: CGPoint(x: 0.15 * geo.size.width, y: 1.0 * geo.size.height))
                path.addLine(to: CGPoint(x: -0.15 * geo.size.width, y: 0.5 * geo.size.height))
            }
            .strokedPath(StrokeStyle(lineWidth: 2))
            .contentShape(Circle())
            .onTapGesture {
                debugPrint("hex row \(self.row) column \(self.column) tapped")
                self.gameModel.pressedCircle?.row = self.row
                self.gameModel.pressedCircle?.column = self.column
                self.gameModel.pressedCircle = nil
            }

        }
    }
}

struct HexView_Previews: PreviewProvider {
    static var previews: some View {
        HexView(row: 1,column: 1)
    }
}
