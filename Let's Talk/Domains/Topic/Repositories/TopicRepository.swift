//
//  TopicRepository.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation


protocol TopicRepository {
    func getTopics() -> [TopicEntity]
    func updateTopicProgress(id: UUID, newProgress: Int) -> TopicEntity?
    func updateActiveStatus(id: UUID, activeStatus: Bool) -> TopicEntity?
    func updateCompletedStatus(id: UUID, completedStatus: Bool) -> TopicEntity?
}
