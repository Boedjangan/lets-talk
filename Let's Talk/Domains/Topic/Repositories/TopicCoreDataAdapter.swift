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
            
            //core data entity (Question) need to change to Domain Entity (QuestionEntity)
            if let questions = topicEntity.questions as? [Question] {
                for question in questions {
                    let newQuestion =  Question(context: coreDataContext)
                    newQuestion.id = UUID()
                    newQuestion.image = question.image
                    newQuestion.isCompleted = question.isCompleted
                    newQuestion.question = question.question
                    newQuestion.talkDuration = question.talkDuration
                    newQuestion.warmUp = question.warmUp
                    newQuestion.createdAt = Date()
                    newQuestion.updatedAt = Date()
                    
                    newTopic.addToQuestion(newQuestion)
                    
                    if let subQuestions = question.subQuestion as? [SubQuestionEntity] {
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
            var questions: [Any] = []
            
            // Convert topic.questions to [Any]
            if let topicQuestions = topic.question as? Set<Question> {
                questions = Array(topicQuestions)
            }
            
            return TopicEntity(
                id: topic.id.unsafelyUnwrapped,
                iconName: topic.iconName.unsafelyUnwrapped,
                isActive: topic.isActive,
                isCompleted: topic.isCompleted,
                level: Int(topic.level),
                progress: Int(topic.progress),
                title: topic.title ?? "",
                questions: questions,
                createdAt: topic.createdAt.unsafelyUnwrapped,
                updatedAt: topic.updatedAt.unsafelyUnwrapped
            )
        }
}
