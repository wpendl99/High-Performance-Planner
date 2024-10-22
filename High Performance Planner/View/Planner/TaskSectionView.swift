//
//  TaskSectionView.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/14/24.
//

import SwiftUI

struct TaskSectionView: View {
    private var header: String
    @ObservedObject var plannerManager: PlannerManager
    private var tasks: Binding<[EditableTask<DailyTask>]>
    
    @State private var newTaskDescription: String = ""
    @FocusState private var isNewTaskFieldFocused: Bool
    @State private var isEditing = true
    @State private var lastCategory: TaskCategory
    
    init(header: String, plannerManager: PlannerManager, tasks: Binding<[EditableTask<DailyTask>]>) {
        self.header = header
        self.plannerManager = plannerManager
        self.tasks = tasks
        self.lastCategory = plannerManager.getFirstTaskCategory()
    }
    
    
    var body: some View {
        Section(header: Text(header)) {
            List {
                ForEach(tasks) { $task in
                    HStack {
                        CategoryDot(plannerManager: plannerManager, task: $task.task, lastCategory: $lastCategory)
                        
                        TextField("Task description", text: $task.task.description)
                            .strikethrough(task.task.isCompleted, color: .black)
                        Spacer()
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            toggleCompleteTask(task)
                        } label: {
                            Label(task.task.isCompleted ? "Uncomplete" : "Complete", systemImage: task.task.isCompleted ? "xmark" : "checkmark")
                        }
                        .tint(task.task.isCompleted ? .orange : .green)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteTask(task)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                .onMove { indices, newOffset in
                    plannerManager.moveTasks(from: indices, to: newOffset)
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
    }
    
    func addNewTask() {
        let trimmedDescription = newTaskDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedDescription.isEmpty else { return }
        
        let newTask = DailyTask(trimmedDescription, category: lastCategory)
        plannerManager.addDailyTask(newTask, category: lastCategory)
        
        // Reset the description after a slight delay to prevent focus issues
        DispatchQueue.main.async {
            self.newTaskDescription = ""
        }
    }
    
    func deleteTask(_ task: EditableTask<DailyTask>) {
        plannerManager.removeDailyTask(task.task)
    }
    
    func toggleCompleteTask(_ task: EditableTask<DailyTask>) {
        plannerManager.toggleTaskCompletion(task.task)
    }
}
