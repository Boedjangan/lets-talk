//
//  AddPhotoView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 24/07/23.
//

import SwiftUI

struct AddPhotoView: View {
    @ObservedObject var questionVM: QuestionViewModel
    @Binding var savedImage: UIImage?
    
    var questionId: UUID
    var imageName:String
    
    var body: some View {
        
        NavigationLink {
            CameraScreen(questionVM: questionVM, questionId: questionId, imageName: imageName)
        } label: {
            if let image = savedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Image(systemName: "camera.fill")
                    .font(.headingBig)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.addPhotoBackground)
                    .cornerRadius(10)
            }
        }
    }
}


//struct AddPhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        LayoutView {
//            AddPhotoView()
//        }
//    }
//}
