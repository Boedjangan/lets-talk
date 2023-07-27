//
//  TopicItemView.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 24/07/23.
//

import SwiftUI

struct TopicItemView: View {
    @EnvironmentObject var navigation: DashboardNavigationManager
    @EnvironmentObject var multipeerHandler: MultipeerHandler
    @EnvironmentObject var userVM: UserViewModel
    
    let topic: TopicEntity
    
    var body: some View {
            HStack(alignment: .center, spacing: 16){
                TopIconView(foregroundColor: Color.buttonOutlineCommitment, icon: topic.iconName)
                 
                TopicProgressView(color: Color.buttonOutlineCommitment, level: "Level \(topic.level)", label: topic.title, progress: Double(topic.progress), isActive: topic.isActive)
                
                ButtonView() {
                    if let coupleRole = multipeerHandler.coupleRole {
                        switch(coupleRole) {
                        case .receiver:
                            userVM.myRole = .sender
                        case .sender:
                            userVM.myRole = .receiver
                        }
                    } else {
                        let randomRole = randomRole()
                        userVM.myRole = randomRole
                    }
                    
                    let customData = MultipeerData(dataType: .role, data: userVM.myRole?.rawValue.data(using: .utf8))
                    
                    do {
                        let encodedData = try JSONEncoder().encode(customData)
                        
                        multipeerHandler.sendData(encodedData)
                    } catch {
                        print("ERROR: \(error.localizedDescription)")
                    }
                    
                    navigation.push(to: .warmup(topic.id))
                } label: {
                    HStack{
                        if topic.isCompleted{
                            Text("Completed")
                        } else {
                            Text(topic.isActive ? "Go to Question" : "Locked 🔒")
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
    
    func randomRole() -> CoupleRole {
        return CoupleRole.allCases.randomElement()!
    }
}

struct TopicItemView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView{
            TopicItemView(topic: TopicEntity())
        }
    }
}
