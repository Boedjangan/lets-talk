//
//  WarmUpCardView.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 20/07/23.
//

import SwiftUI

struct WarmUpCardView: View {
    let question: String = "Siapa teman terbaik kamu?"
    var body: some View {
        Text(question)
        .foregroundColor(Color.white)
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(Color.warpUpCardBackground)
        .cornerRadius(10)
    }
}

struct WarmUpCardView_Previews: PreviewProvider {
    static var previews: some View {
        WarmUpCardView()
    }
}
