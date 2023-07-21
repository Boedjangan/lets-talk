//
//  PairListView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 21/07/23.
//

import SwiftUI

struct PairListView: View {
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: 3)
        
        LazyVGrid(columns: columns, alignment: .center, spacing: 32) {
            ForEach(1...7, id: \.self) { _ in
                PairItemView()
            }
        }
        .scrollOnOverflow(maxHeight: 280)
    }
}

struct PairListView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView {
            PairListView()
        }
    }
}