//
//  AppLogoView.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 20/07/23.
//

import SwiftUI

struct AppLogoView: View {
    var body: some View {
        Image("Couple")
            .resizable()
            .frame(maxWidth: 250,maxHeight: 250)
    }
}

struct AppLogoView_Previews: PreviewProvider {
    static var previews: some View {
        AppLogoView()
    }
}
