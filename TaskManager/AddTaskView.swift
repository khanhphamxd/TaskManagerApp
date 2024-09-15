//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Khanh Pham on 12/9/2024.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var viewModel: TaskViewModel

    @State private var taskTitle = ""
    @State private var taskDescription = ""
    @State private var taskType = ""

    var body: some View {
        Form {
            Section(header: Text("New Task")) {
                TextField("Title", text: $taskTitle)
                TextField("Description", text: $taskDescription)
                TextField("Type (Work, Personal, Social)", text: $taskType)
                
                Button("Add Task") {
                    viewModel.addTask(title: taskTitle, description: taskDescription, type: taskType)
                }
            }
        }
        .navigationTitle("Add Task")
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: TaskViewModel())
    }
}

