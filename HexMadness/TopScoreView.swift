//
//  TopScoreView.swift
//  HexMadness
//
//  Created by Darrell Root on 5/3/20.
//  Copyright © 2020 Darrell Root. All rights reserved.
//

import SwiftUI

struct TopScoreView: View {
    @EnvironmentObject var gameModel: GameModel
    
    var body: some View {
        let scores: [Int] = gameModel.topScores.values.sorted().reversed()
        debugPrint("scores count \(scores.count)")
        return ForEach (scores, id: \.self) {score in
            Text("score \(score)")
        }.navigationBarTitle(Text("Top Scores"))
    }
}

struct TopScoreView_Previews: PreviewProvider {
    static var previews: some View {
        TopScoreView()
    }
}
