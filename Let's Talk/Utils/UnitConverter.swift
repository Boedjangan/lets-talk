//
//  UnitConverter.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 19/07/23.
//

import Foundation

func convertPixelToPoint(px: Double) -> CGFloat {
    let comparisonValue = CGFloat(4) / CGFloat(3)
    let point = CGFloat(px) / comparisonValue
    
    return point
}

// how to use : totalin dlu detiknya baru itung menitnya
func convertSecondToMinute(time:Int) -> String{
    var hour,minute,second : String
    second = String(time % 60)
    minute = String(time / 60 % 60)
    hour = String(time / 3600)
    
    return "\(hour)J \(minute)M \(second)D "
    
}
