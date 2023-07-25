//
//  PairListView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 21/07/23.
//

import SwiftUI

struct PairListView: View {
    @EnvironmentObject var multipeerHandler: MultipeerHandler
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: 3)
        
        LazyVGrid(columns: columns, alignment: .center, spacing: 32) {
            ForEach(multipeerHandler.persons, id: \.self) { phone in
                PairItemView(name:phone.displayName)
                    .onTapGesture {
                        multipeerHandler.invitePeer(phone)
                    }
            }
        }
        .scrollOnOverflow(maxHeight: 280)
    }
}

struct PairListView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView {
//            PairListView()
        }
    }
}
