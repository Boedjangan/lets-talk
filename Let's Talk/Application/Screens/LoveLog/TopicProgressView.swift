//
//  TopicProgressView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 20/07/23.
//

import SwiftUI

import SwiftUI

struct BarProgressStyle: ProgressViewStyle {
    var color: Color
    var height: Double = 20.0
    var width: Double = 121
    var labelFontStyle: Font = .body
    var isLocked:Bool
    
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0
        VStack(alignment: .leading) {
            configuration.label
                .font(Font.headingBig)
                .padding(.bottom,11)
                .foregroundColor(Color.white)
            
            ZStack(alignment:.leading){
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(uiColor: .systemGray5))
                    .frame(height: 18)
                    .frame(width: 121)
                    .overlay(alignment: .leading) {
                        
                    }
                if !isLocked{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(color)
                        .frame(maxWidth: progress * 121, maxHeight: 18 )
                }
                Text(isLocked ?"Locked": "\(Int(progress * 100)) %")
                    .font(.system(size:13))
                    .foregroundColor(Color.white)
                    .padding(.leading,10)
            }
        }
    }
}

struct TopicProgressView: View {
    var color : Color
    var level : String = "level 1"
    var label : String = "Commitment"
    var progress : Double = 1
    
    var body: some View {
        VStack(alignment: .leading){
            Text(level)
                .padding(.bottom,10)
                .foregroundColor(Color.white)
            ProgressView(value: progress, label: { Text(label) }, currentValueLabel: { Text(String(progress * 100) + "%") })
                .progressViewStyle(BarProgressStyle(color:.red,height: 40,width:121, isLocked: false))
        }
        
    }
    
}

struct TopicProgressView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView{
            ZStack {
                TopicProgressView(color: Color.black)
            }
        }
        
    }
    
}

