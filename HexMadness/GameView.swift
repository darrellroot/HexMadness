//
//  GameView.swift
//  HexMadness
//
//  Created by Darrell Root on 12/8/19.
//  Copyright © 2019 Darrell Root. All rights reserved.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gameModel: GameModel
    
    //@State var circles: [CircleModel] = []
    @State var hexes: [Hex] = []
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach (self.hexes, id: \.self) { hex in
                    HexView(row: hex.row, column: hex.column)
                        //Text("\(hex.row) \(hex.column)")
                        .frame(width: geo.size.width / CGFloat(GameModel.columns), height: geo.size.height / CGFloat(GameModel.rows))
                        .offset( x: GameModel.hexX(width: geo.size.width, column: hex.column), y: GameModel.hexY(height: geo.size.height, row: hex.row, column: hex.column))
                    /*.onTapGesture {
                     debugPrint("hex row \(hex.row) column \(hex.column) tapped")
                     self.gameModel.pressedCircle?.row = hex.row
                     self.gameModel.pressedCircle?.column = hex.column
                     self.gameModel.pressedCircle = nil
                     }*/
                }
                ForEach (self.gameModel.circles, id: \.self.id) { circle in
                    //CircleView(row: circle.row, column: circle.column, color: Color.blue)
                    CircleView(circle: circle)
                }
            }
        }.onAppear {
            for row in 0 ..< GameModel.rows {
                for column in 0 ..< GameModel.columns {
                    self.hexes.append(Hex(row: row, column: column))
                }
            }
            for _ in 0 ..< 6 {
                self.gameModel.addCircle()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
