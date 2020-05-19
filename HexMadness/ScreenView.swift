//
//  ScreenView.swift
//  HexMadness
//
//  Created by Darrell Root on 4/27/20.
//  Copyright © 2020 Darrell Root. All rights reserved.
//

import SwiftUI

struct ScreenView: View {
    @EnvironmentObject var gameModel: GameModel
    var startGame: Bool
    var body: some View {
        VStack {
            //Text("Score: \(gameModel.score)")
            GameView(startGame: startGame)
        }.navigationBarTitle("Score: \(gameModel.score)", displayMode: .inline)
            .navigationBarItems(trailing: CirclePreView())
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView(startGame: true)
    }
}
