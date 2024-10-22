////
////  TaskSectionView.swift
////  High Performance Planner
////
////  Created by William Pendleton on 10/14/24.
////
//
//import SwiftUI
//
//struct TaskSectionView: View {
//    var header: String
//    @State var tasks: [TaskModel]
//    @State private var newTaskDescription: String = ""
//    @FocusState private var isNewTaskFieldFocused: Bool
//    @State private var isEditing = true
//    
//    
//    var body: some View {
//        Section(header: Text(header)) {
//            List {
//                ForEach(tasks) { task in
//                    HStack {
//                        // Category Dot
//                        CategoryDot(category: task.category)
//                        
//                        TextField("Task description", text: binding(for: task))
//                        Spacer()
//                    }
//                    .swipeActions(edge: .leading) {
//                        // Star action
//                        Button {
//                            toggleCompleteTask(task)
//                        } label: {
//                            Label("Complete", systemImage: "checkmark")
//                        }.tint(.green)
//                    }
//                    .swipeActions {
//                        // Delete aciton
//                        Button(role: .destructive) {
//                            deleteTask(task)
//                        } label: {
//                            Label("Delete", systemImage: "trash")
//                        }
//                    }
//                }
//                
//                if isEditing {
//                    HStack {
//                        TextField("New Task", text: $newTaskDescription)
//                            .onSubmit {
//                                addNewTask()
//                            }
//                            .focused($isNewTaskFieldFocused)
//                    }
//                }
//            }
//        }
//    }
//    
//    func addNewTask() {
//        let trimmedDescription = newTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
//        guard !trimmedDescription.isEmpty else { return }
//        
//        let newTask = TaskModel(description: trimmedDescription)
//        tasks.append(newTask)
//        
//        // Reset the description after a slight delay to prevent focus issues
//        DispatchQueue.main.async {
//            self.newTaskDescription = ""
//        }
//    }
//    
//    func deleteTask(_ task: TaskModel) {
//        tasks.removeAll(where: { $0.id == task.id })
//    }
//    
//    func toggleCompleteTask(_ task: TaskModel) {
//        if let index = tasks.firstIndex(of: task) {
//            tasks[index].isCompleted.toggle()
//        }
//    }
//    
//    func binding(for task: TaskModel) -> Binding<String> {
//        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
//            return .constant("")
//        }
//        return $tasks[index].description
//    }
//}
