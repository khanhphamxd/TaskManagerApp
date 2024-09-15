//
//  TaskListView.swift
//  TaskManager
//
//  Created by Khanh Pham on 14/9/2024.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel: TaskViewModel

    var body: some View {
        List {
            ForEach(viewModel.getAllTasks(), id: \.id) { task in
                NavigationLink(destination: TaskDetailView(task: task, viewModel: viewModel)) {
                    Text(task.title)
                        .frame(width:300, height:30)
                }
            }
        }
        .frame(width: 300, height: 600)
        .border(Color.teal, width: 5)
        .background(Color.white)
    }
}

