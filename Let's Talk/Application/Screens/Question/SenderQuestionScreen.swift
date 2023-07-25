//
//  SenderQuestionScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 25/07/23.
//

import SwiftUI

struct SenderQuestionScreen: View {
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    @State private var isTimerActive: Bool = true
    var question: String = "Jorem ipsum dolor sit amet, consectetur adipiscing elit. Jorem ipsum dolor sit amet, consectetur adipiscing elit."
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        LayoutView {
            Text("Ayo mulai obrolan kalian ❤️")
                .font(.heading)
            VStack {
                HStack {
                    Image(systemName: "record")
                    Text(String(format:"%02i:%02i:%02i", hours, minutes, seconds))
                        .onReceive(timer) { _ in
                            if self.isTimerActive {
                                self.seconds += 1
                                if self.seconds == 60 {
                                    self.minutes += 1
                                    self.seconds = 0
                                }
                                if self.minutes == 60 {
                                    self.hours += 1
                                    self.minutes = 0
                                }
                            }
                        }
                }
                Text(question)
            }
            ButtonView {
                //
            } label: {
                Text("Mulai")
            }

        }
    }
}

struct SenderQuestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        SenderQuestionScreen()
    }
}
