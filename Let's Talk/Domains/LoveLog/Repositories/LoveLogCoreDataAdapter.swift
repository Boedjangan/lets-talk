//
//  LoveLogRepositoryImpl.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation
import CoreData

class LoveLogCoreDataAdapter: LoveLogRepository {
    private let coreDataContext = CoreDataConnection.shared.managedObjectContext
    
    func getLoveLog() -> [LoveLogEntity] {
        let request: NSFetchRequest<LoveLog> = LoveLog.fetchRequest()
        var loveLogEntities: [LoveLogEntity] = []
        
        do {
            let loveLogs = try coreDataContext.fetch(request)
            for loveLog in loveLogs {
                let loveLogEntity = convertToLoveLogEntity(loveLog: loveLog)
                loveLogEntities.append(loveLogEntity)
            }
        } catch {
            
        }
    }
    
    func deleteLoveLog(id: UUID) -> LoveLogEntity? {
        <#code#>
    }
    
    func convertToLoveLogEntity(loveLog: LoveLog) -> [LoveLogEntity] {
        
    }
    
    
}
