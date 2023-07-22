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
