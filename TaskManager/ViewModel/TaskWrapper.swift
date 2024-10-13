//
//  TaskWrapper.swift
//  TaskManager
//
//  Created by Khanh Pham on 13/10/2024.
//

import Foundation

enum TaskWrapper: Codable, TaskDetail {
    case work(WorkTask)
    case personal(PersonalTask)
    case social(SocialTask)

    var id: UUID {
        switch self {
        case .work(let task):
            return task.id
        case .personal(let task):
            return task.id
        case .social(let task):
            return task.id
        }
    }
    
    var title: String {
        switch self {
        case .work(let task):
            return task.title
        case .personal(let task):
            return task.title
        case .social(let task):
            return task.title
        }
    }

    var description: String {
        switch self {
        case .work(let task):
            return task.description
        case .personal(let task):
            return task.description
        case .social(let task):
            return task.description
        }
    }

    var type: String {
        switch self {
        case .work:
            return "Work"
        case .personal:
            return "Personal"
        case .social:
            return "Social"
        }
    }

    var isCompleted: Bool {
            get {
                switch self {
                case .work(let task):
                    return task.isCompleted
                case .personal(let task):
                    return task.isCompleted
                case .social(let task):
                    return task.isCompleted
                }
            }
            set {
                switch self {
                case .work(var task):
                    task.isCompleted = newValue
                    self = .work(task) // Update the TaskWrapper to hold the modified task
                case .personal(var task):
                    task.isCompleted = newValue
                    self = .personal(task)
                case .social(var task):
                    task.isCompleted = newValue
                    self = .social(task)
                }
            }
        }

    mutating func setCompletionStatus(_ completed: Bool) {
        switch self {
        case .work(var task):
            task.isCompleted = completed
            self = .work(task)
        case .personal(var task):
            task.isCompleted = completed
            self = .personal(task)
        case .social(var task):
            task.isCompleted = completed
            self = .social(task)
        }
    }

    // Implementing the required initializer from the protocol
    init(id: UUID, title: String, description: String, type: String, isCompleted: Bool) {
        switch type {
        case "Work":
            self = .work(WorkTask(id: id, title: title, description: description, isCompleted: isCompleted))
        case "Personal":
            self = .personal(PersonalTask(id: id, title: title, description: description, isCompleted: isCompleted))
        case "Social":
            self = .social(SocialTask(id: id, title: title, description: description, isCompleted: isCompleted))
        default:
            fatalError("Invalid task type")
        }
    }
    
    enum CodingKeys: String, CodingKey {
            case type, task
    }

    enum TaskType: String, Codable {
        case work
        case personal
        case social
    }

    // Encoding function
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .work(let task):
            try container.encode(TaskType.work, forKey: .type)
            try container.encode(task, forKey: .task)
        case .personal(let task):
            try container.encode(TaskType.personal, forKey: .type)
            try container.encode(task, forKey: .task)
        case .social(let task):
            try container.encode(TaskType.social, forKey: .type)
            try container.encode(task, forKey: .task)
        }
    }

    // Decoding function
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(TaskType.self, forKey: .type)
        switch type {
        case .work:
            let task = try container.decode(WorkTask.self, forKey: .task)
            self = .work(task)
        case .personal:
            let task = try container.decode(PersonalTask.self, forKey: .task)
            self = .personal(task)
        case .social:
            let task = try container.decode(SocialTask.self, forKey: .task)
            self = .social(task)
        }
    }
}
