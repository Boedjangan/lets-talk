//
//  QuestionSessionOverviewScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct QuestionSessionOverviewScreen: View {
    @EnvironmentObject var questionVM: QuestionViewModel
    @EnvironmentObject var loveLogVM: LoveLogViewModel
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var topicVM: TopicViewModel
    @EnvironmentObject var navigation: DashboardNavigationManager
    @EnvironmentObject var multipeerHandler: MultipeerHandler
    
    @State var isReady = false
    
    var body: some View {
        LayoutView {
            if !isReady {
                LoadingView()
            }
            
            if isReady {
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Hore. Obrolan kalian sudah selesai 🎉")
                            .font(.warmUpAnswerHeading)
                        Text("Berikut pencapaian obrolan kalian :")
                            .font(.paragraph)
                    }
                    
                    Spacer()
                }
                
                TopicAdvancementDetailsView(talkDuration: questionVM.talkDuration, coupleTalkDuration: questionVM.coupleTalkDuration)
                
                //TODO: still lag behind when displaying image, maybe wait until finished loading and saving
                ImagePreview(image: questionVM.displaySavedImage(for: getKeyString() ?? "gambar"))
                
                Spacer()
                
                ButtonView {
                    if let currentQuestion = questionVM.currentQuestion {
                        let questionTotalTalkDuration = questionVM.totalTalkDuration
                        let userCurrentTalkDuration = userVM.user.talkDuration ?? 0
                        let newUserTotalTalkDuration = userCurrentTalkDuration + questionTotalTalkDuration
                        
                        // MARK: Save update before resetting
                        userVM.updateTalkDuration(newTalkDuration: newUserTotalTalkDuration)
                        questionVM.updateQuestionTalkDuration(questionId: currentQuestion.id, newDuration: questionTotalTalkDuration)
                        questionVM.updateQuestionCompleteStatus(questionId: currentQuestion.id, newStatus: true)
                        topicVM.updateTopicMeta(id: currentQuestion.topicId!, questionOrder: currentQuestion.order)
                        loveLogVM.handleFinishSession(questionId: currentQuestion.id)
                        
                        // MARK: Reset state to proceed with next question
                        questionVM.resetState()
                        multipeerHandler.resetState()
                        
                        // MARK: Navigate back to dashboard
                        navigation.push(to: .dashboard)
                    }
                } label: {
                    Text("Kembali ke Dashboard")
                }
                .buttonStyle(.fill(.primary))
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .onChange(of: multipeerHandler.receivedPhotoName, perform: { filename in
            guard let filename = filename, let currentQuestion = questionVM.currentQuestion else { return }
            
            questionVM.updateQuestionImage(questionId: currentQuestion.id, newImage: filename)
        })
        .onChange(of: multipeerHandler.receivedAudioName, perform: { filename in
            // MARK: Saving answer audio to question
            guard let filename = filename, let currentQuestion = questionVM.currentQuestion, let coupleName = multipeerHandler.coupleName else { return }
            
            let newAnswer = AnswerEntity(name: coupleName, recordedAnswer: filename)
            
            questionVM.updateQuestionAnswer(questionId: currentQuestion.id, newAnswer: newAnswer)
            
            // MARK - Sending Audio
            let filenameAudio = filename
            
            let urlAudio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filenameAudio)
            
            multipeerHandler.sendFile(url: urlAudio, fileName: filenameAudio) {
                print("Success sending audio")
            } onFailed: { error in
                print("Failed sending audio: \(error)")
            }
        })
        .onChange(of: multipeerHandler.coupleReadyAt, perform: {
            newValue in
            if newValue == "question_overview" {
                isReady = true
            }
        })
        .onAppear{
            // Disable the idle timer again when the view disappears
            UIApplication.shared.isIdleTimerDisabled = true
            
            if multipeerHandler.coupleReadyAt == "question_overview" {
                isReady = true
            }
            
            let customData = MultipeerData(dataType: .isReadyAt, data: "question_overview".data(using: .utf8))
            
            do {
                let encodedData = try JSONEncoder().encode(customData)
                
                multipeerHandler.sendData(encodedData)
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
        .onDisappear{
            // Enable the idle timer again when the view disappears
            UIApplication.shared.isIdleTimerDisabled = false
            
            isReady = false
        }
    }
    
    func getKeyString() -> String? {
        guard let topicLevel =  questionVM.currentQuestion?.topicLevel else { return nil }
        guard let questionOrder = questionVM.currentQuestion?.order else { return nil }
        
        return "T\(topicLevel)-Q\(questionOrder)"
    }
}

struct ImagePreview: View {
    var image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 350)
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.6), radius: 10)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
        } else {
            Image(systemName: "camera.fill")
                .font(.headingBig)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.addPhotoBackground)
                .cornerRadius(10)
        }
    }
}

struct TopicAdvancementDetailsView: View {
    @EnvironmentObject var userVM: UserViewModel
    
    var talkDuration: Int = 0
    var coupleTalkDuration: Int = 0
    var totalTalkDuration: Int {
        talkDuration + coupleTalkDuration
    }
    
    var body: some View {
        HStack(alignment: .center) {
            VStack {
                Text("+\(talkDuration) Menit")
                    .font(.paragraph)
                
                AvatarView(iconImage: userVM.user.gender == .male ? "Male" : "Female", radius: 70, imageSize: 50)
            }
            
            VStack {
                Text("+\(convertSecondToMinute(time: totalTalkDuration)) Menit")
                    .font(.headingBig)
                
                Text("Waktu kebersamaan kalian ketika mengobrol.")
                    .font(.genderPickerLabel)
                    .multilineTextAlignment(.center)
            }
            .multilineTextAlignment(.center)
            
            VStack {
                Text("+\(coupleTalkDuration) Menit")
                    .font(.paragraph)
                
                AvatarView(iconImage: userVM.user.gender == .male ? "Female" : "Male", radius: 70, imageSize: 50)
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .background(Color("Ash"))
        .cornerRadius(10)
        .padding(.vertical, 20)
    }
}

//struct QuestionSessionOverviewScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionSessionOverviewScreen()
//    }
//}
