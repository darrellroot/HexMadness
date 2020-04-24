//
//  GameView.swift
//  HexMadness
//
//  Created by Darrell Root on 12/8/19.
//  Copyright © 2019 Darrell Root. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @State var circles: [CircleModel] = [CircleModel(row: 0, column: 0),CircleModel(row: 0, column: 1)]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach (self.circles, id: \.self) { circle in
                    
                    CircleView(row: circle.row, column: circle.column, color: Color.blue)
                    
                }
            }
            
            
        }.onAppear {
        //init() {
            for _ in 0 ..< 6 {
                let row = Int.random(in: 0..<GameSize.rows)
                let column = Int.random(in: 0..<GameSize.columns)
                self.circles.append(CircleModel(row: row, column: column))
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
