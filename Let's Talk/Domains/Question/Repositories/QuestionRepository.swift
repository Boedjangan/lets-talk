//
//  QuestionRepository.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

protocol QuestionRepository {
    func getAllQuestions() -> [QuestionEntity]
    func getQuestionsByTopicId() -> [QuestionEntity]
    func getQuestionById(questionID: UUID) -> QuestionEntity?
    func createNewQuestion(newQuestion: QuestionEntity) -> QuestionEntity?
    func updateQuestionCompleteStatus(questionID:UUID,newStatus: Bool) -> QuestionEntity?
    func updateQuestionTalkDuration(questionID:UUID,newDuration: Int) -> QuestionEntity?
    func updateQuestionImage(questionID:UUID,newImage: String) -> QuestionEntity?
    func updateAnswer(questionID:UUID, newAnswer: AnswerEntity) -> QuestionEntity?
    func deleteQuestion(questionID:UUID) -> QuestionEntity?
}
