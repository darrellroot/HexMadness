//
//  CirclePreView.swift
//  HexMadness
//
//  Created by Darrell Root on 5/4/20.
//  Copyright © 2020 Darrell Root. All rights reserved.
//

import SwiftUI

struct CirclePreView: View {
    @EnvironmentObject var gameModel: GameModel
    
    var body: some View {
        HStack {
            ForEach(gameModel.nextTurnCircles, id: \.self) { color in
                CircleOnlyView(color: color)
            }
            
        }
    }
}

struct CirclePreView_Previews: PreviewProvider {
    static var previews: some View {
        CirclePreView()
    }
}
