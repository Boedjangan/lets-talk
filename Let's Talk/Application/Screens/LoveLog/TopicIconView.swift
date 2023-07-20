//
//  TopIconView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 20/07/23.
//

import SwiftUI

struct TopIconView: View {
    var foregroundColor:Color = Color.blue
    var icon:String = "person.fill"
    
    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(foregroundColor)
                .frame(maxWidth: 65,maxHeight: 65)
            Image(systemName: icon)
                .foregroundColor(Color.white)
                .font(.system(size: 32))
        }
    }
}

struct TopIconView_Previews: PreviewProvider {
    static var previews: some View {
        TopIconView()
    }
}
