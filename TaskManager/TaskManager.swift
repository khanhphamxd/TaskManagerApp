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

    // Add a task (Create)
    func addTask(_ task: any TaskDetail) {
        tasks.append(task)
    }

    // Get all tasks (Read)
    func getAllTasks() -> [any TaskDetail] {
        return tasks
    }

    // Update a task
    func updateTask(_ task: any TaskDetail, with newTask: any TaskDetail) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = newTask
        }
    }

    // Remove a task (Delete)
    func removeTask(_ task: any TaskDetail) {
        tasks.removeAll { $0.id == task.id }
    }

    // Mark a task as completed
    func markTaskAsComplete(_ task: any TaskDetail) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            var completedTask = tasks.remove(at: index)
            completedTask.isCompleted = true
            completedTasks.append(completedTask)
        }
    }

    // Get completed tasks
    func getCompletedTasks() -> [any TaskDetail] {
        return completedTasks
    }
}
