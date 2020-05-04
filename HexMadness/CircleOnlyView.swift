//
//  CircleOnlyView.swift
//  HexMadness
//
//  Created by Darrell Root on 5/4/20.
//  Copyright © 2020 Darrell Root. All rights reserved.
//

import SwiftUI

struct CircleOnlyView: View {
    var color: GameColor
    
    init(color: GameColor) {
        self.color = color
    }
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(self.color.color)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CircleOnlyView(color: GameColor.blue)
    }
}
