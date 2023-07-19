//
//  ButtonView.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 19/07/23.
//

import SwiftUI

struct ButtonView<Label:View>: View {
    private let role: ButtonRole?
    private let action: () -> Void
    private let label: () -> Label
    
    init(role: ButtonRole? = nil, action: @escaping () -> Void, label: @escaping () -> Label) {
        self.role = role
        self.action = action
        self.label = label
    }
    
    var body: some View {
        Button(role: role) {
            action()
        } label: {
            label()
        }

    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView() {
            
        } label: {
            Text("Hehehe")
        }
        .buttonStyle(.primary)
        
        ButtonView() {
            
        } label: {
            Text("Hehehe")
        }
        .buttonStyle(.secondary)
    }
}
