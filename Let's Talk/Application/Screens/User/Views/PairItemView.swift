//
//  PairItemView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 21/07/23.
//

import SwiftUI

struct PairItemView: View {
    var name: String = ""
    var image: String = "person.fill"
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .foregroundColor(Color.avatarPlaceHolder)
                    .frame(width: 60, height: 60)
                
                Image(systemName: image)
                    .foregroundColor(Color.black)
                    .font(.system(size: 45))
            }
            
            Text(name)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 60)
                .font(Font.avatarIconSmall)
                .foregroundColor(Color.white)
        }
    }
}

struct PairItemView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView {
            PairItemView()
            PairItemView()
            PairItemView()
        }
    }
}
