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
            VStack {
                Text("Hex Madness!").font(.largeTitle)
                NavigationLink("New Game", destination: ScreenView())
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
