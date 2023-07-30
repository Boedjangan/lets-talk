//
//  UnitConverter.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 19/07/23.
//

import Foundation

struct TimeObj {
    let seconds: Int?
    let minutes: Int?
    let hour: Int?
}

func convertPixelToPoint(px: Double) -> CGFloat {
    let comparisonValue = CGFloat(4) / CGFloat(3)
    let point = CGFloat(px) / comparisonValue
    
    return point
}

// how to use : totalin dlu detiknya baru itung menitnya
func convertSecondToMinute(duration time:Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 1
    
    let minutes = Double(time) / 60
    let value = NSNumber(value: minutes)
    
    return formatter.string(from: value)!
}


func convertSecondToTimeObject(durationInSeconds: Int) -> TimeObj {
    let seconds = durationInSeconds % 60
    let minutes = durationInSeconds / 60 % 60
    let hours = durationInSeconds / 3600
    
    return TimeObj(seconds: seconds, minutes: minutes, hour: hours)
}
