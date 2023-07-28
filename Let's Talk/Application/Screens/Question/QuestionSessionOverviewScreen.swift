//
//  QuestionSessionOverviewScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct QuestionSessionOverviewScreen: View {
    @EnvironmentObject var questionVM: QuestionViewModel
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var navigation: DashboardNavigationManager
    @EnvironmentObject var multipeerHandler: MultipeerHandler
    
    @State var isReady = false
    
    var body: some View {
        LayoutView {
            if !isReady {
                LoadingView()
            }
            
            if isReady{
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
                
                ImagePreview(image: questionVM.displaySavedImage(for: getKeyString() ?? "gambar"))
                
                Spacer()
                
                ButtonView {
                    navigation.push(to: .dashboard)
                } label: {
                    Text("Kembali ke Dashboard")
                }
                .buttonStyle(.fill(.primary))
            }
            
        }
        .onChange(of: multipeerHandler.coupleReadyAt, perform: {
            newValue in
            if newValue == "question_overview" {
                isReady = true
            }
        })
        .onAppear{
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
                Text("\(totalTalkDuration) Menit")
                    .font(.headingBig)
                
                Text("Waktu kebersamaan kalian ketika mengobrol.")
                    .font(.genderPickerLabel)
                    .multilineTextAlignment(.center)
            }
            .multilineTextAlignment(.center)
            
            VStack {
                Text("+\(coupleTalkDuration) Menit")
                    .font(.paragraph)
                
                AvatarView(iconImage: userVM.user.gender == .male ? "Male" : "Female", radius: 70, imageSize: 50)
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
