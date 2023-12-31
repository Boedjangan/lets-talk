//
//  QuestionEntity.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

struct QuestionEntity: Identifiable {
    var id: UUID = UUID()
    var question: String = ""
    var warmUp: String = ""
    var isCompleted: Bool = false
    var image: String?
    var order: Int = 0
    var talkDuration: Int = 0
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var answer: AnswerEntity?
    var subQuestions: [SubQuestionEntity]?
    var topicId: UUID?
    var topicName: String?
    var topicLevel: Int?
    var topicTitle: String?
}
