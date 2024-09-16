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
    @State private var type: String = "Work"
    
    @State private var showAlert = false
    @State private var validationError: TaskError?
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("Add task")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 35)
            TextField("Task Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Task Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Picker("Category", selection: $type) {
                Text("Work").tag("Work")
                Text("Personal").tag("Personal")
                Text("Social").tag("Social")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Button(action: {
                            do {
                                // Validate the input
                                try viewModel.validateTask(title: title, description: description)
                                // If validation is successful, add the task
                                viewModel.addTask(title: title, description: description, type: type)
                                presentationMode.wrappedValue.dismiss()
                            } catch let error as TaskError {
                                // Catch and set the validation error if thrown
                                validationError = error
                                showAlert = true
                            } catch {
                                // Mark unexpected errors
                                validationError = .unknown
                                showAlert = true
                            }
                        }) {
                            Text("Add Task")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Error"),
                                message: Text(validationError?.errorDescription ?? "Unknown error"),
                                dismissButton: .default(Text("OK"))
                            )
                        }
            .padding()
            
            Spacer()
        }
        .background(Color("bgcolor"))
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: TaskViewModel())
    }
}
