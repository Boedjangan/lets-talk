//
//  QuestionTextView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 23/07/23.
//

import SwiftUI

struct QuestionTextView: View {
    var question:String = "question"
    var body: some View {
        Text(question)
            .font(Font.textQuestion)
        
    }
}

struct QuestionTextView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView{
            QuestionTextView()
        }
        
    }
}
