//
//  TopicCoreDataAdapter.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 24/07/23.
//

import Foundation
import CoreData

class TopicCoreDataAdapter: TopicRepository {
    private let coreDataContext = CoreDataConnection.shared.managedObjectContext
    
    func getTopics() -> [TopicEntity] {
        let request: NSFetchRequest<Topic> = Topic.fetchRequest()
        var topicEntities: [TopicEntity] = []
        
        do {
            let topics = try coreDataContext.fetch(request)
            
            for topic in topics {
                let topicEntity = convertToTopicEntity(topic: topic)
                topicEntities.append(topicEntity)
            }
            return topicEntities
        } catch {
            print("Failed getting user details")
            print("Error: \(error.localizedDescription)")
            
            return []
        }
    }
    
    func createTopics(topicEntities: [TopicEntity]) -> [TopicEntity] {
        var createdTopics: [TopicEntity] = []
        
        for topicEntity in topicEntities {
            let newTopic = Topic(context: coreDataContext)
            newTopic.id = UUID()
            newTopic.iconName = topicEntity.iconName
            newTopic.isActive = topicEntity.isActive
            newTopic.isCompleted = topicEntity.isCompleted
            newTopic.level = Int16(topicEntity.level)
            newTopic.progress = Int16(topicEntity.progress)
            newTopic.title = topicEntity.title
            newTopic.createdAt = Date()
            newTopic.updatedAt = Date()
            
            if let questions = topicEntity.questions {
                for question in questions {
                    let newQuestion =  Question(context: coreDataContext)
                    newQuestion.id = UUID()
                    newQuestion.image = question.image
                    newQuestion.isCompleted = question.isCompleted
                    newQuestion.question = question.question
                    newQuestion.talkDuration = Int64(question.talkDuration)
                    newQuestion.warmUp = question.warmUp
                    newQuestion.createdAt = Date()
                    newQuestion.updatedAt = Date()
                    
                    newTopic.addToQuestion(newQuestion)
                    
                    if let subQuestions = question.subQuestions {
                        for subQuestion in subQuestions {
                            let newSubQuestion = SubQuestion(context: coreDataContext)
                            newSubQuestion.id = UUID()
                            newSubQuestion.subQuestion = subQuestion.subQuestion
                            newSubQuestion.createdAt = Date()
                            newSubQuestion.updatedAt = Date()
                            
                            newQuestion.addToSubQuestion(newSubQuestion)
                            
                            do {
                                try coreDataContext.save()
                            } catch {
                                print("Failed to create new topic")
                                print("Error: \(error.localizedDescription)")
                            }
                        }
                    }
                    do {
                        try coreDataContext.save()
                    } catch {
                        print("Failed to create new topic")
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            
            do {
                try coreDataContext.save()
                print("Entity Saved")
                //                createdTopics.append(topicEntity)
            } catch {
                print("Failed to create new topic")
                print("Error: \(error.localizedDescription)")
            }
        }
        
        return createdTopics
    }
    
    func updateTopicProgress(id: UUID, newProgress: Int) -> TopicEntity? {
        let request: NSFetchRequest<Topic> = Topic.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let topics = try coreDataContext.fetch(request)
            
            guard let topic = topics.first else {
                print("No topic found with the provided ID.")
                return nil
            }
            topic.progress = newProgress.toInt16
            
            try coreDataContext.save()
            
            return convertToTopicEntity(topic: topic)
        } catch {
            print("Failed updating topic progress")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func updateActiveStatus(id: UUID, activeStatus: Bool) -> TopicEntity? {
        let request: NSFetchRequest<Topic> = Topic.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let topics = try coreDataContext.fetch(request)
            
            guard let topic = topics.first else {
                print("No topic found with the provided ID.")
                return nil
            }
            
            topic.isActive = activeStatus
            try coreDataContext.save()
            
            return convertToTopicEntity(topic: topic)
        } catch {
            print("Failed updating active status")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func updateCompletedStatus(id: UUID, completedStatus: Bool) -> TopicEntity? {
        let request: NSFetchRequest<Topic> = Topic.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let topics = try coreDataContext.fetch(request)
            
            guard let topic = topics.first else {
                print("No topic found with the provided ID.")
                return nil
            }
            
            topic.isCompleted = completedStatus
            try coreDataContext.save()
            
            return convertToTopicEntity(topic: topic)
        } catch {
            print("Failed updating completed status")
            print("Error: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func convertToTopicEntity(topic: Topic) -> TopicEntity {
        var questionsEntity: [QuestionEntity] = []
        
        if let questions = topic.question as? Set<Question> {
            questionsEntity = questions.map { convertToQuestionEntity(question: $0)}
        }
        
        return TopicEntity(
            id: topic.id.unsafelyUnwrapped,
            iconName: topic.iconName.unsafelyUnwrapped,
            isActive: topic.isActive,
            isCompleted: topic.isCompleted,
            level: Int(topic.level),
            progress: Int(topic.progress),
            title: topic.title ?? "",
            questions: questionsEntity,
            createdAt: topic.createdAt.unsafelyUnwrapped,
            updatedAt: topic.updatedAt.unsafelyUnwrapped
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
