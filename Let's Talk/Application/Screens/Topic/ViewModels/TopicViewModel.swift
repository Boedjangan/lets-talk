//
//  TopicViewModel.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

@MainActor
class TopicViewModel: ObservableObject {
    @Published var topics: [TopicEntity] = []
    
    private var topicService = TopicService(topicRepository: TopicCoreDataAdapter())
    
    init() {
        fetchTopics()
    }
    
    private func fetchTopics() {
        topics = topicService.getTopics().sorted{
            $0.level < $1.level
        }
    }
    
    func createTopics(topicEntities: [TopicEntity]) {
        topics = topicService.createTopics(topicEntities: topicEntities)
    }
    
    func updateTopicProgress(id: UUID, newProgress: Int16) {
        guard let updatedTopic = topicService.updateTopicProgress(id: id, newProgress: Int(newProgress)) else {
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
    
    func updateTopicMeta(id: UUID, questionOrder: Int) {
        if let topic = topics.first(where: { $0.id == id }) {
            guard let topicQuestions = topic.questions else { return }
            
            let questionsCount = topicQuestions.count
            
            // MARK: Update the progress of how many question has been completed
            let newProgress = questionOrder
            topicService.updateTopicProgress(id: id, newProgress: newProgress)
            topics[topic.level - 1].progress = newProgress
            
            // MARK: When topic is finished all question
            if questionsCount == newProgress {
                topicService.updateCompletedStatus(id: id, completedStatus: true)
                topics[topic.level - 1].isCompleted = true
                
                // MARK: Update next topic status if exist
                if let nextTopic = topics.first(where: { $0.level == topic.level + 1}) {
                    topicService.updateActiveStatus(id: nextTopic.id, activeStatus: true)
                    topics[topic.level].isActive = true
                }
            }
        }
    }
}

