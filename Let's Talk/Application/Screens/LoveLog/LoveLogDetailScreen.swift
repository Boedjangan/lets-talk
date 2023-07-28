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
    @EnvironmentObject var questionVM: QuestionViewModel
    @State private var audioPlayer: AVAudioPlayer!
    @State private var sliderVal: Double = 3
    var questions: [QuestionEntity]
    var body: some View {
        LayoutView(children: {
            TabView {
                ForEach(questions) { question in
                    VStack (alignment: .leading, spacing: 20) {
                        ImageView(imageName: question.image ?? "sample")
                        DetailOverview()
                        AudioPlayerSlider(sliderVal: $sliderVal)
                        AudioPlayerButtons(key: question.answer?.recordedAnswer ?? "")
                        Spacer()
                    }
                }
            }
            .tabViewStyle(.page)
        })
        .onAppear {
            
        }
    }
}

struct DetailOverview: View {
    var date: Date = Date()
    var topic: String = "Commitment"
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(date, style: .date)
                .font(.subHeading)
            Text("Momen  ini diambil ketika anda dan pasangan anda membahas topik ") +
            Text("\(topic)")
                .bold()
                .italic()
                .foregroundColor(Color.avatarBackgroundLightPink)
            +
            Text(".")
                .font(.paragraph)
            Text("Berikut Voice Memo dari pasangan anda.")
                .font(.paragraph)
        }
    }
}

struct ImageView: View {
    var imageName: String = "sample"
    var body: some View {
        Image(imageName)
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
    }
}

struct AudioPlayerSlider: View {
    @Binding var sliderVal: Double
    var body: some View {
        VStack {
            //time slider
            Slider(value: $sliderVal, in: 1...10) {
                Text("lkjads")
            }
            HStack {
                //total duration
                Text("00.00")
                    .padding(.horizontal)
                Spacer()
                //left duration
                Text("\(sliderVal)")
                    .padding(.horizontal)
            }
            .font(.topicButton)
        }
    }
}

struct AudioPlayerButtons: View {
    @EnvironmentObject var questionVM: QuestionViewModel
    var key: String = ""
    var body: some View {
        HStack {
            ButtonView {
                //setting
            } label: {
                Image(systemName: "slider.horizontal.3")
            }
            Spacer()
            ButtonView {
                questionVM.backwardPlayback(seconds: 15)
            } label: {
                Image(systemName: "arrow.counterclockwise")
            }
            ButtonView {
                questionVM.isPlayingAudio.toggle()
                if !questionVM.isPlayingAudio {
                    questionVM.startPlayback(key: key)
                } else {
                    questionVM.stopPlayback()
                }
            } label: {
                Image(systemName: questionVM.isPlayingAudio ? "pause.fill" : "play.fill")
                    .padding(.horizontal)
                    .font(.headingBig)
            }
            ButtonView {
                questionVM.forwardPlayback(seconds: 15)
            } label: {
                Image(systemName: "arrow.clockwise")
            }
            
            Spacer()
            ButtonView {
                //delete
            } label: {
                Image(systemName: "trash")
            }
        }
        .font(.heading)
    }
}


struct LoveLogDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let questionEntity = QuestionEntity()
        StatefulPreviewView(LoveLogViewModel()) { val in
            LoveLogDetailScreen(questions: [questionEntity])
                .environmentObject(LoveLogViewModel())
        }
    }
}
