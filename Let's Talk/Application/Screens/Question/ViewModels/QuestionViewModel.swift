//
//  QuestionViewModel.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

@MainActor
class QuestionViewModel: ObservableObject {
    @Published var questions: [QuestionEntity] = []
    
    private var questionService = QuestionService(questionRepository: QuestionCoreDataAdapter())
    
    init() {
        fetchQuestions()
    }
    
    private func fetchQuestions() {
        questions = questionService.getAllQuestions()
    }
    
    func getQuestionById(questionId: UUID) -> QuestionEntity? {
        return questions.first { $0.id == questionId }
    }
    
    func getQuestionsByTopicId(topicId: UUID) -> [QuestionEntity] {
        let filteredQuestion = questions.filter { $0.id == topicId }
        
        return filteredQuestion
    }
    
    // TODO: Handle error handling on nil return
    func updateQuestionTalkDuration(questionId: UUID, newDuration: Int) {
        let newQuestions = questions.map {
            if $0.id == questionId {
                var newQ = $0
                
                newQ.talkDuration = newDuration
                newQ.updatedAt = Date()
                
                return newQ
            }
            
            return $0
        }
        
        questions = newQuestions
        questionService.updateQuestionTalkDuration(questionID: questionId, newDuration: newDuration)
    }
    
    // TODO: Handle error handling on nil return
    func updateQuestionCompleteStatus(questionId: UUID, newStatus: Bool) {
        let newQuestions = questions.map {
            if $0.id == questionId {
                var newQ = $0
                
                newQ.isCompleted = newStatus
                newQ.updatedAt = Date()
                
                return newQ
            }
            
            return $0
        }
        
        questions = newQuestions
        questionService.updateQuestionCompleteStatus(questionID: questionId, newStatus: newStatus)
    }
    
    // TODO: Handle error handling on nil return
    func updateQuestionImage(questionId: UUID, newImage: String) {
        let newQuestions = questions.map {
            if $0.id == questionId {
                var newQ = $0
                
                newQ.image = newImage
                newQ.updatedAt = Date()
                
                return newQ
            }
            
            return $0
        }
        
        questions = newQuestions
        questionService.updateQuestionImage(questionID: questionId, newImage: newImage)
    }
}
