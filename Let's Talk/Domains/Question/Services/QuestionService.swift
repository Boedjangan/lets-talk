//
//  QuestionService.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

class QuestionService {
    private let questionRepository: QuestionRepository
    
    init(questionRepository: QuestionRepository) {
        self.questionRepository = questionRepository
    }
    
    func getAllQuestions() -> [QuestionEntity]{
        return questionRepository.getAllQuestions()
    }
    
    func getQuestionsByTopicId(topicId: UUID) -> [QuestionEntity]{
        return questionRepository.getQuestionsByTopicId()
    }
    
    func getQuestionById(questionID: UUID) -> QuestionEntity?{
        return questionRepository.getQuestionById(questionID: questionID)
    }
    
    func createNewQuestion(newQuestion: QuestionEntity) -> QuestionEntity?{
        return questionRepository.createNewQuestion(newQuestion: newQuestion)
    }
    
    func updateQuestionCompleteStatus(questionID:UUID,newStatus: Bool) -> QuestionEntity?{
        return questionRepository.updateQuestionCompleteStatus(questionID: questionID, newStatus: newStatus)
    }
    
    func updateQuestionTalkDuration(questionID:UUID,newDuration: Int) -> QuestionEntity?{
        return questionRepository.updateQuestionTalkDuration(questionID: questionID, newDuration: newDuration)
    }
    
    func updateQuestionImage(questionID:UUID,newImage: String) -> QuestionEntity?{
        return questionRepository.updateQuestionImage(questionID: questionID, newImage: newImage)
    }
    
    func updateAnswer(questionId: UUID, newAnswer: AnswerEntity) -> QuestionEntity? {
        return questionRepository.updateAnswer(questionID: questionId, newAnswer: newAnswer)
    }
    
    func deleteQuestion(questionID:UUID) -> QuestionEntity?{
        return questionRepository.deleteQuestion(questionID: questionID)
    }
}

