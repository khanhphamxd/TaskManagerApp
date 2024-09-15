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
                HStack {
                    NavigationLink("Add New Task", destination: AddTaskView(viewModel: viewModel))
                        .frame(height: 30)
                        .padding(5)
                        .background(Color.cyan)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .border(Color.blue, width: 2)
                        .foregroundColor(.white)
                    NavigationLink("Completed Tasks", destination: CompletedTasksView(viewModel: viewModel))
                        .frame(height: 30)
                        .padding(5)
                        .background(Color.cyan)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .border(Color.blue, width: 2)
                        .foregroundColor(.white)
                }
            }
            .navigationTitle("TaskManager")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


