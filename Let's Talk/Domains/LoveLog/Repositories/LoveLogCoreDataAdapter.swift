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
            print("Failed to fetching love logs")
            print("Error: \(error.localizedDescription)")
            
            return []
        }
    }
    
    func getTodayLoveLog() -> LoveLogEntity? {
        let theDate = Date.now
        let startDate = Calendar.current.startOfDay(for: theDate)
        let endDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: theDate) ?? theDate
        
        let request: NSFetchRequest<LoveLog> = LoveLog.fetchRequest()
        
        request.predicate = NSPredicate(format: "(createdAt >= %@) AND (createdAt <= %@)", startDate as CVarArg, endDate as CVarArg)
        
        do {
            let loveLogs = try coreDataContext.fetch(request)
            
            guard let loveLog = loveLogs.first else {
                return nil
            }
            
            return convertToLoveLogEntity(loveLog: loveLog)
        } catch {
            print("Failed to fetching love log")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func createLoveLog(questionId: UUID) -> LoveLogEntity? {
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", questionId as CVarArg)
        
        let newLoveLog = LoveLog(context: coreDataContext)
        
        do {
            let questions = try coreDataContext.fetch(request)
            
            guard let question = questions.first else {
                print("No question is found with the provided ID.")
                
                return nil
            }
            
            newLoveLog.addToQuestion(question)
        } catch {
            print("Failed getting question")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
        
        newLoveLog.id = UUID()
        newLoveLog.createdAt = Date()
        newLoveLog.updatedAt = Date()
        
        do {
            try coreDataContext.save()
            
            print("Love Log Saved")
            return convertToLoveLogEntity(loveLog: newLoveLog)
        } catch {
            print("Failed to create new topic")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func addQuestionToLoveLog(id: UUID, questionId: UUID) -> LoveLogEntity? {
        let requestQuestion: NSFetchRequest<Question> = Question.fetchRequest()
        requestQuestion.predicate = NSPredicate(format: "id == %@", questionId as CVarArg)
        
        let requestLoveLog: NSFetchRequest<LoveLog> = LoveLog.fetchRequest()
        requestLoveLog.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let questions = try coreDataContext.fetch(requestQuestion)
            let loveLogs = try coreDataContext.fetch(requestLoveLog)
            
            guard let loveLog = loveLogs.first, let question = questions.first else {
                print("No question / No love log is found with the provided ID.")
                
                return nil
            }
            
            loveLog.addToQuestion(question)
            loveLog.updatedAt = Date()
            
            try coreDataContext.save()
            
            return convertToLoveLogEntity(loveLog: loveLog)
        } catch {
            print("Failed getting question")
            print("Error: \(error.localizedDescription)")
            
            return nil
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
