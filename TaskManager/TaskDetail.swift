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
    var category: String { get }
    var isCompleted: Bool { get set }
}

class WorkTask: TaskDetail {
    var id = UUID()
    var title: String
    var description: String
    var category: String = "Work"
    var isCompleted: Bool = false
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

class PersonalTask: TaskDetail {
    var id = UUID()
    var title: String
    var description: String
    var category: String = "Personal"
    var isCompleted: Bool = false
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

class SocialTask: TaskDetail {
    var id = UUID()
    var title: String
    var description: String
    var category: String = "Social"
    var isCompleted: Bool = false
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
