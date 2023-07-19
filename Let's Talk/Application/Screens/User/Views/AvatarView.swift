//
//  AvatarView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 19/07/23.
//

import SwiftUI

struct AvatarView: View {
    var userName : String = "User"
//    var iconImage : Image = nil
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .foregroundColor(Color.avatarPlaceHolder)
                    .frame(width:141,height: 141)
                Image(systemName: "person.fill")
                    .foregroundColor(Color.black)
                    .font(.system(size: 100))
            }
                .padding(18)
            
            Text(userName)
                .font(Font.avatarIcon)
                .foregroundColor(Color.white)
            
        }
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}


