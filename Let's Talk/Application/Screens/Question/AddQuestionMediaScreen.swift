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
            Text("Abadikan momen mengobrol kalian")
                .font(.headingBig)
            Text("Foto ini akan ditampilkan pada LoveLog untuk mengingat momen mengobrol kalian.")
                .font(.paragraph)
        }
    }
}

struct AddQuestionMediaScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddQuestionMediaScreen()
    }
}
