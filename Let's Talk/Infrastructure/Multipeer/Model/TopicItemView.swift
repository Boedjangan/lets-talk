//
//  TopicItemView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 24/07/23.
//

import SwiftUI

struct TopicItemView: View {
    @EnvironmentObject var navigation: DashboardNavigationManager
    
    let topic: TopicEntity
    
    var body: some View {
            HStack(alignment: .center, spacing: 16){
                TopIconView(foregroundColor: Color.buttonOutlineCommitment, icon: topic.iconName)
                 
                TopicProgressView(color: Color.buttonOutlineCommitment, level: "Level \(topic.level)", label: topic.title, progress: Double(topic.progress), isActive: topic.isActive)
                
                ButtonView() {
                    navigation.push(to: .warmup(topic.id))
                } label: {
                    HStack{
                        if topic.isCompleted{
                            Text("Completed")
                        }else{
                            Text(topic.isActive ? "Go to Question":"Locked 🔒")
                        }
                       
                        Image(systemName: "arrow.right")
                            .foregroundColor(Color.buttonOutlineCommitment)
                            .font(.system(size: 10))
                    }
                }
                .disabled(!topic.isActive ? true : false)
                .buttonStyle(.outline(.commitment))
            }
            .opacity(topic.isActive ? 1 : 0.4)
           
        }
}

struct TopicItemView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView{
            TopicItemView(topic: TopicEntity())
        }
    }
}
