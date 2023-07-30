//
//  TalkTimeView.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 20/07/23.
//

import SwiftUI

struct TalkTimeView: View {
    let talkTime: Int
    let captionCard: String = "Ayo mulai tingkatkan waktu bersama kalian dengan menjawab pertanyaan!"
    let captionCard2: String = "menit yang telah kalian habiskan bersama"
    
    var body: some View {
        HStack (alignment:.center, spacing: 24) {
            Text("\(convertSecondToMinute(duration: talkTime))")
                .font(.bigNumber)
//                .padding(.horizontal)
                .lineLimit(1)
                .minimumScaleFactor(0.05)
            
            VStack(alignment: .leading) {
                switch(talkTime / 60){
                case 1...45:
                    renderLove(total: 1)
                case 46...120:
                    renderLove(total: 2)
                case let x where x >= 121:
                    renderLove(total: 3)
                default:
                    renderLove(total: 0)
                }
                
                Text(talkTime > 0 ? captionCard2 : captionCard)
                    .font(.paragraph)
            }
        }
        .padding(.horizontal)
        .foregroundColor(Color.talkTimeForeground)
        .frame(maxWidth: 345, maxHeight: 117)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.talkTimeBackground)
        )
    }
    
    func renderLove(total: Int) -> some View{
        return (
            HStack (spacing: 0){
                ForEach(0..<total, id: \.self){_ in
                    return(
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    )
                }
            }
        )
    }
}

struct TalkTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TalkTimeView(talkTime: 10)
    }
}
