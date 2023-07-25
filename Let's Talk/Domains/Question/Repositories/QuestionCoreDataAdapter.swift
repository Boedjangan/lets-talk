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
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        
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
            
            return question
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
                
                topicEntities.append(topicEntity)
            }
            
            return topicEntities
        } catch {
            print("Failed getting user details")
            print("Error: \(error.localizedDescription)")
            
            return []
        }
    }
    
    func getQestionById(id: UUID) -> QuestionEntity? {
        let request: NSFetchRequest<Topic> = Topic.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let questions = try coreDataContext.fetch(request)
            
            guard let question = questions.first else {
                print("No question is found with the provided ID.")
                return nil
            }
            
            return convertToTopicEntity(topic: topic)
        } catch {
            print("Failed updating topic progress")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func convertToQuestionEntity(question: Question) {
        return QuestionEntity(
            id: question.id.unsafelyUnwrapped,
            question: question.question.unsafelyUnwrapped,
            warmUp: question.warmUp.unsafelyUnwrapped,
            isCompleted: question.isCompleted,
            image: question.image,
            talkDuration: question.talkDuration.toInt,
            createdAt: question.createdAt.unsafelyUnwrapped,
            updatedAt: question.updatedAt.unsafelyUnwrapped,
            answer: question.answer?.recordedAnswer,
            subQuestions: question.subQuestionArray,
            topic: question.topic?.title,
        )
    }
}
