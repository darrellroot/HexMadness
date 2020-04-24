//
//  HexView.swift
//  HexMadness
//
//  Created by Darrell Root on 4/23/20.
//  Copyright © 2020 Darrell Root. All rights reserved.
//

import SwiftUI

struct HexView: View, Hashable {
    let row: Int
    let column: Int
    
    var body: some View {
        Text("\(self.row) \(self.column)")
    }
}

struct HexView_Previews: PreviewProvider {
    static var previews: some View {
        HexView(row: 1,column: 1)
    }
}
