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
                Text(task.title)
            }
        }
        .border(Color.blue, width: 5)
        .background(Color.white)
    }
}

