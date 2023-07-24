//
//  Fonts.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation
import SwiftUI

extension Font {
    static let heading = Font.system(size: 16, weight: .bold, design: .default)
    static let subHeading = Font.system(size: 20, weight: .bold, design: .default)
    static let headingBig = Font.system(size: 24, weight: .bold, design: .default)
    static let paragraph = Font.system(size: 16, weight: .regular, design: .default)
    
    static let button = Font.system(size: 14, weight: .regular, design: .default)
    static let topicButton = Font.system(size: 10, weight: .semibold, design: .default)
    
    static let genderPickerLabel = Font.system(size: 13, weight: .medium, design: .default)
    
    static let avatarIcon = Font.system(size: 24, weight: .bold, design: .default)
    static let avatarIconSmall = Font.system(size: 9, weight: .regular, design: .default)
    
    static let textInput = Font.system(size: 16, weight: .bold, design: .default)
    
    static let warmUpAnswerHeading = Font.system(size: 17, weight: .semibold, design: .default)
    static let warmUpAnswer = Font.system(size: 17, weight: .regular, design: .default)
    
    static let subQuestion = Font.system(size: 12, weight: .regular, design: .default)
    
    static let bigNumber = Font.system(size: 78, weight: .bold, design: .default)
    
    static let textQuestion = Font.system(size: 17, weight: .regular, design: .default)
}
