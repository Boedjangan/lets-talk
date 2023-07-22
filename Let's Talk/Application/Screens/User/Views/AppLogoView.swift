//
//  AppLogoView.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 20/07/23.
//

import SwiftUI

struct AppLogoView: View {
    var body: some View {
        Image(systemName: "apple.logo")
            .font(.system(size: 100))
            .frame(maxHeight: 300)
    }
}

struct AppLogoView_Previews: PreviewProvider {
    static var previews: some View {
        AppLogoView()
    }
}
