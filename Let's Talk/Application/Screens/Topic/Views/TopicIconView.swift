//
//  TopIconView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 20/07/23.
//

import SwiftUI


struct TopIconView: View {
    var foregroundColor:Color = Color.blue
    var icon:String = "Topic1"
    
    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(getColor(icon: icon))
                .frame(maxWidth: 65,maxHeight: 65)
            Image(icon)
                .resizable()
                .scaledToFit().frame(width: 55,height: 55)
                .foregroundColor(Color.white)

        }
//        .frame(width: 65, height: 65)
//        .clipShape(Circle())
    }
    
    func getColor(icon:String) -> Color{
        if icon == "Topic1"{
            return Color.topic1
        }
        else if icon == "Topic2"{
            return Color.topic2
        }
        else if icon == "Topic3"{
            return Color.topic3
        }
        
        return Color.blue
    }
}

struct TopIconView_Previews: PreviewProvider {
    static var previews: some View {
        TopIconView()
    }
}
