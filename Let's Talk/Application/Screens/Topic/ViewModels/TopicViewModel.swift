//
//  TopicViewModel.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

class TopicViewModel: ObservableObject {
    @Published var topics: [TopicEntity] = []
    
    private var topicService = TopicService(topicRepository: TopicCoreDataAdapter())
    
    init() {
        fetchTopics()
    }
    
    private func fetchTopics() {
        topics = topicService.getTopics()
    }
    
<<<<<<< HEAD
    func createTopics(topicEntities: [TopicEntity]) {
        topics = topicService.createTopics(topicEntities: topicEntities)
    }
    
    func updateTopicProgress(id: UUID, newProgress: Int16) {
        guard let updatedTopic = topicService.updateTopicProgress(id: id, newProgress: Int(newProgress)) else {
=======
    func updateTopicProgress(id: UUID, newProgress: Int16) {
        guard let updatedTopic = topicService.updateTopicProgress(id: id, newProgress: newProgress) else {
>>>>>>> main
            print("Failed to update topic progress")
            return
        }
        
        if let index = topics.firstIndex(where: { $0.id == id }) {
            topics[index] = updatedTopic
        }
    }
    
    func updateActiveStatus(id: UUID, activeStatus: Bool) {
        guard let updatedTopic = topicService.updateActiveStatus(id: id, activeStatus: activeStatus) else {
            print("Failed to update active status")
            return
        }
        
        if let index = topics.firstIndex(where: { $0.id == id }) {
            topics[index] = updatedTopic
        }
    }
    
    func updateCompletedStatus(id: UUID, completedStatus: Bool) {
        guard let updatedTopic = topicService.updateCompletedStatus(id: id, completedStatus: completedStatus) else {
            print("Failed to update completed status")
            return
        }
        
        if let index = topics.firstIndex(where: { $0.id == id }) {
            topics[index] = updatedTopic
        }
    }
}

