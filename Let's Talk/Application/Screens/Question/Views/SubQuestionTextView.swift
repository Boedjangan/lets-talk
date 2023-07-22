//
//  SubQuestionTextView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 21/07/23.
//

import SwiftUI

struct SubQuestionTextView: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .frame(maxWidth: 300)
                .multilineTextAlignment(.center)
                .lineLimit(3)
        }
        .font(Font.subQuestion)
        .foregroundColor(Color.white)
        .frame(maxWidth: CGFloat.infinity, minHeight: 52)
        .padding(Edge.Set.vertical, 8)
        .background(
            Color.subQuestionTextBackground
        )
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
    }
}

struct SubQuestionTextView_Previews: PreviewProvider {
    static var previews: some View {
        SubQuestionTextView(text: "dwadawdawdwadwadawdawdwadawdawdawdawdwadwaddwadwadwadawdawdawdawdwadwadadawddwaddwadwadawdwadwaddwdwadawdawdawdwadwaddwadwadwaddwadwadawdawdadawdad")
    }
}
