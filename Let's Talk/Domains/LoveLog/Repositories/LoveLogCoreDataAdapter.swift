//
//  LoveLogRepositoryImpl.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation
import CoreData

class LoveLogCoreDataAdapter: LoveLogRepository {
    
    private let coreDataContext = CoreDataConnection.shared.managedObjectContext
    
    func getLoveLog() -> [LoveLogEntity] {
        let request: NSFetchRequest<LoveLog> = LoveLog.fetchRequest()
        var loveLogEntities: [LoveLogEntity] = []
        
        do {
            let loveLogs = try coreDataContext.fetch(request)
            for loveLog in loveLogs {
                let loveLogEntity = convertToLoveLogEntity(loveLog: loveLog)
                loveLogEntities.append(loveLogEntity)
            }
            
            return loveLogEntities
            
        } catch {
            print("Failed to create new topic")
            print("Error: \(error.localizedDescription)")
            
            return []
        }
    }
    
    func createLoveLog() {
        let newLoveLog = LoveLog(context: coreDataContext)
        newLoveLog.id = UUID()
        newLoveLog.createdAt = Date()
        newLoveLog.updatedAt = Date()
        
        do {
            try coreDataContext.save()
            print("Love Log Saved")
        } catch {
            print("Failed to create new topic")
            print("Error: \(error.localizedDescription)")
        }
        
        
    }
    
    func deleteLoveLog(id: UUID) {
        let fetchRequest: NSFetchRequest<LoveLog> = LoveLog.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let objects = try coreDataContext.fetch(fetchRequest)
            
            for object in objects {
                coreDataContext.delete(object)
            }
            
            try coreDataContext.save()
            
        } catch {
            print("Failed to delete LoveLogEntity: \(error)")
        }
    }

    
    func convertToLoveLogEntity(loveLog: LoveLog) -> LoveLogEntity {
        var questionsEntity: [QuestionEntity] = []
        
        if let questions = loveLog.question as? Set<Question> {
            questionsEntity = questions.map { convertToQuestionEntity(question: $0)}
        }
        
        return LoveLogEntity(
            id: loveLog.id.unsafelyUnwrapped,
            createdAt: loveLog.createdAt.unsafelyUnwrapped,
            updatedAt: loveLog.updatedAt.unsafelyUnwrapped,
            questions: questionsEntity
        )
    }
    
    func convertToQuestionEntity(question: Question) -> QuestionEntity {
        var subQuestionsEntity: [SubQuestionEntity] = []
        if let subQuestions = question.subQuestion as? Set<SubQuestion> {
            subQuestionsEntity = subQuestions.map { convertToSubQuestionEntity(subQuestion: $0)}
        }
        var answerEntity: AnswerEntity?
        if let answer = question.answer {
            answerEntity = AnswerEntity(name: answer.name!, recordedAnswer: answer.recordedAnswer!)
        }
        
        return QuestionEntity(
            id: question.id.unsafelyUnwrapped,
            question: question.question.unsafelyUnwrapped,
            warmUp: question.warmUp.unsafelyUnwrapped,
            isCompleted: question.isCompleted,
            image: question.image,
            order: question.order.toInt,
            talkDuration: question.talkDuration.toInt,
            createdAt: question.createdAt.unsafelyUnwrapped,
            updatedAt: question.updatedAt.unsafelyUnwrapped,
            answer: answerEntity,
            subQuestions: subQuestionsEntity,
            topicId: question.topic?.id.unsafelyUnwrapped
        )
    }
    
    func convertToSubQuestionEntity(subQuestion: SubQuestion) -> SubQuestionEntity {
        return SubQuestionEntity(
            id: subQuestion.id!,
            subQuestion: subQuestion.subQuestion!,
            createdAt: subQuestion.createdAt!,
            updatedAt: subQuestion.updatedAt!)
    }
    
    
}
