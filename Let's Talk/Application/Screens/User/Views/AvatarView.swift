//
//  AvatarView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 19/07/23.
//

import SwiftUI

struct AvatarView: View {
    var userName : String = ""
    var iconImage : String = "Male"
    var radius: CGFloat = 141
    var imageSize: CGFloat = 100
    var isDisabled: Bool = false
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .fill(iconImage == "Male" ? Color.avatarBackgroundTosca : Color.avatarBackgroundPurple)
                    .frame(width:radius,height: radius)
                
                if(iconImage == ""){
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit().frame(width: 141,height: 141)
                        .foregroundColor(Color.black)
                        .padding(.top, 10)
                        
                }else{
                    Image(iconImage)
                        .resizable()
                        .scaledToFit().frame(width: 141,height: 141)
                        .foregroundColor(Color.black)
                        .padding(.top, 10)
                }
            }
            .frame(width: radius, height: radius)
            .clipShape(Circle())
            .opacity(isDisabled ? 0.3 : 1)
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


