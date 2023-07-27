//
//  CoreDataConnection.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 11/07/23.
//

import CoreData

struct CoreDataConnection {
    static let shared = CoreDataConnection()
    let container: NSPersistentContainer
    
    var managedObjectContext: NSManagedObjectContext {
        container.viewContext
    }
    
    func seedData(context: NSManagedObjectContext) {
        let request: NSFetchRequest<Topic> = Topic.fetchRequest()
        let topicCount = try! context.count(for: request)
        
        guard topicCount == 0 else {
            print("COUNT: \(topicCount)")
            print("NOT SEEDING! Because already has data!")
            return
        }
        
        guard let data = loadJSONAsDict("InitialData") else {
            print("Seed data not found!")
            return
        }
        
        // MARK - Topic Seeding
        for topicMock in data {
            let topic = Topic(context: context)
            
            topic.id = UUID()
            topic.createdAt = Date()
            topic.updatedAt = Date()
            
            
            if let iconName = topicMock["iconName"] as? String {
                topic.iconName = iconName
            }
            
            if let isActive = topicMock["isActive"] as? Bool {
                topic.isActive = isActive
            }
            
            if let level = topicMock["level"] as? Int16 {
                topic.level = level
            }
            
            if let progress = topicMock["progress"] as? Int16 {
                topic.progress = progress
            }
            
            if let isCompleted = topicMock["isCompleted"] as? Bool {
                topic.isCompleted = isCompleted
            }
            
            if let title = topicMock["title"] as? String {
                topic.title = title
            }
            
            // MARK - Questions Seeding
            if let questions = topicMock["questions"] as? [[String: Any]] {
                for topicQuestion in questions {
                    let question = Question(context: context)
                    
                    question.id = UUID()
                    question.isCompleted = false
                    question.talkDuration = 0
                    question.createdAt = Date()
                    question.updatedAt = Date()
                    
                    if let questionText = topicQuestion["question"] as? String {
                        question.question = questionText
                    }
                        
                    if let warmUp = topicQuestion["warmUp"] as? String {
                        question.warmUp = warmUp
                    }
                    
                    if let order = topicQuestion["order"] as? Int64 {
                        question.order = order
                    }
                    
                    // MARK - Sub Questions Seeding
                    if let subQuestions = topicQuestion["subQuestions"] as? [String] {
                        for subQuestionText in subQuestions {
                            let subQuestion = SubQuestion(context: context)
                            
                            subQuestion.id = UUID()
                            subQuestion.createdAt = Date()
                            subQuestion.updatedAt = Date()
                            subQuestion.subQuestion = subQuestionText
                            
                            question.addToSubQuestion(subQuestion)
                        }
                    }
                    
                    topic.addToQuestion(question)
                }
            }
        }
        
        // Save changes of seeding data
        do {
            print("SUCCESS - Seeding core data")
            try context.save()
        } catch {
            print("Error Seeding: \(error.localizedDescription)")
        }
    }
    
    init() {
        container = NSPersistentContainer(name: "Let_s_Talk")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        seedData(context: container.viewContext)
    }
}
