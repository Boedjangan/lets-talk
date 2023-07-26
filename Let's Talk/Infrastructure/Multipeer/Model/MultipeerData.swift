//
//  MultipeerData.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 26/07/23.
//

import Foundation

enum MultipeerDataType: Codable {
    case isReady
    case isNotReady
    case warmUpAnswer
}

class MultipeerData: Codable {
    let dataType: MultipeerDataType
    let isBoolValue: Bool?
    let data: Data?
    
    init(dataType: MultipeerDataType, isBoolValue: Bool? = nil, data: Data? = nil) {
        self.dataType = dataType
        self.isBoolValue = isBoolValue
        self.data = data
    }
    
    static let isReadyData = MultipeerData(dataType: .isReady, isBoolValue: true)
    static let isNotReadyData = MultipeerData(dataType: .isNotReady, isBoolValue: false)
}
