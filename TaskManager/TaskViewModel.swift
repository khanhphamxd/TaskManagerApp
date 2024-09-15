//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Khanh Pham on 12/9/2024.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published private(set) var tasks: [TaskDetail] = []
    @Published private(set) var completedTasks: [TaskDetail] = []

    func addTask(title: String, description: String, type: String) {
        let task: TaskDetail
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

    func markTaskAsComplete(_ task: TaskDetail) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            var completedTask = tasks[index]
            completedTask.isCompleted = true
            completedTasks.append(completedTask)
            tasks.remove(at: index)
        }
    }

    func removeTask(_ task: TaskDetail) {
        tasks.removeAll { $0.id == task.id }
    }

    func getAllTasks() -> [TaskDetail] {
        return tasks
    }

    func getCompletedTasks() -> [TaskDetail] {
        return completedTasks
    }
}
