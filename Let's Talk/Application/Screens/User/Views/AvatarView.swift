//
//  AvatarView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 19/07/23.
//

import SwiftUI

struct AvatarView: View {
    var userName : String = ""
    var iconImage : String = ""
    var radius: CGFloat = 141
    var imageSize: CGFloat = 100
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .foregroundColor(Color.avatarPlaceHolder)
                    .frame(width:radius,height: radius)
                if(iconImage == ""){
                    Image(systemName: "person.fill")
                        .foregroundColor(Color.black)
                        .font(.system(size: imageSize))
                }else{
                    Image(iconImage)
                        .font(.system(size: imageSize))
                }
            }
            .padding(.bottom,18)
            if(userName != ""){
                Text(userName)
                    .font(Font.avatarIcon)
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView {
            AvatarView()
        }
    }
}


