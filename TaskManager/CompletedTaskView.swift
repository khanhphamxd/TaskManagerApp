//
//  CompletedTaskView.swift
//  TaskManager
//
//  Created by Khanh Pham on 14/9/2024.
//

import SwiftUI

struct CompletedTasksView: View {
    @ObservedObject var viewModel: TaskViewModel

    var body: some View {
        List {
            ForEach(viewModel.getCompletedTasks()) { task in
                Text(task.title)
            }
        }
        .navigationTitle("Completed Tasks")
    }
}

struct CompletedTasksView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedTasksView(viewModel: TaskViewModel())
    }
}


