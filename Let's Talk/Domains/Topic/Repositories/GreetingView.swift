//
//  GreetingView.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 24/07/23.
//

import SwiftUI

struct GreetingView: View {
    var userName: String = "Ethan"
    let date: Date = Date()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        formatter.locale = Locale(identifier: "id_ID")
        return formatter
    }()
    var body: some View {
        let dateString = dateFormatter.string(from: date)
        Text("✋ Halo, \(userName). \(dateString)")
            .font(.heading)
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity, maxHeight: 54)
            .background(Color("Ash"))
            .cornerRadius(10)
    }
}


struct GreetingView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingView()
    }
}
