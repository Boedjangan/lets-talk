//
//  QuestionCardView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 23/07/23.
//

import SwiftUI

enum typeQuestion: Int {
    case sender = 0
    case receiver = 1
}

struct QuestionCardView: View {
    
    @Binding var timer:Int
    var isRecording:Bool = false
    var question:String = "Test"
    var typeQuestion:typeQuestion = .sender
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.questionBackground)
            VStack{
                HStack{
                    if(typeQuestion == .sender){
                        Image(systemName:"waveform.slash")
                            .font(.system(size: 25))
                            .foregroundColor(Color.recording)
                    }
                    Spacer()
                    RecordingTimeView(timer: $timer)
                }
                .padding(.leading,6)
                .padding(.trailing,6)
                .padding(.top,7)
                Spacer()
                Text(question)
                Spacer()
            }
        }
        .frame(maxHeight:.infinity)
        
    }
    
}

struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView{
            StatefulPreviewView(0) { timer in
                QuestionCardView(timer: timer)
            }
        }

    }
}
