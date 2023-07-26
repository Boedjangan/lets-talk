//
//  TopicListView.swift
//  Let's Talk
//
//  Created by Elwin Johan Sibarani on 23/07/23.
//

import SwiftUI

struct TopicListView: View {
    var topics:[TopicEntity] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 64) {
                ForEach(topics) { topic in
                    TopicItemView(topic: topic)
                }
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
