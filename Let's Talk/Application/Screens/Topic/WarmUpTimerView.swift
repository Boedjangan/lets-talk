//
//  WarmUpTimerView.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 21/07/23.
//

import SwiftUI

struct WarmUpTimerView: View {
    var timeRemaining: Double
    var timer: Timer?
 
    var body: some View {
        Gauge(value: timeRemaining, in: 1...10) {
            Text("")
        } currentValueLabel: {
            Text(String(format: "%.0f", timeRemaining))
                .font(.system(size: 40, weight: .bold))
        }
        .gaugeStyle(.accessoryCircularCapacity)
        .tint(Color("Tosca"))
        .scaleEffect(3)
        .frame(maxHeight: 200)
    }
}
 

struct WarmUpTimerView_Previews: PreviewProvider {
    static var previews: some View {
        WarmUpTimerView(timeRemaining: 10, timer: .scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            
        }))
    }
}
