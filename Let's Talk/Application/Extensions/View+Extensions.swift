//
//  View+Extensions.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 21/07/23.
//

import SwiftUI

struct OverflowContentViewModifier: ViewModifier {
    @State private var contentOverflow: Bool
    
    let maxHeight: CGFloat
    
    init(maxHeight: CGFloat) {
        _contentOverflow = State(wrappedValue: false)
        self.maxHeight = maxHeight
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { contentGeometry in
                    Color.clear.onAppear {
                        contentOverflow = contentGeometry.size.height > maxHeight
                    }
                }
            )
            .wrappedInScrollView(when: contentOverflow, frameHeight: maxHeight)
    }
}

extension View {
    @ViewBuilder
    func wrappedInScrollView(when condition: Bool, frameHeight: CGFloat) -> some View {
        if condition {
            ScrollView {
                self
            }
            .frame(height: frameHeight)
        } else {
            self
        }
    }
    
    func scrollOnOverflow(maxHeight: CGFloat) -> some View {
        modifier(OverflowContentViewModifier(maxHeight: maxHeight))
    }
}
