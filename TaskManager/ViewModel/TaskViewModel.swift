//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Khanh Pham on 12/9/2024.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published private(set) var tasks: [TaskWrapper] = [] {
        didSet {
            saveTasks()
        }
    }
    
    @Published private(set) var completedTasks: [TaskWrapper] = [] {
        didSet {
            saveTasks()
        }
    }

    init() {
        loadTasks()
    }

    func validateTask(title: String, description: String) throws {
        if title.isEmpty {
            throw TaskError.missingTitle
        }
        if description.isEmpty {
            throw TaskError.missingDescription
        }
    }
    
    func addTask(title: String, description: String, type: String) {
        let task: TaskWrapper
        switch type {
        case "Work":
            task = .work(WorkTask(title: title, description: description))
        case "Personal":
            task = .personal(PersonalTask(title: title, description: description))
        case "Social":
            task = .social(SocialTask(title: title, description: description))
        default:
            return
        }
        tasks.append(task)
    }

    func markTaskAsComplete(_ task: TaskWrapper) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            var completedTask = tasks[index]
            completedTask.isCompleted = true
            completedTasks.append(completedTask)
            tasks.remove(at: index)
        }
    }

    func removeTask(_ task: TaskWrapper) {
        tasks.removeAll { $0.id == task.id }
        completedTasks.removeAll { $0.id == task.id }
    }

    func getAllTasks() -> [TaskWrapper] {
        return tasks
    }

    func getCompletedTasks() -> [TaskWrapper] {
        return completedTasks
    }

    func saveTasks() {
        let encoder = JSONEncoder()
        if let encodedTasks = try? encoder.encode(tasks) {
            UserDefaults.standard.set(encodedTasks, forKey: "tasks")
        }
        if let encodedCompletedTasks = try? encoder.encode(completedTasks) {
            UserDefaults.standard.set(encodedCompletedTasks, forKey: "completedTasks")
        }
    }

    func loadTasks() {
        let decoder = JSONDecoder()
        if let savedTasksData = UserDefaults.standard.data(forKey: "tasks"),
           let decodedTasks = try? decoder.decode([TaskWrapper].self, from: savedTasksData) {
            self.tasks = decodedTasks
        }
        if let savedCompletedTasksData = UserDefaults.standard.data(forKey: "completedTasks"),
           let decodedCompletedTasks = try? decoder.decode([TaskWrapper].self, from: savedCompletedTasksData) {
            self.completedTasks = decodedCompletedTasks
        }
    }

}
