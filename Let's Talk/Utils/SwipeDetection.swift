//
//  SwipeDetection.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import SwiftUI

enum Swipe {
    case up
    case down
    case left
    case right
    case unknown
    
    static func direction(width:CGFloat, height:CGFloat) -> Swipe {
        switch (width, height) {
        case (-100...100, ...0):
            return .up
        case (-100...100, 0...):
            return .down
        case (...0, -30...30):
            return .left
        case (0..., -30...30):
            return .right
        default:
            return .unknown
        }
    }
}
