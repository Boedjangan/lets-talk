//
//  TopicRepository.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation


protocol TopicRepository {
    func getTopics() -> [TopicEntity]
<<<<<<< HEAD
    func createTopics(topicEntities: [TopicEntity]) -> [TopicEntity]
    func updateTopicProgress(id: UUID, newProgress: Int) -> TopicEntity?
=======
    func updateTopicProgress(id: UUID, newProgress: Int16) -> TopicEntity?
>>>>>>> main
    func updateActiveStatus(id: UUID, activeStatus: Bool) -> TopicEntity?
    func updateCompletedStatus(id: UUID, completedStatus: Bool) -> TopicEntity?
}
