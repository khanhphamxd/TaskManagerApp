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
        VStack {
            Text("Completed Tasks")
                .font(.largeTitle)
                .padding()

            List {
                ForEach(viewModel.getCompletedTasks(), id: \.id) { task in
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
                    }
                }
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

