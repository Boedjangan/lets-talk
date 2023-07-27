//
//  AddQuestionMediaScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct AddQuestionMediaScreen: View {
    @ObservedObject var questionVM: QuestionViewModel
    @State private var savedImage: UIImage? = nil
    var questionId: UUID
    
    var body: some View {
        NavigationStack {
            LayoutView(spacing: Spacing.card) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Abadikan momen mengobrol kalian")
                        .font(.addMediaTitle)
                    Text("Foto ini akan ditampilkan pada LoveLog untuk mengingat momen mengobrol kalian.")
                        .font(.paragraph)
                }
                
                VStack(spacing: 63) {
                    AddPhotoView(questionVM: questionVM, savedImage: $savedImage, questionId: questionId)
                    
                    ButtonView {
                        //
                    } label: {
                        Text("Lanjut")
                    }
                    .buttonStyle(.fill(.primary))
                }
            }
            .onAppear {
                savedImage = questionVM.displaySavedImage(for: questionId.uuidString)
            }
        }
    }
}

//struct AddQuestionMediaScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddQuestionMediaScreen()
//    }
//}
