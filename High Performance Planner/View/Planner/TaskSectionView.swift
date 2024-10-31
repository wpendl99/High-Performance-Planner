//
//  TaskSectionView.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/14/24.
//

import SwiftUI

struct TaskSectionView: View {
    private var header: String
    @Binding private var tasks: [DailyTask]
    var categories: [TaskCategory]
    var updateTaskCategory: (DailyTask, TaskCategory) -> Void
    
    @State private var newTaskDescription: String = ""
    @FocusState private var isNewTaskFieldFocused: Bool
    @State private var isEditing = true
    @State private var lastCategory: TaskCategory = TaskCategory(name: "Default", colorHex: "#aaaaaa")
    
    init(header: String, tasks: Binding<[DailyTask]>, categories: [TaskCategory], updateTaskCategory: @escaping (DailyTask, TaskCategory) -> Void) {
        self.header = header
        self._tasks = tasks
        self.categories = categories
        self.updateTaskCategory = updateTaskCategory
    }
    
    var body: some View {
        Section(header: Text(header)) {
            List {
                ForEach(tasks.indices, id: \.self) { index in
                    HStack {
                        CategoryDot(task: $tasks[index], lastCategory: $lastCategory, categories: categories, updateTaskCategory: updateTaskCategory)
                        
                        TextField("Task description", text: $tasks[index].description)
                            .strikethrough(tasks[index].isCompleted, color: .black)
                        Spacer()
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            toggleCompleteTask(at: index)
                        } label: {
                            Label(tasks[index].isCompleted ? "Uncomplete" : "Complete", systemImage: tasks[index].isCompleted ? "xmark" : "checkmark")
                        }
                        .tint(tasks[index].isCompleted ? .orange : .green)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteTask(at: index)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                
                if isEditing {
                    HStack {
                        TextField("New Task", text: $newTaskDescription)
                            .onSubmit {
                                addNewTask()
                            }
                            .focused($isNewTaskFieldFocused)
                    }
                }
            }
            .environment(\.editMode, Binding.constant(EditMode.active))
        }
        .onAppear {
            loadLastCategory()
        }
    }
    
    private func addNewTask() {
        let trimmedDescription = newTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedDescription.isEmpty else { return }
        
        let newTask = DailyTask(trimmedDescription, category: lastCategory)
        tasks.append(newTask) // Directly modify tasks binding
        
        // Reset the description after a slight delay to prevent focus issues
        DispatchQueue.main.async {
            self.newTaskDescription = ""
        }
    }
    
    private func deleteTask(at index: Int) {
        tasks.remove(at: index) // Directly modify tasks binding
    }
    
    private func toggleCompleteTask(at index: Int) {
        tasks[index].isCompleted.toggle() // Toggle completion directly in tasks binding
    }
    
    private func loadLastCategory() {
        // Here, you could set `lastCategory` based on some external configuration or use a default.
        // Example default:
        self.lastCategory = TaskCategory(name: "Default", colorHex: "#aaaaaa")
    }
}
