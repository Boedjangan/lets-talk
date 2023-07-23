//
//  AddQuestionMediaScreen.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct AddQuestionMediaScreen: View {
    var body: some View {
        LayoutView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Abadikan momen mengobrol kalian")
                    .font(.addMediaTitle)
                Text("Foto ini akan ditampilkan pada LoveLog untuk mengingat momen mengobrol kalian.")
                    .font(.paragraph)
            }
            CameraButtonView()
            ButtonView {
                //
            } label: {
                Text("Lanjut")
            }
            .buttonStyle(.fill(.primary))
            
        }
    }
}

struct CameraButtonView: View {
    var body: some View {
        ButtonView {
            //
        } label: {
            Image(systemName: "camera.fill")
                .font(.headingBig)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Ash"))
        .cornerRadius(10)
        .padding(.vertical)
        .padding(.bottom, 20)
    }
}

struct AddQuestionMediaScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddQuestionMediaScreen()
    }
}
