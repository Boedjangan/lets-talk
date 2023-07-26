//
//  File.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 24/07/23.
//

import Foundation

class PhoneModel: Codable, Identifiable {
    var id = UUID()
    let displayName:String
    let phoneId : String
    
    init (displayName:String, phoneId:String ){
        self.displayName = displayName
        self.phoneId = phoneId
    }
}
