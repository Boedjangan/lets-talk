//
//  HeroView.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 19/07/23.
//

import SwiftUI

struct HeroView: View {
    var maleHero: String = "person"
    var femaleHero: String = "person"
    var body: some View {
        HStack {
            Image(systemName: maleHero)
                .offset(y: -40)
            Image(systemName: femaleHero)
                .offset(y: 40)
        }
        .font(Font.system(size: 150, weight: .regular, design: .rounded))
        .frame(maxHeight: 300)
    }
}

struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        HeroView()
    }
}
