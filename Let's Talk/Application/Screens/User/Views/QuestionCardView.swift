//
//  QuestionCardView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 23/07/23.
//

import SwiftUI

struct QuestionCardView: View {
    @State var isRecording:Bool = false
    var question:String = ""
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                
                .foregroundColor(Color.questionBackground)
            VStack{
                HStack{
                    Image(systemName:"waveform.slash")
                        .font(.system(size: 25))
                        .foregroundColor(Color.recording)
                    Spacer()
                    
                }
                .padding(.leading,6)
                .padding(.trailing,6)
                .padding(.top,7)
                Spacer()
                Text("test")
                Spacer()
                
            }
        }
        .frame(maxHeight:510)
        
    }
    
}

struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView{
            QuestionCardView()
        }
        
    }
}
