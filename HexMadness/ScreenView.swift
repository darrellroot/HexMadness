//
//  ScreenView.swift
//  HexMadness
//
//  Created by Darrell Root on 4/27/20.
//  Copyright © 2020 Darrell Root. All rights reserved.
//

import SwiftUI

struct ScreenView: View {
    var body: some View {
        VStack {
            Text("Score")
            //Text("score 2")
            GameView()
        }
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView()
    }
}
