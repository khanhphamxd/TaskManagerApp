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

    private let taskKey = "tasks"
    private let completedTaskKey = "completed_tasks"

    init() {
        loadTasks()
        loadCompletedTasks()
    }

    // MARK: - Task Management

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
        saveTasks()
    }

    func markTaskAsComplete(_ task: any TaskDetail) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            var completedTask = tasks[index]
            completedTask.isCompleted = true
            completedTasks.append(completedTask)
            tasks.remove(at: index)
            saveTasks()
            saveCompletedTasks()
        }
    }

    func removeTask(_ task: any TaskDetail) {
        tasks.removeAll { $0.id == task.id }
        saveTasks()
    }

    // MARK: - Storage

    func saveTasks() {
        do {
            let data = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: taskKey)
        } catch {
            print("Error saving tasks: \(error.localizedDescription)")
        }
    }

    func saveCompletedTasks() {
        do {
            let data = try JSONEncoder().encode(completedTasks)
            UserDefaults.standard.set(data, forKey: completedTaskKey)
        } catch {
            print("Error saving completed tasks: \(error.localizedDescription)")
        }
    }

    func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: taskKey) {
            do {
                tasks = try JSONDecoder().decode([any TaskDetail].self, from: data)
            } catch {
                print("Error loading tasks: \(error.localizedDescription)")
            }
        }
    }

    func loadCompletedTasks() {
        if let data = UserDefaults.standard.data(forKey: completedTaskKey) {
            do {
                completedTasks = try JSONDecoder().decode([any TaskDetail].self, from: data)
            } catch {
                print("Error loading completed tasks: \(error.localizedDescription)")
            }
        }
    }
}
