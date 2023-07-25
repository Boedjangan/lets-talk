//
//  QuestionRepository.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

protocol QuestionRepository {
    func getAllQuestions() -> [QuestionEntity]
    func getQuestionsByTopicId(topicId: UUID) -> [QuestionEntity]
    func getQestionById(id: UUID) -> QuestionEntity?
    func createNewQuestion(question: QuestionEntity) -> QuestionEntity?
    func updateQuestionCompleteStatus(newStatus: Bool) -> QuestionEntity?
    func updateQuestionTalkDuration(newDuration: Int) -> QuestionEntity?
    func updateQuestionImage(newImage: String) -> QuestionEntity?
    func deleteQuestion() -> QuestionEntity?
}
