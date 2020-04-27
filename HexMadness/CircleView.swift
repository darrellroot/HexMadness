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
    @ObservedObject var circle: CircleModel
    //@State var row: Int
    //@State var column: Int
    //var color: Color
    
    init(circle: CircleModel) {
        self.circle = circle
    }
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .foregroundColor(self.circle.color.color)
                //Text("\(self.circle.column) \(self.circle.row)")
            }
            .frame(width: geo.size.width / CGFloat(GameModel.columns), height: geo.size.height / CGFloat(GameModel.rows))
            .offset( x: GameModel.hexX(width: geo.size.width, column: self.circle.column), y: GameModel.hexY(height: geo.size.height, row: self.circle.row, column: self.circle.column))
            .onTapGesture {
                debugPrint("circle.tap")
                self.circle.row = Int.random(in: 0..<GameModel.rows)
                self.circle.column = Int.random(in: 0..<GameModel.columns)
            }
            .animation(.linear)
        }
    }
}

/*struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(row: 3, column: 2, color: Color.blue)
    }
}*/
