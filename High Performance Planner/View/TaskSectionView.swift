//
//  TaskSectionView.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/14/24.
//

import SwiftUI

enum TodoCategory: String, CaseIterable, Identifiable {
    case work, relations, physical, emotional
    
    var id: Self { self }
    
    // Assign colors to each category
    var color: Color {
        switch self {
        case .work:
            return .blue
        case .relations:
            return .green
        case .physical:
            return .orange
        case .emotional:
            return .purple
        }
    }
}

struct Task: Identifiable, Equatable {
    let id: UUID = UUID()
    var description: String
    var isStarred: Bool = false
    var category: TodoCategory = .work
}

struct CategoryDot: View {
    @Binding var category: TodoCategory
    
    var body: some View {
        Menu {
            ForEach(TodoCategory.allCases) { cat in
                Button(action: {
                    category = cat
                }) {
                    HStack {
                        Circle()
                            .fill(cat.color)
                        Text(cat.rawValue.capitalized)
                    }
                    
                }
            }
        } label: {
            Circle()
                .fill(category.color)
                .frame(width: 16, height: 16)
                .padding(.trailing, 8)
        }
        .menuStyle(BorderlessButtonMenuStyle())
        .accessibilityLabel("Select Task Category")
        .accessibilityHint("Double tap to open category selection menu")
    }
}

struct TaskSectionView: View {
    var header: String
    @Binding var completedTasks: [Task]
    @Binding var tasks: [Task]
    @State private var newTaskDescription: String = ""
    @FocusState private var isNewTaskFieldFocused: Bool
    
    var body: some View {
        Section(header: Text(header)) {
            List {
                ForEach($completedTasks) { $task in
                    HStack {
                        CategoryDot(category: $task.category)
                        
                        TextField("Task description", text: binding(for: task))
                            .disabled(true)
                    }
                    .strikethrough()
                    .foregroundStyle(.secondary)
                }
                // Editable TextField for new tasks
                ForEach($tasks) { $task in
                    HStack {
                        // Category Dot
                        CategoryDot(category: $task.category)
                        
                        TextField("Task description", text: binding(for: task))
                        Spacer()
                    }
                    .swipeActions(edge: .leading) {
                        // Star action
                        Button {
                            completeTask(task)
                        } label: {
                            Label("Complete", systemImage: "checkmark")
                        }.tint(.green)
                    }
                    .swipeActions {
                        // Delete aciton
                        Button(role: .destructive) {
                            deleteTask(task)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                
                HStack {
                    TextField("New Task", text: $newTaskDescription)
                        .onSubmit {
                            addNewTask()
                        }
                        .focused($isNewTaskFieldFocused)
                }
            }
        }
    }
        
    func addNewTask() {
        let trimmedDescription = newTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedDescription.isEmpty else { return }
        
        tasks.append(Task(description: trimmedDescription))
            
        // Reset the description after a slight delay to prevent focus issues
        DispatchQueue.main.async {
            self.newTaskDescription = ""
        }
    }
    
    func deleteTask(_ task: Task) {
        tasks.removeAll(where: { $0.id == task.id })
    }
    
    func completeTask(_ task: Task) {
        // Move task to completed tasks
        let index = tasks.firstIndex(of: task)!
        let completedTask = tasks.remove(at: index)
        completedTasks.append(completedTask)
    }
    
    func binding(for task: Task) -> Binding<String> {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            return $tasks[index].description
        } else if let index = completedTasks.firstIndex(where: { $0.id == task.id }) {
            return $completedTasks[index].description
        } else {
            return .constant("")
        }
    }
}
