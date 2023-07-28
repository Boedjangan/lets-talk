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
    @EnvironmentObject var questionVM: QuestionViewModel
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var multipeerHandler: MultipeerHandler
    @EnvironmentObject var navigation: DashboardNavigationManager
    
    @State private var savedImage: UIImage? = nil
    
    @State var isReady = false
    
    @State var photoSendingStatus: SendingStatus = .idle
    @State var audioSendingStatus: SendingStatus = .idle
    
    var isSending: Bool {
        photoSendingStatus == .sending || audioSendingStatus == .sending
    }
    
    var isFinishedSending: Bool {
        photoSendingStatus == .finished || audioSendingStatus == .finished
    }
    
    var body: some View {
            LayoutView(spacing: Spacing.card) {
                if isSending {
                    LoadingView(text: "Mengirim data...")
                }
                
                if !isSending {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Abadikan momen mengobrol kalian")
                            .font(.addMediaTitle)
                        Text("Foto ini akan ditampilkan pada LoveLog untuk mengingat momen mengobrol kalian.")
                            .font(.paragraph)
                    }
                    
                    VStack(spacing: 63) {
                        AddPhotoView(questionVM: questionVM, savedImage: $savedImage, questionId: questionVM.currentQuestion!.id, imageName: getKeyString() ?? "gambar")
                        
                        ButtonView {
                            // MARK - Sending Photo
                            guard let filenamePhoto = getKeyString() else { return }
                            
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
            .onAppear {
                savedImage = questionVM.displaySavedImage(for: getKeyString() ?? "gambar")
            }
            .onChange(of: isFinishedSending) { isFinished in
                print("\(isFinished)", "<<<<< SENDING STATUS")
                
                if isFinished {
                    navigation.push(to: .overview)
                }
            }
    }
    
    func getKeyString() -> String? {
        guard let topicLevel =  questionVM.currentQuestion?.topicLevel else { return nil }
        guard let questionOrder = questionVM.currentQuestion?.order else { return nil }
        
        return "T\(topicLevel)-Q\(questionOrder)"
    }
}

//struct AddQuestionMediaScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddQuestionMediaScreen()
//    }
//}
