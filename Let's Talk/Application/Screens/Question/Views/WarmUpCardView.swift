//
//  WarmUpCardView.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 20/07/23.
//

import SwiftUI

struct WarmUpCardView<Content: View>: View {
    private let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack {
            content()
        }
        .padding()
        .multilineTextAlignment(.center)
        .foregroundColor(Color.white)
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(Color.warmUpCardBackground)
        .cornerRadius(10)
    }
}


struct WarmUpCardView_Previews: PreviewProvider {
    static var previews: some View {
        WarmUpCardView() {
            Text("Heading")
            Text("Paragraph")
        }
    }
}
