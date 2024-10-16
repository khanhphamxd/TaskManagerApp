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

    private let networkManager: NetworkManager

    // Initialize with NetworkManager
    init() {
        self.networkManager = NetworkManager(url: "https://hbwjhhzjfluexwgtbrny.supabase.co", key: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhid2poaHpqZmx1ZXh3Z3Ricm55Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg5NTMzNjIsImV4cCI6MjA0NDUyOTM2Mn0.mTPlFifMlhZ5rhf5_Ib6ycun7nibgrxVs89wcMOtMM4") // Initialize NetworkManager
        loadTasks()
        fetchTasksFromSupabase() // Fetch tasks from Supabase during initialization
    }

    func validateTask(title: String, description: String) throws {
        if title.isEmpty {
            throw TaskError.missingTitle
        }
        if description.isEmpty {
            throw TaskError.missingDescription
        }
    }
    
    func addTask(title: String, description: String, type: String, completion: ((Bool) -> Void)? = nil) {
        let task: TaskWrapper
        switch type {
        case "Work":
            task = .work(WorkTask(title: title, description: description))
        case "Personal":
            task = .personal(PersonalTask(title: title, description: description))
        case "Social":
            task = .social(SocialTask(title: title, description: description))
        default:
            completion?(false)
            return
        }
        
        // Add the task locally first
        self.tasks.append(task)
        
        // Then attempt to add the task to the Supabase database
        networkManager.addTask(task) { success in
            DispatchQueue.main.async {
                if success {
                    // Optionally confirm success here
                    completion?(true)
                } else {
                    // Revert local addition in case of failure
                    if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
                        self.tasks.remove(at: index)
                    }
                    completion?(false)
                }
            }
        }
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

    // Save tasks to local storage
    func saveTasks() {
        let encoder = JSONEncoder()
        if let encodedTasks = try? encoder.encode(tasks) {
            UserDefaults.standard.set(encodedTasks, forKey: "tasks")
        }
        if let encodedCompletedTasks = try? encoder.encode(completedTasks) {
            UserDefaults.standard.set(encodedCompletedTasks, forKey: "completedTasks")
        }
    }

    // Load tasks from local storage
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
    
    // Fetch tasks from Supabase and merge with local tasks
    func fetchTasksFromSupabase() {
        networkManager.fetchTasks { fetchedTasks in
            if let fetchedTasks = fetchedTasks {
                DispatchQueue.main.async {
                    // Merge remote tasks with local tasks, avoiding duplicates
                    let localTaskIDs = self.tasks.map { $0.id }
                    let nonDuplicateTasks = fetchedTasks.filter { !localTaskIDs.contains($0.id) }
                    self.tasks.append(contentsOf: nonDuplicateTasks)
                    self.saveTasks() // Save merged tasks to local storage
                }
            }
        }
    }
}
