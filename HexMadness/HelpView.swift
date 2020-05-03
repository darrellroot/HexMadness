//
//  HelpView.swift
//  HexMadness
//
//  Created by Darrell Root on 5/3/20.
//  Copyright © 2020 Darrell Root. All rights reserved.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Your goal is to make the circles disappear by collecting them in groups of six.")
            Text("Click on a circle, and then click on a destination hex to make it move.")
            Text("If you move six circles together, they will disappear!")
            Text("If you don't move six circles together, more will appear.")
            Text("Circles cannot move through other circles.")
            Text("The number of appearing circles will gradually increase as your score increases.")
            Text("Each move gives you 1 point!")
            Text("Each circle to cause to disappear gives you 1 point!")
            Text("The game is over when the hexes are full.")
            Spacer()
            .navigationBarTitle(Text("How To Play"))
        }
        .padding()
        .font(.headline)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
