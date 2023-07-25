//
//  TopicItemView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 24/07/23.
//

import SwiftUI

struct TopicItemView: View {
    var title: String = "Commitment"
    var icon: String = "moon"
    var level: String = "Level 1"
    var progress: Double = 0
    var isActive : Bool = true
    
    
    var body: some View {
            HStack(alignment: .center, spacing: 16){
                TopIconView(foregroundColor: Color.buttonOutlineCommitment, icon: icon)
                 
                TopicProgressView(color: Color.buttonOutlineCommitment, level: level, label: title, progress: progress,isActive: isActive)
                
                ButtonView() {
                //
                } label: {
                    HStack{
                        Text(isActive ? "Go to Question":"Locked 🔒")
                        Image(systemName: "arrow.right")
                            .foregroundColor(Color.buttonOutlineCommitment)
                            .font(.system(size: 10))
                    }
                }
                .buttonStyle(.outline(.commitment))
            }
            .opacity(isActive ? 1 : 0.4)
           
        }
}

struct TopicItemView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView{
            TopicItemView()
        }
    }
}
