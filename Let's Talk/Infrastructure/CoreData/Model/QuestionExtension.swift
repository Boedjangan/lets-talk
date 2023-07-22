//
//  QuestionExtension.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 22/07/23.
//

import Foundation

extension Question {
    public var subQuestionArray: [SubQuestion] {
        let set = subQuestion as? Set<SubQuestion> ?? []
        return set.sorted { $0.createdAt! > $1.createdAt! }
    }
}
