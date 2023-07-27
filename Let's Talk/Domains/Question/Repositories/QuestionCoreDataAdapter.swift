//
//  QuestionRepositoryImpl.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation
import CoreData

class QuestionCoreDataAdapter: QuestionRepository {
    private let coreDataContext = CoreDataConnection.shared.managedObjectContext
    
    func createNewQuestion(newQuestion: QuestionEntity) -> QuestionEntity? {
        let question = Question(context: coreDataContext)
        
        question.id = newQuestion.id
        question.question = newQuestion.question
        question.warmUp = newQuestion.warmUp
        question.talkDuration = newQuestion.talkDuration.toInt64
        question.isCompleted = newQuestion.isCompleted
        question.createdAt = newQuestion.createdAt
        question.updatedAt = newQuestion.updatedAt
        
        do {
            try coreDataContext.save()
            
            return convertToQuestionEntity(question: question)
        } catch {
            print("Failed creating new question")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func getAllQuestions() -> [QuestionEntity] {
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        var questionEntities: [QuestionEntity] = []
        
        do {
            let questions = try coreDataContext.fetch(request)
            
            for question in questions {
                let questionEntity = convertToQuestionEntity(question: question)
                
                questionEntities.append(questionEntity)
            }
            
            return questionEntities
        } catch {
            print("Failed getting user details")
            print("Error: \(error.localizedDescription)")
            
            return []
        }
    }
    
    func getQuestionById(questionID: UUID) -> QuestionEntity? {
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", questionID as CVarArg)
        
        do {
            let questions = try coreDataContext.fetch(request)
            
            guard let question = questions.first else {
                print("No question is found with the provided ID.")
                return nil
            }
            
            return convertToQuestionEntity(question: question)
        } catch {
            print("Failed updating topic progress")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func deleteQuestion(questionID:UUID) -> QuestionEntity? {
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", questionID as CVarArg)
        
        do {
            let questions = try coreDataContext.fetch(request)
            
            guard let question = questions.first else {
                print("No question is found with the provided ID.")
                return nil
            }
            
            coreDataContext.delete(question)
            
            return convertToQuestionEntity(question: question)
        } catch {
            print("Failed updating topic progress")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
        
    }
    
    func updateQuestionCompleteStatus(questionID: UUID, newStatus: Bool) -> QuestionEntity? {
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", questionID as CVarArg)
        
        do {
            let questions = try coreDataContext.fetch(request)
            
            guard let question = questions.first else {
                print("No question is found with the provided ID.")
                return nil
            }
            
            question.isCompleted = newStatus
            question.updatedAt = Date()
            
            try coreDataContext.save()
            
            return convertToQuestionEntity(question: question)
        } catch {
            print("Failed updating topic progress")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func updateQuestionImage(questionID:UUID, newImage: String) -> QuestionEntity? {
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", questionID as CVarArg)
        
        do {
            let questions = try coreDataContext.fetch(request)
            
            guard let question = questions.first else {
                print("No question is found with the provided ID.")
                return nil
            }
            
            question.image = newImage
            question.updatedAt = Date()
            
            try coreDataContext.save()
            
            return convertToQuestionEntity(question: question)
        } catch {
            print("Failed updating topic progress")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func updateQuestionTalkDuration(questionID: UUID, newDuration: Int) -> QuestionEntity? {
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", questionID as CVarArg)
        
        do {
            let questions = try coreDataContext.fetch(request)
            
            guard let question = questions.first else {
                print("No question is found with the provided ID.")
                return nil
            }
            question.talkDuration = newDuration.toInt64
            question.updatedAt = Date()
            
            try coreDataContext.save()
            
            return convertToQuestionEntity(question: question)
        } catch {
            print("Failed updating topic progress")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    
    func getQuestionsByTopicId() -> [QuestionEntity] {
//        let request: NSFetchRequest<Topic> = Topic.fetchRequest()
        
        return []
    }
    
    
    func convertToQuestionEntity(question: Question) -> QuestionEntity {
        let arrSubQuestions = question.subQuestionArray.map { $0.subQuestion! }
        
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
            answer: question.answer?.recordedAnswer,
            subQuestions: arrSubQuestions,
            topicId: question.topic?.id.unsafelyUnwrapped,
            topicLevel: question.topic?.level.toInt
        )
    }
}
