//
//  AnswerEntity.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 27/07/23.
//

import Foundation

struct AnswerEntity: Identifiable {
    var id: UUID = UUID()
    var name: String
    var recordedAnswer: String
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}
