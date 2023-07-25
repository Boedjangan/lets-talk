//
//  SubQuestionEntity.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 25/07/23.
//

import Foundation

struct SubQuestionEntity: Identifiable {
    var id: UUID = UUID()
    var subQuestion: String = ""
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}
