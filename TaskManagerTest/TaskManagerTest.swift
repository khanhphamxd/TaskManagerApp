//
//  TaskManagerTest.swift
//  TaskManagerTest
//
//  Created by Khanh Pham on 16/9/2024.
//

import XCTest
@testable import TaskManager
import SwiftUI

final class TaskManagerTest: XCTestCase {
    var viewModel: TaskViewModel!
    let userDefaults = UserDefaults.standard
    var networkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        viewModel = TaskViewModel()

        userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        userDefaults.synchronize()
    }

    override func tearDown() {
        viewModel = nil
        networkManager = nil
        super.tearDown()
    }

    // Test adding a task
    func testAddTask() {
        let initialTaskCount = viewModel.tasks.count

        // Add a new task
        viewModel.addTask(title: "Test Task", description: "This is a test", type: "Work")

        // Verify task count increased
        XCTAssertEqual(viewModel.tasks.count, initialTaskCount + 1)

        // Verify the last task added is the one we expect
        let lastTask = viewModel.tasks.last
        XCTAssertEqual(lastTask?.title, "Test Task")
        XCTAssertEqual(lastTask?.description, "This is a test")
        XCTAssertEqual(lastTask?.type, "Work")
    }

    // Test saving a task to UserDefaults
    func testSaveTaskToUserDefaults() {
        let task = WorkTask(title: "Saved Task", description: "Should be saved")
        viewModel.addTask(title: task.title, description: task.description, type: "Work")
        viewModel.saveTasks()

        if let savedTasksData = userDefaults.data(forKey: "tasks"),
           let savedTasks = try? JSONDecoder().decode([TaskWrapper].self, from: savedTasksData) {
            XCTAssertEqual(savedTasks.count, viewModel.tasks.count)
            XCTAssertEqual(savedTasks.last?.title, task.title)
            XCTAssertEqual(savedTasks.last?.description, task.description)
        } else {
            XCTFail("No tasks found in UserDefaults.")
        }
    }

    // Retrieve tasks from UserDefaults and verify task count
    func testRetrieveTasksFromUserDefaults() {
        let taskData: [TaskWrapper] = [
            .work(WorkTask(title: "Retrieved Task", description: "Should be retrieved")),
            .personal(PersonalTask(title: "Personal Task", description: "Personal description"))
        ]
        
        let encoder = JSONEncoder()
        if let encodedTasks = try? encoder.encode(taskData) {
            UserDefaults.standard.set(encodedTasks, forKey: "tasks")
        }

        viewModel.loadTasks()

        XCTAssertEqual(viewModel.tasks.count, taskData.count)
        XCTAssertEqual(viewModel.tasks[0].title, "Retrieved Task")
        XCTAssertEqual(viewModel.tasks[1].title, "Personal Task")
    }

    // Test removing a task and verifying the task count
    func testRemoveTask() {
        viewModel.addTask(title: "Task to Remove", description: "Will be removed", type: "Work")
        let initialTaskCount = viewModel.tasks.count

        // Remove the task
        viewModel.removeTask(viewModel.tasks.last!)

        // Verify task count decreased
        XCTAssertEqual(viewModel.tasks.count, initialTaskCount - 1)
    }

    // Test removing tasks from UserDefaults
    func testRemoveTaskFromUserDefaults() {
        let task = WorkTask(title: "Remove from UserDefaults", description: "To be removed")
        viewModel.addTask(title: task.title, description: task.description, type: "Work")
        viewModel.saveTasks()
        viewModel.removeTask(viewModel.tasks.last!)
        viewModel.saveTasks()

        if let savedTasksData = userDefaults.data(forKey: "tasks"),
           let savedTasks = try? JSONDecoder().decode([TaskWrapper].self, from: savedTasksData) {
            XCTAssertEqual(savedTasks.count, 0)
        } else {
            XCTFail("No tasks found in UserDefaults after removal.")
        }
    }

    // Test handling missing title error when adding a task
    func testMissingTitleError() {
        do {
            try viewModel.validateTask(title: "", description: "Description")
            XCTFail("Expected TaskError.missingTitle but no error was thrown.")
        } catch let error as TaskError {
            XCTAssertEqual(error, .missingTitle)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // Test handling missing description error when adding a task
    func testMissingDescriptionError() {
        do {
            try viewModel.validateTask(title: "Title", description: "")
            XCTFail("Expected TaskError.missingDescription but no error was thrown.")
        } catch let error as TaskError {
            XCTAssertEqual(error, .missingDescription)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // Test screen transition logic by simulating a transition between views
    func testScreenTransition() {
        let task = WorkTask(title: "Transition Task", description: "Test transition", type: "Work")
        viewModel.addTask(title: task.title, description: task.description, type: task.type)

        // Simulate screen views
        let taskListView = TaskListView(viewModel: viewModel)
        let taskDetailView = TaskDetailView(task: task, viewModel: viewModel)

        // Verify views were instantiated properly
        XCTAssertNotNil(taskListView.body)
        XCTAssertNotNil(taskDetailView.body)
    }

    // Test adding multiple tasks and verifying their presence
    func testAddMultipleTasks() {
        let initialTaskCount = viewModel.tasks.count

        // Add two tasks
        viewModel.addTask(title: "First Task", description: "First Description", type: "Work")
        viewModel.addTask(title: "Second Task", description: "Second Description", type: "Social")

        // Verify task count increased by 2
        XCTAssertEqual(viewModel.tasks.count, initialTaskCount + 2)

        // Verify content of the last task added
        let lastTask = viewModel.tasks.last
        XCTAssertEqual(lastTask?.title, "Second Task")
        XCTAssertEqual(lastTask?.description, "Second Description")
    }

    // MARK: - Supabase Integration Tests

    // Test adding a task to Supabase
    func testAddTaskToSupabase() {
        let taskTitle = "Supabase Task"
        let taskDescription = "Task to be added to Supabase"
        
        let expectation = XCTestExpectation(description: "Add task to Supabase")
        
        viewModel.addTask(title: taskTitle, description: taskDescription, type: "Work")

        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.viewModel.fetchTasksFromSupabase()
            
            XCTAssertEqual(self.viewModel.tasks.last?.title, taskTitle)
            XCTAssertEqual(self.viewModel.tasks.last?.description, taskDescription)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    // Test fetching tasks from Supabase
    func testFetchTasksFromSupabase() {
        let expectation = XCTestExpectation(description: "Fetch tasks from Supabase")
        
        viewModel.fetchTasksFromSupabase()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            // Wait for tasks to be fetched (active after 2s)
            XCTAssertFalse(self.viewModel.tasks.isEmpty, "Expected tasks to be fetched from Supabase but got an empty array.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

}
