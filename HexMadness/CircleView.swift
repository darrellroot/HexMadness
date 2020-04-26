//
//  CircleView.swift
//  HexMadness
//
//  Created by Darrell Root on 12/10/19.
//  Copyright © 2019 Darrell Root. All rights reserved.
//

import SwiftUI

struct CircleView: View {
    @EnvironmentObject var gameModel: GameModel

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
            .frame(width: geo.size.width / CGFloat(GameModel.columns), height: geo.size.height / CGFloat(GameModel.rows))
            .offset( x: GameModel.hexX(width: geo.size.width, column: self.column), y: GameModel.hexY(height: geo.size.height, row: self.row, column: self.column))
            .onTapGesture {
                self.row = Int.random(in: 0..<GameModel.rows)
                self.column = Int.random(in: 0..<GameModel.columns)
            }
            .animation(.linear)
        }
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(row: 3, column: 2, color: Color.blue)
    }
}
