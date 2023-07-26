//
//  TopicExtension.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 22/07/23.
//

import Foundation

extension Topic {
    public var questionArray: [Question] {
        let set = question as? Set<Question> ?? []
        return set.sorted { $0.order < $1.order }
    }
}
