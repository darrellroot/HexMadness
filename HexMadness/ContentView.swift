//
//  ContentView.swift
//  HexMadness
//
//  Created by Darrell Root on 12/8/19.
//  Copyright © 2019 Darrell Root. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var gameModel: GameModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Hex Madness!").font(.largeTitle)
                NavigationLink("New Game", destination: ScreenView(startGame: true)).font(.title)
                if gameModel.gameComplete == false && gameModel.score > 0 {
                    NavigationLink("Continue Game", destination: ScreenView(startGame: false)).font(.title)
                }
                NavigationLink("How To Play", destination: HelpView()).font(.title)
                NavigationLink("Top scores", destination: TopScoreView()).font(.title)
            }
        }//navigationView
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
