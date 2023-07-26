//
//  CircularBackgroundView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 26/07/23.
//

import SwiftUI

struct CircularBackgroundView: View {
    let waveCount: Int
    let radius: CGFloat
    
    init(gender: Gender = .male, waveCount: Int = 8, radius: CGFloat = 50) {
        self.waveCount = waveCount
        self.radius = radius
    }
    
    var body: some View {
        ZStack() {
            ForEach(1...waveCount, id: \.self) { val in
                Circle()
                    .stroke(Color.white, lineWidth: 0.5)
                    .frame(width: radius * CGFloat(val))
            }
        }
    }
}

struct CircularBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView {
            CircularBackgroundView()
        }
    }
}
