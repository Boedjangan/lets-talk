//
//  TopicService.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

class TopicService {
    private let topicRepository: TopicRepository
    
    init(topicRepository: TopicRepository) {
        self.topicRepository = topicRepository
    }
    
    func getTopics() -> [TopicEntity] {
        return topicRepository.getTopics()
    }
    
    func createTopics(topicEntities: [TopicEntity]) -> [TopicEntity] {
        return topicRepository.createTopics(topicEntities: topicEntities)
    }
    
    func updateTopicProgress(id: UUID, newProgress: Int) -> TopicEntity? {
        return topicRepository.updateTopicProgress(id: id, newProgress: newProgress)
    }
    
    func updateActiveStatus(id: UUID, activeStatus: Bool) -> TopicEntity? {
        return topicRepository.updateActiveStatus(id: id, activeStatus: activeStatus)
    }
    
    func updateCompletedStatus(id: UUID, completedStatus: Bool) -> TopicEntity? {
        return topicRepository.updateCompletedStatus(id: id, completedStatus: completedStatus)
    }
}
