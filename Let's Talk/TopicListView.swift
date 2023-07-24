//
//  TopicListView.swift
//  Let's Talk
//
//  Created by Elwin Johan Sibarani on 23/07/23.
//

import SwiftUI

struct TopicListView: View {
    var title: String = "Commitment"
    var icon: String = "moon"
    var level: String = "Level 1"
    var progress: Double = 0.5
    
    var body: some View {
            HStack(alignment: .center, spacing: 16){
                TopIconView(foregroundColor: Color.buttonOutlineCommitment, icon: icon)
                TopicProgressView(color: Color.buttonOutlineCommitment, level: level, label: title, progress: progress)
                
                ButtonView() {
                //
                } label: {
                    HStack{
                        Text( "Go to Question")
                        Image(systemName: "arrow.right")
                            .foregroundColor(Color.buttonOutlineCommitment)
                            .font(.system(size: 10))
                    }
                }
                .buttonStyle(.outline(.commitment))
            }
        }
}

struct TopicListView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView{
            TopicListView()
        }
    }
}
