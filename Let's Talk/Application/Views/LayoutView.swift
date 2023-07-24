//
//  LayoutView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 19/07/23.
//

import SwiftUI

struct LayoutView<Children: View>: View {
    private let alignment: HorizontalAlignment
    private let spacing: CGFloat?
    private let children: () -> Children
    
    
    init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder children: @escaping () -> Children) {
        self.alignment = alignment
        self.spacing = spacing
        self.children = children
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
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
            Text("Tai")
            Text("Tai")
        }
    }
}
