//
//  BarProgressStyle.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 20/07/23.
//

import Foundation
import SwiftUI

struct BarProgressStyle: ProgressViewStyle {
    var color: Color
    var height: Double = 20.0
    var width: Double = 121
    var labelFontStyle: Font = .body
    var isLocked:Bool
    
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0
        VStack(alignment: .leading, spacing: 11) {
            configuration.label
                .font(Font.titleTopic)
                .foregroundColor(Color.white)
            
            ZStack(alignment:.leading) {
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
                Text(isLocked ? "Locked": "\(Int(progress * 100)) %")
                    .font(.system(size:13))
                    .foregroundColor(Color.white)
                    .padding(.leading,10)
            }
        }
    }
}
