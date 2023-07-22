//
//  UserExtension.swift
//  Let's Talk
//
//  Created by Bambang Ardiyansyah on 22/07/23.
//

import Foundation

extension User {
    public var loveLogArray: [LoveLog] {
        let set = loveLog as? Set<LoveLog> ?? []
        return set.sorted { $0.createdAt! > $1.createdAt! }
    }
}
