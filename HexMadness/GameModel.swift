//
//  GameModel.swift
//  HexMadness
//
//  Created by Darrell Root on 4/25/20.
//  Copyright © 2020 Darrell Root. All rights reserved.
//

import Foundation
import SwiftUI

enum DefaultKey: String {
    case topScores
}

class GameModel: ObservableObject {
    let extraTestingCircles = 20 // to lose rapidly during testing
    
    let defaults = UserDefaults.standard
    @Published var topScores: [Int: Int] = GameModel.getDictionary(key: DefaultKey.topScores.rawValue) { //UserDefaults.standard.object(forKey: DefaultKey.topScores.rawValue) as? [Int:Int] ?? [:] { // first int is time in seconds since reference time, second Int is score
        didSet {
            GameModel.saveDictionary(dict: topScores, key: DefaultKey.topScores.rawValue)
        }
    }

    @Published var circles: [CircleModel]
    @Published var deletedCircles: [CircleModel] = []
    @Published var score: Int = 0
    @Published var gameComplete = false {
        didSet {
            if self.gameComplete == false {
                updateTopScores()
                self.newGame()
            }
        }
    }
    @Published var newTopScore = false
    //@Published var bestScoreEver = false
    
    // from https://freakycoder.com/ios-notes-29-how-to-save-dictionary-in-userdefaults-1b9abd1bf09
    static func saveDictionary(dict: Dictionary<Int, Int>, key: String){
         let preferences = UserDefaults.standard
         let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: dict)
         preferences.set(encodedData, forKey: key)
         // Checking the preference is saved or not
         //didSave(preferences: preferences)
    }
    
    // from: https://freakycoder.com/ios-notes-29-how-to-save-dictionary-in-userdefaults-1b9abd1bf09
    static func getDictionary(key: String) -> Dictionary<Int, Int> {
         let preferences = UserDefaults.standard
         if preferences.object(forKey: key) != nil{
         let decoded = preferences.object(forKey: key)  as! Data
         let decodedDict = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Dictionary<Int, Int>
                
         return decodedDict
       } else {
          let emptyDict = Dictionary<Int, Int>()
          return emptyDict
       }
    }
    
    func updateTopScores() {
        let currentTime = Int(Date.timeIntervalSinceReferenceDate)
        if topScores.count < 10 {
            topScores[currentTime] = score
            newTopScore = true
        } else { // only keep top 10 scores
            var lowestScoreTime = currentTime + 1
            var lowestScore = 100000
            for (oldScoreTime,oldScore) in topScores {
                if oldScore < lowestScore {
                    lowestScore = oldScore
                    lowestScoreTime = oldScoreTime
                }
            }
            if score > lowestScore {
                topScores[lowestScoreTime] = nil
                topScores[currentTime] = score
                newTopScore = true
            }
        }
    }
    var responsive = true // set to false during move to prevent race condition
    
    public var pressedCircle: CircleModel? {
        didSet {
            for circle in circles {
                circle.pressed = false
            }
            pressedCircle?.pressed = true
        }
    }
    
    static let rows = 9 // must be odd
    static let columns = 8 // must be odd
    static let centerColumn = CGFloat(columns) / 2 // automatically rounds down
    static let centerRow = CGFloat(rows) / 2 // automaticaly rounds down
    
    func circle(row: Int, column: Int) -> CircleModel? {
        for circle in circles {
            if circle.row == row && circle.column == column {
                return circle
            }
        }
        return nil
    }
    func circle(hex: Hex) -> CircleModel? {
        for circle in circles {
            if circle.row == hex.row && circle.column == hex.column {
                return circle
            }
        }
        return nil
    }
    func occupied(row: Int, column: Int) -> Bool {
        for circle in circles {
            if circle.row == row && circle.column == column {
                return true
            }
        }
        return false
    }
    init() {
        circles = []
    }
    func newGame() {
        self.circles = []
        self.score = 0
        for _ in 0 ..< 6 {
            self.addCircle()
        }
    }
    static func allAdjacent(row: Int, column: Int) -> Set<Hex> {
        var adjacentHexes: Set<Hex> = []
        for candidateRow in 0 ..< GameModel.rows {
            for candidateColumn in 0 ..< GameModel.columns {
                if GameModel.adjacent(lrow: candidateRow, lcolumn: candidateColumn, rrow: row, rcolumn: column) {
                    let adjacentHex = Hex(row: candidateRow, column: candidateColumn)
                    adjacentHexes.insert(adjacentHex)
                }
            }
        }
        return adjacentHexes
    }
    
    func testForWin(pressedCircle: CircleModel) -> Bool {
        var winningCircles: [CircleModel] = [pressedCircle]
        var winningHexes: Set<Hex> = [pressedCircle.hex]
        var candidateHexes: Set<Hex> = [pressedCircle.hex]
        var analyzedHexes: Set<Hex> = [pressedCircle.hex]
        let pressedHex = Hex(row: pressedCircle.row, column: pressedCircle.column)
        while candidateHexes.count > 0 {
            let thisHex = candidateHexes.first!
            let adjacentHexes = thisHex.allAdjacent
            for adjacentHex in adjacentHexes {
                if !analyzedHexes.contains(adjacentHex) {
                    analyzedHexes.insert(adjacentHex)
                    if let adjacentCircle = circle(hex: adjacentHex), adjacentCircle.color == pressedCircle.color {
                        winningHexes.insert(adjacentHex)
                        winningCircles.append(adjacentCircle)
                        candidateHexes.insert(adjacentHex)
                    }
                } else {
                    // do nothing, neighbor hex already analyzed
                }
            }
            candidateHexes.remove(thisHex)
        }
        if winningCircles.count >= 6 {
            debugPrint("you won!")
            for circle in winningCircles {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let index = self.circles.firstIndex(of: circle) {
                        self.circles.remove(at: index)
                    }
                    self.deletedCircles.append(circle)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.deletedCircles.removeFirst()
                }
                self.score = self.score + 1
            }
            return true
        } else {
            return false
        }
    }
    func testForValidMove(row: Int, column: Int) -> Bool {
        guard let pressedCircle = pressedCircle else {
            return false
        }
        var analyzedHexes: Set<Hex> = [pressedCircle.hex]
        var candidateHexes: Set<Hex> = pressedCircle.hex.allAdjacent
        candidateHexes: while candidateHexes.count > 0 {
            let candidateHex = candidateHexes.removeFirst()
            analyzedHexes.insert(candidateHex)
            guard circle(hex: candidateHex) == nil else {
                continue candidateHexes
            }
            if candidateHex.row == row && candidateHex.column == column {
                return true
            }
            let newCandidates = candidateHex.allAdjacent
            for newCandidate in newCandidates {
                if analyzedHexes.contains(newCandidate) {
                    // do nothing
                } else {
                    candidateHexes.insert(newCandidate)
                }
            }
        }
        return false
    }
    func getPath(startHex: Hex, endHex: Hex) -> [Hex]? {
        var distance: [Hex:Int] = [:]
        distance[startHex] = 0
        var hexesToAnalyze: [Hex] = [startHex]
        thisHex: while let thisHex = hexesToAnalyze.first {
            hexesToAnalyze.remove(at: 0)
            guard let thisDistance = distance[thisHex] else {
                continue thisHex
            }
            adjacentHex: for adjacentHex in thisHex.allAdjacent {
                guard distance[adjacentHex] == nil else {
                    continue adjacentHex
                }
                guard self.circle(hex: adjacentHex) == nil else {
                    continue adjacentHex
                }
                distance[adjacentHex] = thisDistance + 1
                hexesToAnalyze.append(adjacentHex)
                if adjacentHex == endHex { // means we are done
                    hexesToAnalyze = []
                }
            }
        }
        guard let endDistance = distance[endHex] else {
            return nil
        }
        var path: [Hex] = []
        path.append(endHex)
        var currentHex = endHex
        currentDistance: for currentDistance in (1...endDistance).reversed() {
            guard distance[currentHex] == currentDistance else {
                return nil
            }
            for adjacentHex in currentHex.allAdjacent {
                if distance[adjacentHex] == currentDistance - 1 {
                    path.append(adjacentHex)
                    currentHex = adjacentHex
                    if adjacentHex == startHex {
                        return path.reversed()
                    }
                    continue currentDistance
                }
            }
            //unexpected error got through all adjacent hexes without a match
            return nil
        }
        //unexpected error
        return nil
    }
    func move(row: Int, column: Int) {
        if !responsive { return }
        if let pressedCircle = pressedCircle, testForValidMove(row: row, column: column) {
            self.score += 1
            let path = getPath(startHex: pressedCircle.hex, endHex: Hex(row: row, column: column))
            debugPrint(path)
            pressedCircle.path = path
            var totalDuration: Double
            self.responsive = false
            if let path = path {
                totalDuration = Double(path.count) * 0.1
                for (position,pathElement) in path.enumerated() {
                    if position != 0 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(position - 1)) {
                            pressedCircle.row = pathElement.row
                            pressedCircle.column = pathElement.column
                        }
                    }
                }
            } else {
                totalDuration = 0.50
                pressedCircle.row = row
                pressedCircle.column = column
            }
            self.pressedCircle = nil
            let newCircles = Int.random(in: 3..<5) + score / 100 + extraTestingCircles
            DispatchQueue.main.asyncAfter(deadline: .now() + totalDuration + 0.1) {
                if self.testForWin(pressedCircle: pressedCircle) {
                    self.responsive = true
                    // do nothing
                } else {
                    // add circles
                    for _ in 0..<newCircles {
                        self.addCircle()
                    }
                    self.responsive = true
                }
            }
        }
    }
    static func adjacent(lrow: Int, lcolumn: Int, rrow: Int, rcolumn: Int) -> Bool {
        if abs(lrow - rrow) >= 2 {
            return false
        }
        if abs(lcolumn - rcolumn) >= 2 {
            return false
        }
        if lrow == rrow && lcolumn == rcolumn {
            return false
        }
        // 2 cases
        if lcolumn == rcolumn && abs(lrow - rrow) == 1 {
            return true
        }
        // 2 cases
        if lrow == rrow && abs(lcolumn - rcolumn) == 1 {
            return true
        }
        if lcolumn % 2 == 0 && rcolumn % 2 == 1 && lcolumn == rcolumn - 1 && lrow == rrow - 1 {
            return false
        }
        if lcolumn % 2 == 0 && rcolumn % 2 == 1 && lcolumn == rcolumn + 1 && lrow == rrow - 1 {
            return false
        }

        if lcolumn % 2 == 0 && rcolumn % 2 == 1 && abs(lcolumn - rcolumn) == 1 && lrow - 1 == rrow {
            return true
        }

        if lcolumn % 2 == 1 && rcolumn % 2 == 0 && abs(lcolumn - rcolumn) == 1 && lrow == rrow - 1 {
            return true
        }
        return false
    }
    func addCircle() {
        //try 1000 times to add a circle
        // if that fails, we assume board is full and game over
        var row: Int = 0
        var column: Int = 0
        var added = false
        for _ in 0 ..< 1000 {
            row = Int.random(in: 0..<GameModel.rows)
            column = Int.random(in: 0..<GameModel.columns)
            if !occupied(row: row, column: column) {
                added = true
                break
            }
        }
        if !added {
            gameOver()
        } else {
            let circle = CircleModel(row: row, column: column)
            self.circles.append(circle)
            self.testForWin(pressedCircle: circle)
        }
    }
    func gameOver() {
        debugPrint("Game Over")
        self.gameComplete = true
    }
    
    static func hexX(width: CGFloat, column: Int) -> CGFloat {
        let width = Int(width)
        let columnWidth = width / GameModel.columns
        return  (CGFloat(column) - GameModel.centerColumn) * CGFloat(columnWidth) + CGFloat(columnWidth) * 0.5
    }
    static func hexHeight(height: CGFloat) -> CGFloat {
        return height / (CGFloat(GameModel.rows) + 0.5)
    }
    
    static func hexY(height: CGFloat, row: Int, column: Int) -> CGFloat {
        //let height = Int(height)
        let rowHeight = hexHeight(height: height)
        if  column % 2 == 0 {
            return (CGFloat(row) - GameModel.centerRow - 0.25) * rowHeight + CGFloat(rowHeight) / 2
        } else {
            return (CGFloat(row) - GameModel.centerRow - 0.25) * rowHeight + CGFloat(rowHeight)
        }
    }
}
