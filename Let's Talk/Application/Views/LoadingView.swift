//
//  LoadingView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 26/07/23.
//

import SwiftUI

struct LoadingView: View {
    var text: String = "Menunggu pasangan..."
    
    var body: some View {
        Text(text)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
