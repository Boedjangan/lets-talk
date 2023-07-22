//
//  TextFieldView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 19/07/23.
//

import SwiftUI
import Combine

/// A control view that displays an editable text interface with debounced value change.
///
/// Pass a binded state of String to the text parameter, when user change the text field value
/// it will not immediately change the binded state, but there will be a delay until user stop
/// typing before reading change to prevent unnecessary re-render because of state change.
///
/// This is accomplished by using Combine. There is a publisher set up.
///
///     TextFieldView(text: $text, placeholder: "Placeholder")
///
struct TextFieldView: View {
    @State var publisher = PassthroughSubject<String, Never>()
    @State var debouncedText: String = ""
    @Binding var text: String
    
    var debounceSeconds = 0.5
    var placeholder: String
    
    var body: some View {
        VStack() {
            TextField("",
                text: $debouncedText,
                prompt: Text(placeholder).foregroundColor(.white)
            )
            .multilineTextAlignment(.center)
            .font(Font.textInput)
            .onChange(of: debouncedText) { value in
                publisher.send(value)
            }
            .onReceive(
                publisher.debounce(for: .seconds(debounceSeconds),scheduler: DispatchQueue.main)) { value in
                    text = value
                }
            
            Rectangle()
                .fill(Color.white)
                .frame(height: 0.5)
        }
        .onAppear{
            debouncedText = text
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            
            TextFieldView(text: .constant(""), placeholder: "Namamu")
                .foregroundColor(Color.white)
        }
    }
}
