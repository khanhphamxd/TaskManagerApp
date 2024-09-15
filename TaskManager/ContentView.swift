//
//  ContentView.swift
//  TaskManager
//
//  Created by Khanh Pham on 12/9/2024.
//
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TaskViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TaskListView(viewModel: viewModel)
                NavigationLink("Add New Task", destination: AddTaskView(viewModel: viewModel))
                NavigationLink("Completed Tasks", destination: CompletedTasksView(viewModel: viewModel))
            }
            .navigationTitle("Task Manager")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


