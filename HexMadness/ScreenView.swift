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

    var body: some View {
        VStack {
            //Text("Score: \(gameModel.score)")
            GameView()
        }.navigationBarTitle("Score: \(gameModel.score)", displayMode: .inline)
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView()
    }
}
