//
//  LoveLogRepository.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

protocol LoveLogRepository {
    func getLoveLog() -> [LoveLogEntity]
    func getTodayLoveLog() -> LoveLogEntity?
    func createLoveLog(questionId: UUID) -> LoveLogEntity?
    func addQuestionToLoveLog(id: UUID, questionId: UUID) -> LoveLogEntity?
    func deleteLoveLog(id: UUID)
}
