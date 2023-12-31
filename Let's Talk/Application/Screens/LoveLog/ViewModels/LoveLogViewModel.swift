//
//  LoveLogViewModel.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation


struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}

@MainActor
class LoveLogViewModel: ObservableObject {
    @Published var loveLogs: [LoveLogEntity] = []
    
    private var loveLogService = LoveLogService(loveLogRepository: LoveLogCoreDataAdapter())
    
    init() {
        fetchLoveLog()
    }
    
    private func fetchLoveLog() {
        loveLogs = loveLogService.getLoveLog().sorted {
            $0.createdAt < $1.createdAt
        }
    }
    
    func createLoveLog(questionId: UUID) {
        guard let loveLog = loveLogService.createLoveLog(questionId: questionId) else {
            print("Failed creating lovelog")
            
            return
        }
        
        loveLogs.append(loveLog)
    }
    
    func addQuestionToLoveLog(id: UUID, questionId: UUID) {
        guard let lovelog = loveLogService.addQuestionToLoveLog(id: id, questionId: questionId) else {
            print("Failed adding question to lovelog")
            
            return
        }
        
        if let index = loveLogs.firstIndex(where: { $0.id == id }) {
            loveLogs[index] = lovelog
        }
    }
    
    func deleteLoveLog(id: UUID) {
        loveLogService.deleteLoveLog(id: id)
    }
    
    func handleFinishSession(questionId: UUID) {
        if let lovelog = loveLogService.getTodayLoveLog() {
            addQuestionToLoveLog(id: lovelog.id, questionId: questionId)
        } else {
            createLoveLog(questionId: questionId)
        }
    }
}
