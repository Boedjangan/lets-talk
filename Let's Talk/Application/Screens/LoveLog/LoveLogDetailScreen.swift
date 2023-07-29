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
                        AudioPlayerButtons(key: question.answer?.recordedAnswer ?? "", loveLogId: question.id)
                        Spacer()
                    }
                }
            }
            .tabViewStyle(.page)
            .id(UUID())
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
    @EnvironmentObject var questionVM: QuestionViewModel
    @Binding var sliderVal: Double
    var body: some View {
        VStack {
            //time slider
            Slider(value: $questionVM.currentTime, in: 0...questionVM.audioDuration, onEditingChanged: { _ in
                questionVM.changeCurrentTime(to: questionVM.currentTime)
            }) {
                Text("Audio Slider")
            }
            .onChange(of: questionVM.currentTime) { newValue in
                questionVM.changeCurrentTime(to: newValue)
            }

            HStack {
                Text("\(Int(questionVM.audioDuration) / 60):\(Int(questionVM.audioDuration) % 60)")
                Spacer()
                Text("\(Int(questionVM.currentTime) / 60):\(Int(questionVM.currentTime) % 60)")
            }
            .font(.topicButton)
        }
    }
}

struct AudioPlayerButtons: View {
    @EnvironmentObject var questionVM: QuestionViewModel
    @EnvironmentObject var loveLogVM: LoveLogViewModel
    var key: String = ""
    var loveLogId: UUID
    var body: some View {
        HStack {
            Menu {
                Menu {
                    Button {
                        //setting
                    } label: {
                        Text("2x")
                    }
                    Button {
                        //setting
                    } label: {
                        Text("1x")
                    }
                    Button {
                        //setting
                    } label: {
                        Text("Normal")
                    }
                    Button {
                        //setting
                    } label: {
                        Text("0.5x")
                    }
                    Button {
                        //setting
                    } label: {
                        Text("0.25x")
                    }
                } label: {
                    Text("Playback Speed")
                }
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
            }
            ButtonView {
                questionVM.forwardPlayback(seconds: 15)
            } label: {
                Image(systemName: "arrow.clockwise")
            }
            
            Spacer()
            ButtonView {
                loveLogVM.deleteLoveLog(id: loveLogId)
            } label: {
                Image(systemName: "trash")
            }
        }
        .font(.subHeading)
    }
}


struct LoveLogDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let questionEntity = QuestionEntity()
        let viewModel = LoveLogViewModel()
        StatefulPreviewView(viewModel) { val in
            LoveLogDetailScreen(questions: [questionEntity])
                .environmentObject(viewModel)
                .environmentObject(QuestionViewModel()) // Add this
        }
    }
}

