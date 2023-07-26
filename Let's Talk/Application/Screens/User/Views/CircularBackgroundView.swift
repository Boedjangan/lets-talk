//
//  CircularBackgroundView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 26/07/23.
//

import SwiftUI

struct CircularBackgroundView: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white, lineWidth: 0.5)
                .frame(width: 50)
            Circle()
                .stroke(Color.white, lineWidth: 0.5)
                .frame(width: 100)
            Circle()
                .stroke(Color.white, lineWidth: 0.5)
                .frame(width: 150)
            Circle()
                .stroke(Color.white, lineWidth: 0.5)
                .frame(width: 200)
            Circle()
                .stroke(Color.white, lineWidth: 0.5)
                .frame(width: 250)
            Circle()
                .stroke(Color.white, lineWidth: 0.5)
                .frame(width: 300)
            Circle()
                .stroke(Color.white, lineWidth: 0.5)
                .frame(width: 350)
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
