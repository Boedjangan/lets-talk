//
//  LoveLogRepository.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

protocol LoveLogRepository {
    func getLoveLog() -> [LoveLogEntity]
    func createLoveLog()
    func deleteLoveLog(id: UUID)
}
