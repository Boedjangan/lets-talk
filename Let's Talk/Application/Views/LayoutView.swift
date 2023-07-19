//
//  LayoutView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 19/07/23.
//

import SwiftUI

struct LayoutView<Children: View>: View {
    private let children: () -> Children
    
    init(@ViewBuilder children: @escaping () -> Children) {
        self.children = children
    }
    
    var body: some View {
        VStack {
            children()
        }
        .foregroundColor(Color.white)
        .frame(
            maxWidth: CGFloat.infinity,
            maxHeight:  CGFloat.infinity
        )
        .padding(Edge.Set.horizontal, 24)
        .padding(Edge.Set.top, 8)
        .background(Color.background)
    }
}

struct LayoutView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView() {
            Text("Tai")
        }
    }
}
