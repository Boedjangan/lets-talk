//
//  AddPhotoView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 24/07/23.
//

import SwiftUI

struct AddPhotoView: View {
    @EnvironmentObject var navigation: DashboardNavigationManager
    
    @Binding var savedImage: UIImage?
    
    var body: some View {
        ButtonView {
            navigation.push(to: .camera)
        } label: {
            if let image = savedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
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
}


//struct AddPhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        LayoutView {
//            AddPhotoView()
//        }
//    }
//}
