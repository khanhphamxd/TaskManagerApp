//
//  TaskDetail.swift
//  TaskManager
//
//  Created by Khanh Pham on 12/9/2024.
//

import Foundation

protocol TaskDetail: Identifiable, Codable {
    var id: UUID { get }
    var title: String { get }
    var description: String { get }
    var type: String { get }
    var isCompleted: Bool { get set }
    
    init(id: UUID, title: String, description: String, type: String, isCompleted: Bool)
}

struct WorkTask:    TaskDetail {
    var id = UUID()
    var title: String
    var description: String
    var type = "Work"
    var isCompleted = false
    
    public init(id: UUID = UUID(), title: String, description: String, type: String = "Work", isCompleted: Bool = false) {
            self.id = id
            self.title = title
            self.description = description
            self.type = type
            self.isCompleted = isCompleted
        }
}

struct PersonalTask: TaskDetail {
    var id = UUID()
    var title: String
    var description: String
    var type = "Personal"
    var isCompleted = false
    
    public init(id: UUID = UUID(), title: String, description: String, type: String = "Work", isCompleted: Bool = false) {
            self.id = id
            self.title = title
            self.description = description
            self.type = type
            self.isCompleted = isCompleted
        }
}

struct SocialTask: TaskDetail {
    var id = UUID()
    var title: String
    var description: String
    var type = "Social"
    var isCompleted = false
    
    public init(id: UUID = UUID(), title: String, description: String, type: String = "Work", isCompleted: Bool = false) {
            self.id = id
            self.title = title
            self.description = description
            self.type = type
            self.isCompleted = isCompleted
        }
}
