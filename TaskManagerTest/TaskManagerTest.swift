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
    
    override func setUp() {
        super.setUp()
        viewModel = TaskViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // Test adding a task
    func testAddTask() {
        viewModel.addTask(title: "Test Task", description: "This is a test", type: "Work")
        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks[0].title, "Test Task")
        XCTAssertEqual(viewModel.tasks[0].description, "This is a test")
        XCTAssertEqual(viewModel.tasks[0].type, "Work")
    }

    // Test marking a task as complete
    func testMarkTaskAsComplete() {
        let task = WorkTask(title: "Work Task", description: "Complete this task")
        viewModel.addTask(title: task.title, description: task.description, type: task.type)
        
        viewModel.markTaskAsComplete(viewModel.tasks[0])
        XCTAssertEqual(viewModel.completedTasks.count, 1)
        XCTAssertEqual(viewModel.tasks.count, 0)
        XCTAssertTrue(viewModel.completedTasks[0].isCompleted)
    }

    // Test removing a task
    func testRemoveTask() {
        viewModel.addTask(title: "Remove Task", description: "Task to be removed", type: "Personal")
        XCTAssertEqual(viewModel.tasks.count, 1)
        
        viewModel.removeTask(viewModel.tasks[0])
        XCTAssertEqual(viewModel.tasks.count, 0)
    }

    // Test error handling for missing title
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

    // Test error handling for missing description
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
    
    // Test screen transition (simulating a transition between AddTaskView and TaskListView)
    func testScreenTransition() {
        let task = WorkTask(title: "Transition Task", description: "Test transition")
        viewModel.addTask(title: task.title, description: task.description, type: task.type)
        
        let taskListView = TaskListView(viewModel: viewModel)
        let taskDetailView = TaskDetailView(task: task, viewModel: viewModel)
        
        // Simulate navigation
        XCTAssertNotNil(taskListView.body)
        XCTAssertNotNil(taskDetailView.body)
    }
    
    // Test adding multiple tasks
    func testAddMultipleTasks() {
        viewModel.addTask(title: "First Task", description: "First Description", type: "Work")
        viewModel.addTask(title: "Second Task", description: "Second Description", type: "Social")
        
        XCTAssertEqual(viewModel.tasks.count, 2)
        XCTAssertEqual(viewModel.tasks[0].title, "First Task")
        XCTAssertEqual(viewModel.tasks[1].title, "Second Task")
    }
}

