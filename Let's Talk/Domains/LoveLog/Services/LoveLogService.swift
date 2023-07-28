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
    
    func getTodayLoveLog() -> LoveLogEntity? {
        return loveLogRepository.getTodayLoveLog()
    }
    
    func createLoveLog(questionId: UUID) -> LoveLogEntity? {
        return loveLogRepository.createLoveLog(questionId: questionId)
    }
    
    func addQuestionToLoveLog(id: UUID, questionId: UUID) -> LoveLogEntity? {
        return loveLogRepository.addQuestionToLoveLog(id: id, questionId: questionId)
    }
    
    func deleteLoveLog(id: UUID) {
        loveLogRepository.deleteLoveLog(id: id)
    }
}
