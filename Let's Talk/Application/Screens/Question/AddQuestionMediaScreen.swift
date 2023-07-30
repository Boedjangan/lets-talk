//
//  AddQuestionMediaScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

enum SendingStatus {
    case idle
    case sending
    case finished
    case failed
}

struct AddQuestionMediaScreen: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var multipeerHandler: MultipeerHandler
    @EnvironmentObject var navigation: DashboardNavigationManager
    @EnvironmentObject var questionVM: QuestionViewModel
    
    @State private var savedImage: UIImage? = nil
    
    @State var isReady = false
    @State var isReceiving = false
    
    @State var photoSendingStatus: SendingStatus = .idle
    @State var audioSendingStatus: SendingStatus = .idle
    
    var isSending: Bool {
        photoSendingStatus == .sending || audioSendingStatus == .sending
    }
    
    var isFinishedSending: Bool {
        photoSendingStatus == .finished && audioSendingStatus == .finished
    }
    
    var body: some View {
            LayoutView(spacing: Spacing.card) {
                if isReceiving {
                    LoadingView(text: "Menerima data pasangan...")
                }
                
                if isSending && !isReceiving {
                    LoadingView(text: "Mengirim data ke pasangan...")
                }
                
                if !isSending && !isReceiving {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Abadikan momen mengobrol kalian")
                            .font(.addMediaTitle)
                        Text("Foto ini akan ditampilkan pada LoveLog untuk mengingat momen mengobrol kalian.")
                            .font(.paragraph)
                    }
                    
                    VStack(spacing: 63) {
                        AddPhotoView(savedImage: $savedImage)
                        
                        ButtonView {
                            // MARK: Must take pic before continue
                            if savedImage == nil {
                                return
                            }
                            // MARK - Sending Photo
                            let filenamePhoto = questionVM.filename
                            
                            let urlPhoto = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filenamePhoto)
                            
                            photoSendingStatus = .sending
                            multipeerHandler.sendFile(url: urlPhoto, fileName: filenamePhoto) {
                                print("Success sending photo")
                                
                                photoSendingStatus = .finished
                            } onFailed: { error in
                                print("Failed sending photo: \(error)")
                                
                                photoSendingStatus = .failed
                            }
                            
                            // MARK - Sending Audio
                            let filenameAudio = "\(filenamePhoto).m4a"
                            
                            let urlAudio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filenameAudio)
                            
                            audioSendingStatus = .sending
                            multipeerHandler.sendFile(url: urlAudio, fileName: filenameAudio) {
                                print("Success sending audio")
                                audioSendingStatus = .finished
                            } onFailed: { error in
                                print("Failed sending audio: \(error)")
                                
                                audioSendingStatus = .failed
                            }
                        } label: {
                            Text("Lanjut")
                        }
                        .buttonStyle(.fill(.primary))
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
            .onAppear {
                // Disable the idle timer again when the view disappears
                UIApplication.shared.isIdleTimerDisabled = true
                
                if let savedImage {
                    print(savedImage.description)
                } else {
                    print("SAVED IMAGE IS NULL")
                }
                
                savedImage = questionVM.displaySavedImage(for: questionVM.filename)
            }
            .onDisappear {
                // Enable the idle timer again when the view disappears
                UIApplication.shared.isIdleTimerDisabled = false
                
                isReady = false
                isReceiving = false
            }
            .onChange(of: isFinishedSending) { isFinished in
                if isFinished {
                    isReceiving = true
                }
            }
            .onChange(of: multipeerHandler.receivedAudioName) { filename in
                //MARK: Save received audio
                guard let filename = filename, let currentQuestion = questionVM.currentQuestion, let coupleName = multipeerHandler.coupleName else { return }
                
                let newAnswer = AnswerEntity(name: coupleName, recordedAnswer: filename)
                questionVM.updateQuestionAnswer(questionId: currentQuestion.id, newAnswer: newAnswer)
                
                //MARK: Navigate to overview
                navigation.push(to: .overview)
            }
    }
}

//struct AddQuestionMediaScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddQuestionMediaScreen()
//    }
//}
