//
//  coupleModel.swift
//  Let's Talk
//
//  Created by Datita Devindo Bahana on 24/07/23.
//

import Foundation

class coupleModel: Codable, Identifiable {
    var id = UUID()
    let username:String
    
    init (username:String){
        self.username = username
    }
    
    
}
