//
//  GameCenterManager.swift
//  Ultracorps Battle Simulator 4
//
//  Created by Darrell Root on 11/19/19.
//  Copyright © 2019 Network Mom LLC. All rights reserved.
//

import Foundation
import GameKit

// much code from https://stackoverflow.com/questions/58722084/how-to-display-game-center-leaderboard-with-swiftui

class GameCenterManager {
    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID
    var score = 0
    let LEADERBOARD_ID = "HexLead" //Leaderboard ID from Itunes Connect

   // MARK: - AUTHENTICATE LOCAL PLAYER
   func authenticateLocalPlayer() {
    let localPlayer: GKLocalPlayer = GKLocalPlayer.local

       localPlayer.authenticateHandler = {(ViewController, error) -> Void in
           if((ViewController) != nil) {
               print("User is not logged into game center")
           } else if (localPlayer.isAuthenticated) {
               // 2. Player is already authenticated & logged in, load game center
               self.gcEnabled = true

               // Get the default leaderboard ID
               localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
                if error != nil { print(error ?? "error1")
                   } else { self.gcDefaultLeaderBoard = leaderboardIdentifer! }
               })
                print("Adding GameCenter user was a success")
           } else {
               // 3. Game center is not enabled on the users device
               self.gcEnabled = false
               print("Local player could not be authenticated!")
            print(error ?? "error2")
           }
       }
   } //authenticateLocalPlayer()

    func submitScoreToGC(_ score: Int){
        let bestScoreInt = GKScore(leaderboardIdentifier: LEADERBOARD_ID)
        bestScoreInt.value = Int64(score)
        GKScore.report([bestScoreInt]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Best Score submitted to your Leaderboard!")
            }
        }
    }//submitScoreToGc()
}
