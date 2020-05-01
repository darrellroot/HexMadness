//
//  CircleFadeView.swift
//  HexMadness
//
//  Created by Darrell Root on 12/10/19.
//  Copyright © 2019 Darrell Root. All rights reserved.
//

import SwiftUI

struct CircleFadeView: View {
    @EnvironmentObject var gameModel: GameModel
    @ObservedObject var circle: CircleModel
    @State var fading = false
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
            .scaleEffect(self.fading ? 0.0 : 1.0)
            .animation(Animation.linear)
            .offset( x: GameModel.hexX(width: geo.size.width, column: self.circle.column), y: GameModel.hexY(height: geo.size.height, row: self.circle.row, column: self.circle.column))
            //.animation(.linear, value: self.circle.column)
        }.onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.fading = true
                }
        }
    }
    
}

/*struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(row: 3, column: 2, color: Color.blue)
    }
}*/
