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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var dateFormatter = DateFormatter()
    var body: some View {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none

        let scoreDates: [Int] = gameModel.topScores.keys.sorted(by: {gameModel.topScores[$0]! < gameModel.topScores[$1]!}).reversed()
        return VStack {
            List {
                ForEach (scoreDates, id: \.self) {scoreDate in
                //let date = dateFormatter.string(from: Date(timeIntervalSinceReferenceDate: Double(scoreDate)))
                Text(verbatim: "\(self.dateFormatter.string(from: Date(timeIntervalSinceReferenceDate: Double(scoreDate)))) \(self.gameModel.topScores[scoreDate] ?? 0)")
                }.onDelete(perform: delete)
            }//List
            NavigationLink("View GameCenter Top Scores", destination: GameCenterView())
                .font(.title)
                .padding()
            Button("Submit Best Score to GameCenter") {
                if let topScore = self.gameModel.topScores.values.sorted().reversed().first {
                    self.appDelegate.gameCenterManager.submitScoreToGC(topScore)
                }
            }
            .font(.title)
        }//VStack
        .navigationBarTitle(Text("Top Scores"))
        .padding()
    }
    
    func delete(at offsets: IndexSet) {
        let scoreDates: [Int] = gameModel.topScores.keys.sorted(by: {gameModel.topScores[$0]! < gameModel.topScores[$1]!}).reversed()
        let indexes = offsets.map({$0})
        for index in indexes.sorted().reversed() {
            let dateToRemove = scoreDates[index]
            gameModel.topScores[dateToRemove] = nil
        }
    }
}

struct TopScoreView_Previews: PreviewProvider {
    static var previews: some View {
        TopScoreView()
    }
}
