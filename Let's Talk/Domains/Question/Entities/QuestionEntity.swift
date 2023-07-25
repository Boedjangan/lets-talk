//
//  QuestionEntity.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

struct QuestionEntity {
    var id: UUID = UUID()
    var question: String
    var warmUp: String
    var isCompleted: Bool = false
    var image: String?
    var talkDuration: Int = 0
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var answer: String?
    var subQuestions: [String]?
    var topic: Topic?
}
