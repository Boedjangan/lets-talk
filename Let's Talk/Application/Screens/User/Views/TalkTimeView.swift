//
//  TalkTimeView.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 20/07/23.
//

import SwiftUI

struct TalkTimeView: View {
    let talkTime: Int
    
    var body: some View {
        HStack {
            Text("\(talkTime)")
                .font(.bigNumber)
                .padding(.horizontal)
            Text("Ayo mulai tingkatkan waktu bersama kalian dengan menjawab pertanyaan!")
        }
        .foregroundColor(Color.talkTimeForeground)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.talkTimeBackground)
        )
    }
}

struct TalkTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TalkTimeView(talkTime: 20)
    }
}
