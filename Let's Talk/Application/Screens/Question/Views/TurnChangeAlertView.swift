//
//  TurnChangeAlertView.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct TurnChangeAlertView: View {
    @Binding var showAlert: Bool
    var body: some View {
        Button("Tukar Giliran") {
            self.showAlert = true
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Tukar Giliran"),
                message: Text("Sekarang giliran pasangan kamu untuk sharing denganmu."),
                dismissButton: .default(Text("Okay")) {
                    showAlert = false
                }
            )
        }
    }
}

struct TurnChangeAlertView_Previews: PreviewProvider {
    static var previews: some View {
        TurnChangeAlertView(showAlert: .constant(true))
    }
}
