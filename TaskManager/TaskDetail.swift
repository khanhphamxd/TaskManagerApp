//
//  TaskDetail.swift
//  TaskManager
//
//  Created by Khanh Pham on 12/9/2024.
//

import Foundation

protocol TaskDetail: Identifiable {
    var id: UUID { get }
    var title: String { get }
    var description: String { get }
    var type: String { get }
    var isCompleted: Bool { get set }
}

struct WorkTask: TaskDetail {
    var id = UUID()
    var title: String
    var description: String
    var type = "Work"
    var isCompleted = false
}

struct PersonalTask: TaskDetail {
    var id = UUID()
    var title: String
    var description: String
    var type = "Personal"
    var isCompleted = false
}

struct SocialTask: TaskDetail {
    var id = UUID()
    var title: String
    var description: String
    var type = "Social"
    var isCompleted = false
}
