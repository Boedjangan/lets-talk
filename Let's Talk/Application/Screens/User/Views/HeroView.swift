//
//  HeroView.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 19/07/23.
//

import SwiftUI

struct HeroView: View {
    var body: some View {
        HStack {
            Image("Couple")
                .resizable()
                .scaledToFit()
        }
        .frame(maxHeight: 270)
    }
}

struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        HeroView()
    }
}
