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
                    .background(colorForCategory(task.type))
                }
            }
        }
        .frame(width: 300, height: 600)
        .border(Color.teal, width: 5)
        .background(Color("bglcolor"))
    }
    
    private func colorForCategory(_ category: String) -> Color {
        switch category {
        case "Work":
            return Color.gray.opacity(0.3) 
        case "Personal":
            return Color.green.opacity(0.2)
        case "Social":
            return Color.red.opacity(0.2)
        default:
            return Color.clear
        }
    }
}

