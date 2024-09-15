//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Khanh Pham on 12/9/2024.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published private(set) var tasks: [any TaskDetail] = []
    @Published private(set) var completedTasks: [any TaskDetail] = []

    func addTask(title: String, description: String, type: String) {
        let task: any TaskDetail
        switch type {
        case "Work":
            task = WorkTask(title: title, description: description)
        case "Personal":
            task = PersonalTask(title: title, description: description)
        case "Social":
            task = SocialTask(title: title, description: description)
        default:
            return
        }
        tasks.append(task)
    }

    func markTaskAsComplete(_ task: any TaskDetail) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            var completedTask = tasks[index]
            completedTask.isCompleted = true
            completedTasks.append(completedTask)
            tasks.remove(at: index)
        }
    }

    func removeTask(_ task: any TaskDetail) {
        tasks.removeAll { $0.id == task.id }
    }

    func getAllTasks() -> [any TaskDetail] {
        return tasks
    }

    func getCompletedTasks() -> [any TaskDetail] {
        return completedTasks
    }
}
