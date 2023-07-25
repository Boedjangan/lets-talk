//
//  AddQuestionMediaScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct AddQuestionMediaScreen: View {
    var body: some View {
        LayoutView(spacing: Spacing.card) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Abadikan momen mengobrol kalian")
                    .font(.addMediaTitle)
                Text("Foto ini akan ditampilkan pada LoveLog untuk mengingat momen mengobrol kalian.")
                    .font(.paragraph)
            }
            
            VStack(spacing: 63) {
                AddPhotoView()
                
                ButtonView {
                    //
                } label: {
                    Text("Lanjut")
                }
                .buttonStyle(.fill(.primary))
            }
        }
    }
}

struct AddQuestionMediaScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddQuestionMediaScreen()
    }
}
