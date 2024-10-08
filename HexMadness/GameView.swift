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
    var startGame: Bool
    //@State var circles: [CircleModel] = []
    @State var hexes: [Hex] = []
    @State private var navigateTopScores = false
    var body: some View {
        GeometryReader { geo in
            ZStack {
                NavigationLink(destination: TopScoreView(), isActive: self.$navigateTopScores, label: {EmptyView()})
                ForEach (self.hexes, id: \.self) { hex in
                    HexView(row: hex.row, column: hex.column)
                        //Text("\(hex.row) \(hex.column)")
                        .frame(width: geo.size.width / CGFloat(GameModel.columns), height: GameModel.hexHeight(height: geo.size.height))
                        .offset( x: GameModel.hexX(width: geo.size.width, column: hex.column), y: GameModel.hexY(height: geo.size.height, row: hex.row, column: hex.column))
                }
                ForEach (self.gameModel.circles, id: \.self.id) { circle in
                    CircleView(circle: circle)
                }
                ForEach (self.gameModel.deletedCircles, id: \.self.id) {
                    deletedCircle in
                    CircleFadeView(circle: deletedCircle)
                }
            }
        }.onAppear {
            for row in 0 ..< GameModel.rows {
                for column in 0 ..< GameModel.columns {
                    self.hexes.append(Hex(row: row, column: column))
                }
            }
            if self.gameModel.gameComplete == true || self.startGame == true {
                self.gameModel.newGame()
            } else {
                debugPrint("Trying to continue current game")
            }
        }.alert(isPresented: $gameModel.gameComplete) {
            Alert(title: Text("Game Over"), message: Text("You scored \(gameModel.score)"), primaryButton: .default(Text("New Game")) {
                    self.gameModel.newGame()
                },
                  secondaryButton: .default(Text("See Top Scores"))
                    {
                        self.navigateTopScores = true
                }
            )
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(startGame: true)
    }
}
