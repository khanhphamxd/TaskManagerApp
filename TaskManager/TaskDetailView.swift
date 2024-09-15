//
//  TaskDetailView.swift
//  TaskManager
//
//  Created by Khanh Pham on 15/9/2024.
//

import SwiftUI

struct TaskDetailView: View {
    let task: any TaskDetail
    @ObservedObject var viewModel: TaskViewModel

    var body: some View {
        ZStack {
            Color("bgcolor").ignoresSafeArea()
            VStack(alignment: .center) {
                Spacer()
                Text("Current task")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                VStack {
                    Text("\(task.title)")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(" \(task.description)")
                        .font(.title2)
                        .padding(.top, 4)
                    Text("Type: \(task.type)")
                        .font(.title2)
                        .padding(.top, 4)
                    Text("Completed: \(task.isCompleted ? "Yes" : "No")")
                        .font(.title2)
                        .padding(.top, 4)
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width:300)
                .padding(10)
                .border(Color.blue, width: 5)
                .background(Color.orange)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.markTaskAsComplete(task)
                    }) {
                        Text("Mark as Complete")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.bottom, 20)
                    Spacer()
                    Button(action: {
                        viewModel.removeTask(task)
                    }) {
                        Text("Remove")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.bottom, 20)
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("Task Details")
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: WorkTask(title: "Sample Task", description: "Sample Description"), viewModel: TaskViewModel())
    }
}

