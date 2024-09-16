//
//  TaskManager.swift
//  TaskManager
//
//  Created by Khanh Pham on 14/9/2024.
//

import Foundation

class TaskManager {
    private(set) var tasks: [any TaskDetail] = []
    private(set) var completedTasks: [any TaskDetail] = []

    func addTask(_ task: any TaskDetail) {
        tasks.append(task)
    }

    func getAllTasks() -> [any TaskDetail] {
        return tasks
    }

    func updateTask(_ task: any TaskDetail, with newTask: any TaskDetail) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = newTask
        }
    }

    func removeTask(_ task: any TaskDetail) {
        tasks.removeAll { $0.id == task.id }
    }

    func markTaskAsComplete(_ task: any TaskDetail) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            var completedTask = tasks.remove(at: index)
            completedTask.isCompleted = true
            completedTasks.append(completedTask)
        }
    }

    func getCompletedTasks() -> [any TaskDetail] {
        return completedTasks
    }
}
