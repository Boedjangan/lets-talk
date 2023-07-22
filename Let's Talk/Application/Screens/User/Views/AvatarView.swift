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
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .foregroundColor(Color.avatarPlaceHolder)
                    .frame(width:141,height: 141)
                if(iconImage == ""){
                    Image(systemName: "person.fill")
                        .foregroundColor(Color.black)
                        .font(.system(size: 100))
                }else{
                    Image(iconImage)
                        .font(.system(size: 100))
                }
               
            }
<<<<<<< HEAD
                .padding(18)
            if(userName != ""){
                Text(userName)
                    .font(Font.avatarIcon)
                    .foregroundColor(Color.white)
            }
            
            
=======
            .padding(18)
            
            Text(userName)
                .font(Font.avatarIcon)
                .foregroundColor(Color.white)
>>>>>>> ca9f30f20ca0b8d82145948b5bfad9ee28971eab
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


