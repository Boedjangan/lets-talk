//
//  WarmUpTimerView.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 21/07/23.
//

import SwiftUI

struct WarmUpTimerView: View {
    @State var timeRemaining: Double = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Gauge(value: timeRemaining, in: 1...5) {
            Text("")
        } currentValueLabel: {
            Text(String(format: "%.0f", timeRemaining))
                .font(.system(size: 40, weight: .bold))
        }
        .gaugeStyle(.accessoryCircularCapacity)
        .tint(Color("Tosca"))
        .scaleEffect(3)
        .frame(maxHeight: 200)
        .padding(.vertical, 30)
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                withAnimation(.easeInOut(duration: 1)) {
                    timeRemaining -= 1
                }
            }
        }
    }
}


struct WarmUpTimerView_Previews: PreviewProvider {
    static var previews: some View {
        WarmUpTimerView()
    }
}
