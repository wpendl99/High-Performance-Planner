//
//  OnMyMindTaskSectionView.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/23/24.
//

import SwiftUI

struct OnMyMindTaskSectionView: View {
    private var header: String
    @Binding private var tasks: [OnMyMindTask]
    
    @State private var newTaskDescription: String = ""
    @FocusState private var isNewTaskFieldFocused: Bool
    @State private var isEditing: Bool
    
    var addTask: (OnMyMindTask) -> Void
    var deleteTask: (OnMyMindTask) -> Void
    var toggleTaskCompletion: (OnMyMindTask) -> Void
    var moveTasks: (IndexSet, Int) -> Void
    
    init(header: String, tasks: Binding<[OnMyMindTask]>, isEditing: Bool = true,
         addTask: @escaping (OnMyMindTask) -> Void,
         deleteTask: @escaping (OnMyMindTask) -> Void,
         toggleTaskCompletion: @escaping (OnMyMindTask) -> Void,
         moveTasks: @escaping (IndexSet, Int) -> Void) {
        self.header = header
        self._tasks = tasks
        self.isEditing = isEditing
        self.addTask = addTask
        self.deleteTask = deleteTask
        self.toggleTaskCompletion = toggleTaskCompletion
        self.moveTasks = moveTasks
    }
    
    var body: some View {
        Section(header: Text(header)) {
            List {
                ForEach(tasks.indices, id: \.self) { index in
                    HStack {
                        TextField("Task description", text: $tasks[index].description)
                            .strikethrough(tasks[index].isCompleted, color: .black)
                        Spacer()
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            toggleTaskCompletion(tasks[index])
                        } label: {
                            Label(tasks[index].isCompleted ? "Uncomplete" : "Complete", systemImage: tasks[index].isCompleted ? "xmark" : "checkmark")
                        }
                        .tint(tasks[index].isCompleted ? .orange : .green)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteTask(tasks[index])
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                .onMove(perform: moveTasks)
                
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
    }
    
    private func addNewTask() {
        let trimmedDescription = newTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedDescription.isEmpty else { return }
        
        let newTask = OnMyMindTask(trimmedDescription)
        addTask(newTask)
        
        // Reset the description after a slight delay to prevent focus issues
        DispatchQueue.main.async {
            self.newTaskDescription = ""
        }
    }
}
