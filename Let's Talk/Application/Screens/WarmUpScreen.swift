//
//  WarmUpScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 20/07/23.
//

import SwiftUI

struct WarmUpScreen: View {
    @State private var answer: String = ""
    
    var body: some View {
        LayoutView {
            Text("Warming Up!")
                .font(.system(size: 22))
            WarmUpTimerView()
            Text("Jawab pertanyaan ini dengan pasanganmu")
                .font(.paragraph)
            VStack {
                Text("dksajhb")
            }
            .frame(maxHeight: 200)
            .background(.red)
            .padding(.vertical, 30)
            TextFieldView(text: $answer, placeholder: "Tulis jawabanmu disini")
            Spacer()
            ButtonView {
                //
            } label: {
                Text("Jawab")
            }
            .buttonStyle(.primary)
        }
    }
}

struct WarmUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        WarmUpScreen()
    }
}
