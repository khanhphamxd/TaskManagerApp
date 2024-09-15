//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Khanh Pham on 12/9/2024.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TaskViewModel
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var category: String = "Work"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("Task Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Task Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Picker("Category", selection: $category) {
                Text("Work").tag("Work")
                Text("Personal").tag("Personal")
                Text("Social").tag("Social")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Button(action: {
                viewModel.addTask(title: title, description: description, category: category)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Add Task")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Add Task")
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: TaskViewModel())
    }
}
