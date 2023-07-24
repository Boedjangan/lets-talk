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
                let topicEntity = TopicEntity(
                    id: topic.id.unsafelyUnwrapped,
                    iconName: topic.iconName.unsafelyUnwrapped,
                    isActive: topic.isActive,
                    isCompleted: topic.isCompleted,
                    level: Int(topic.level),
                    progress: Int(topic.progress),
                    title: topic.title ?? "",
                    createdAt: topic.createdAt.unsafelyUnwrapped,
                    updatedAt: topic.updatedAt.unsafelyUnwrapped
                )
                topicEntities.append(topicEntity)
            }
            
            return topicEntities
        } catch {
            print("Failed getting user details")
            print("Error: \(error.localizedDescription)")
            
            return []
        }
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
        return TopicEntity(
            id: topic.id.unsafelyUnwrapped,
            iconName: topic.iconName.unsafelyUnwrapped,
            isActive: topic.isActive,
            isCompleted: topic.isCompleted,
            level: Int(topic.level.toInt),
            progress: Int(topic.progress.toInt),
            title: topic.title ?? "",
            createdAt: topic.createdAt.unsafelyUnwrapped,
            updatedAt: topic.updatedAt.unsafelyUnwrapped
        )
    }
}
