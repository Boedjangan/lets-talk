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
    
    func updateAnswer(questionID: UUID, newAnswer: AnswerEntity) -> QuestionEntity? {
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", questionID as CVarArg)
        
        do {
            let questions = try coreDataContext.fetch(request)
            
            guard let question = questions.first else {
                print("No question is found with the provided ID.")
                return nil
            }
            
            let answer = Answer(context: coreDataContext)
            answer.id = UUID()
            answer.name = newAnswer.name
            answer.recordedAnswer = newAnswer.recordedAnswer
            answer.createdAt = Date()
            answer.updatedAt = Date()
            
            question.answer = answer
            
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
        if question.answer != nil {
            print(question)
        } else {
            print("noQues")
        }
        var subQuestionsEntity: [SubQuestionEntity]?
        if let subQuestions = question.subQuestion as? Set<SubQuestion> {
            subQuestionsEntity = subQuestions.map { convertToSubQuestionEntity(subQuestion: $0)}
        }
        
        var answerEntity: AnswerEntity?
        if let answer = question.answer {
            answerEntity = AnswerEntity(name: answer.name!, recordedAnswer: answer.recordedAnswer!)
        } else {
            answerEntity = AnswerEntity(name: "No answer", recordedAnswer: "No recorded answer")
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
            topicId: question.topic?.id.unsafelyUnwrapped,
            topicName: question.topic?.title.unsafelyUnwrapped,
            topicLevel: question.topic?.level.toInt
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
