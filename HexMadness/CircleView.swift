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
                    .onTapGesture {
                        debugPrint("circle row \(self.circle.row) column \(self.circle.column) pressed")
                        self.gameModel.pressedCircle = self.circle
                }
            }
            .frame(width: geo.size.width / CGFloat(GameModel.columns), height: geo.size.height / CGFloat(GameModel.rows))
            .scaleEffect(self.circle.pressed ? 1.2 : 1.0)
            .animation(self.circle.pressed ? Animation.easeInOut.repeatForever() : Animation.easeInOut.repeatCount(0))
            .offset( x: GameModel.hexX(width: geo.size.width, column: self.circle.column), y: GameModel.hexY(height: geo.size.height, row: self.circle.row, column: self.circle.column))
            .animation(Animation.linear.repeatCount(1), value: self.circle.row)
            //.animation(.linear, value: self.circle.column)
        }
    }
}

/*struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(row: 3, column: 2, color: Color.blue)
    }
}*/
