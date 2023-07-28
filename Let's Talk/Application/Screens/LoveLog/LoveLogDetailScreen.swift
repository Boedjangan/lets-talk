//
//  LoveLogDetailScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 27/07/23.
//

import SwiftUI
import AVFoundation

struct LoveLogDetailScreen: View {
    @EnvironmentObject var loveLogVM: LoveLogViewModel
    @State private var audioPlayer: AVAudioPlayer!
    @State private var sliderVal: Double = 3
    var date: Date = Date()
    var topic: String = "Commitment"
    var body: some View {
        LayoutView(alignment: .leading, spacing: 30, children: {
            Image("sample")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 400)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay (alignment: .topLeading) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.headingBig)
                    }
                    .padding()
                }
            VStack(alignment: .leading, spacing: 10) {
                Text(date, style: .date)
                    .font(.subHeading)
                Text("Momen  ini diambil ketika anda dan pasangan anda membahas topik \(topic).")
                    .font(.paragraph)
                Text("Berikut Voice Memo dari pasangan anda.")
                    .font(.paragraph)
            }
            VStack {
                Slider(value: $sliderVal, in: 1...10) {
                    Text("lkjads")
                }
                HStack {
                    Text("00.00")
                        .padding(.horizontal)
                    Spacer()
                    Text("\(sliderVal)")
                        .padding(.horizontal)
                }
                .font(.topicButton)
                HStack {
                    ButtonView {
                        //
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    Spacer()
                    ButtonView {
                        //
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    ButtonView {
                        //
                    } label: {
                        Image(systemName: "play.fill")
                    }
                    ButtonView {
                        //
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    
                    Spacer()
                    ButtonView {
                        //
                    } label: {
                        Image(systemName: "trash")
                    }
                    
                }
            }
            
            Spacer()
            
            
        })
    }
}

struct LoveLogDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewView(LoveLogViewModel()) { val in
            LoveLogDetailScreen()
                .environmentObject(LoveLogViewModel())
        }
    }
}
