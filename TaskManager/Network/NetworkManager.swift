//
//  NetworkManager.swift
//  TaskManager
//
//  Created by Khanh Pham on 13/10/2024.
//

import Foundation

class NetworkManager {
    private var supabaseURL: String
    private var supabaseKey: String
    private var shouldSimulateError = false // Flag to simulate network errors

    // Initialize with URL and Key
    init(url: String, key: String) {
        self.supabaseURL = url
        self.supabaseKey = key
    }

    // Function to toggle error simulation
    func simulateError() {
        shouldSimulateError = true
    }

    // Fetch tasks from Supabase
    func fetchTasks(completion: @escaping ([TaskWrapper]?) -> Void) {
        // If error simulation is enabled, immediately return nil
        if shouldSimulateError {
            completion(nil)
            return
        }

        guard let url = URL(string: "\(supabaseURL)/rest/v1/tasks") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(supabaseKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let fetchedTasks = try decoder.decode([TaskWrapper].self, from: data)
                completion(fetchedTasks)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }

    // Add a new task to Supabase
    func addTask(_ task: TaskWrapper, completion: @escaping (Bool) -> Void) {
        // If error simulation is enabled, immediately return failure
        if shouldSimulateError {
            completion(false)
            return
        }

        guard let url = URL(string: "\(supabaseURL)/rest/v1/tasks") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(supabaseKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(task)
            request.httpBody = jsonData
        } catch {
            completion(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
}

