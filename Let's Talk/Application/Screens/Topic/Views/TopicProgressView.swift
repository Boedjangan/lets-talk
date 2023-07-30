//
//  TopicProgressView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 20/07/23.
//

import SwiftUI

struct TopicProgressView: View {
    var color : Color
    var level : String = "level 1"
    var label : String = "Commitment"
    var progress : Double = 1
    var isActive : Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 11) {
            Text(level)
                .font(Font.subQuestion)
                .foregroundColor(Color.white)
            ProgressView(
                value: progress,
                label: { Text(label) },
                currentValueLabel: {
                    if isActive {
                        Text(String(progress * 100) + "%")
                    }
                    
                })
            .progressViewStyle(BarProgressStyle(color: color,height: 40,width:121, isLocked: !isActive))
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

