//
//  TopicListView.swift
//  Let's Talk
//
//  Created by Elwin Johan Sibarani on 23/07/23.
//

import SwiftUI

struct TopicListView: View {
    var topics:[TopicEntity] = []
    var title: String = "Commitment"
    var icon: String = "moon"
    var level: String = "Level 1"
    var progress: Double = 0.5
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 64) {
                ForEach(topics) { topic in
                    TopicItemView(topic: topic)
//                    TopicItemView()
                }
                
//                TopicItemView(title:"topic 1",progress: 1,isActive: false,isCompleted: true)
//                TopicItemView(title:"topic 2",progress: 0.4)
//                TopicItemView(title:"topic 3",isActive: false)
            }
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
