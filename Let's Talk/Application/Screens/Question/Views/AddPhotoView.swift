//
//  AddPhotoView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 24/07/23.
//

import SwiftUI

struct AddPhotoView: View {
    var body: some View {
        ButtonView {
            //
        } label: {
            Image(systemName: "camera.fill")
                .font(.headingBig)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.addPhotoBackground)
                .cornerRadius(10)
        }
    }
}


struct AddPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView {
            AddPhotoView()
        }
    }
}
