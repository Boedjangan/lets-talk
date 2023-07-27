//
//  AddQuestionMediaScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct AddQuestionMediaScreen: View {
    @EnvironmentObject var questionVM: QuestionViewModel
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var multipeerHandler: MultipeerHandler
    @EnvironmentObject var navigation: DashboardNavigationManager
    @State private var savedImage: UIImage? = nil
    
    @State var isReady = false
//    var questionId: UUID
    
    var body: some View {
//        NavigationStack {
            LayoutView(spacing: Spacing.card) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Abadikan momen mengobrol kalian")
                        .font(.addMediaTitle)
                    Text("Foto ini akan ditampilkan pada LoveLog untuk mengingat momen mengobrol kalian.")
                        .font(.paragraph)
                }
                
                VStack(spacing: 63) {
                    AddPhotoView(questionVM: questionVM, savedImage: $savedImage, questionId: questionVM.currentQuestion!.id,imageName: getKeyString() ?? "gambar")
                    
                    ButtonView {
                        // multipeer
                        
                        navigation.push(to: .overview)
                       
                    } label: {
                        Text("Lanjut")
                    }
                    .buttonStyle(.fill(.primary))
                }
            }
            .onAppear {
                savedImage = questionVM.displaySavedImage(for: getKeyString() ?? "gambar")
            }
//        }
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
