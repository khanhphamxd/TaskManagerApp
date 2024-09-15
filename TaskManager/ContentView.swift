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
                Text("Task Manager")
                    .font(.largeTitle)
                    .padding()

                List {
                    ForEach(viewModel.getAllTasks(), id: \.id) { task in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .font(.headline)
                                Text(task.description)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text(task.category)
                                .font(.caption)
                                .foregroundColor(.gray)
                            Button(action: {
                                viewModel.markTaskAsComplete(task)
                            }) {
                                Text("Complete")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }

                NavigationLink(destination: CompletedTasksView(viewModel: viewModel)) {
                    Text("View Completed Tasks")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                NavigationLink(destination: AddTaskView(viewModel: viewModel)) {
                    Text("Add New Task")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Tasks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

