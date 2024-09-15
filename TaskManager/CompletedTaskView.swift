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
        NavigationView {
            ZStack {
                Color("bgcolor")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Completed tasks")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                    List {
                        ForEach(viewModel.getCompletedTasks(), id: \.id) { task in
                            NavigationLink(destination: TaskDetailView(task: task, viewModel: viewModel)) {
                                Text(task.title)
                                    .frame(width:300, height:30)
                            }
                        }
                    }
                    .frame(width: 300, height: 700)
                }
            }
        }
    }
}

struct CompletedTasksView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedTasksView(viewModel: TaskViewModel())
    }
}


