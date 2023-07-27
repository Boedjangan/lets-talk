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
    let image: String = "sample"
    let maleTalkTime: Int = 15
    let femaleTalkTime: Int = 29
    
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
                TopicAdvancementDetailsView(maleTalkTime: maleTalkTime, femaleTalkTime: femaleTalkTime)
                ImagePreview(image: image)
                Spacer()
                ButtonView {
                    //
                } label: {
                    Text("Kembali ke Dashboard")
                }
                .buttonStyle(.fill(.primary))
            }
            
        }
        .onChange(of: multipeerHandler.coupleReadyAt, perform: {
            newValue in
            if newValue == "question_overview"{
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
}

struct ImagePreview: View {
    var image: String = "sample"
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(width: 350, height: 350)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.6), radius: 10)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .clipped()
    }
}

struct TopicAdvancementDetailsView: View {
    var maleTalkTime: Int = 0
    var femaleTalkTime: Int = 0
    var coupleTalkTime: Int {maleTalkTime + femaleTalkTime}
    var body: some View {
        HStack(alignment: .center) {
            VStack {
                Text("+\(maleTalkTime) Menit")
                    .font(.paragraph)
                AvatarView(radius: 70, imageSize: 50)
            }
            VStack {
                Text("\(coupleTalkTime) Menit")
                    .font(.headingBig)
                Text("Waktu kebersamaan kalian ketika mengobrol.")
                    .font(.genderPickerLabel)
                    .multilineTextAlignment(.center)
            }
            .multilineTextAlignment(.center)
            VStack {
                Text("+\(femaleTalkTime) Menit")
                    .font(.paragraph)
                AvatarView(radius: 70, imageSize: 50)
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
