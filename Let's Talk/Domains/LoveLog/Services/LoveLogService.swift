//
//  LoveLogService.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

class LoveLogService {
    
    private let loveLogRepository: LoveLogRepository

    init(loveLogRepository: LoveLogRepository) {
        self.loveLogRepository = loveLogRepository
    }
    
    func getLoveLog() -> [LoveLogEntity] {
        loveLogRepository.getLoveLog()
    }
    
    func createLoveLog() {
        loveLogRepository.createLoveLog()
    }
    
    func deleteLoveLog(id: UUID) {
        loveLogRepository.deleteLoveLog(id: id)
    }
    
}
