//
//  CircleView.swift
//  HexMadness
//
//  Created by Darrell Root on 12/10/19.
//  Copyright © 2019 Darrell Root. All rights reserved.
//

import SwiftUI

struct CircleView: View {
    @EnvironmentObject var gameSize: GameSize

    @State var row: Int
    @State var column: Int
    var color: Color
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                .foregroundColor(self.color)
                Text("\(self.column) \(self.row)")
            }
            .frame(width: geo.size.width / CGFloat(GameSize.columns), height: geo.size.height / CGFloat(GameSize.rows))
            .offset( x: self.hexX(width: geo.size.width, column: self.column), y: self.hexY(height: geo.size.height, row: self.row))
            .onTapGesture {
                self.row = Int.random(in: 0..<GameSize.rows)
                self.column = Int.random(in: 0..<GameSize.columns)
            }
            .animation(.linear)
        }
    }
    func hexX(width: CGFloat, column: Int) -> CGFloat {
        let width = Int(width)
        let columnWidth = width / GameSize.columns
        return CGFloat( (column - GameSize.centerColumn) * columnWidth)
    }
    func hexY(height: CGFloat, row: Int) -> CGFloat {
        let height = Int(height)
        let rowHeight = height / GameSize.rows
        return CGFloat((row - GameSize.centerRow) * rowHeight)
    }

}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(row: 3, column: 2, color: Color.blue)
    }
}
