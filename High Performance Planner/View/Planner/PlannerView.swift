//
//  PlannerView.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/11/24.
//

import SwiftUI

enum ViewMode {
    case mini
    case full
    case history
}

struct PlannerView: View {
    @StateObject private var viewModel: PlannerViewModel
    var date: Date
    var viewMode: ViewMode
    
    var isEditing = true
    
    init(date: Date, viewMode: ViewMode, isEditing: Bool = true) {
        self.date = date
        _viewModel = StateObject(wrappedValue: PlannerViewModel(date: date, viewMode: viewMode))
        self.viewMode = viewMode
        self.isEditing = isEditing
    }

    var body: some View {
        NavigationView {
            Form {
                reflectionSection
                todoSection
                if viewModel.viewMode == .full {
                    reviewSection
                }
                reminderSection
            }
            .navigationTitle("\(DateFormatter.dateForTitles(from: viewModel.planner.date))")
        }
        .onTapGesture {
            UIApplication.shared.endEditing(true)
        }
    }

    var reflectionSection: some View {
        ReflectionSectionView(
            header: Constants.reflectionHeader,
            questions: viewModel.reflectionQuestionsBinding
        )
    }

    var todoSection: some View {
        TaskSectionView(
            header: "Today's Todos",
            tasks: viewModel.tasksBinding,
            categories: viewModel.allTaskCategories,
            updateTaskCategory: viewModel.updateTaskTaskCategory
        )
    }

    var reviewSection: some View {
        Section(header: Text("Daily Review")) {
            Text("Third name:")
        }
    }

    var reminderSection: some View {
        let filteredTasks = viewModel.filteredOnMyMindTasks()
        return OnMyMindTaskSectionView(
            header: "Things to keep on mind",
            tasks: filteredTasks,
            isEditing: isEditing,
            addTask: viewModel.addOnMyMindTask,
            deleteTask: viewModel.removeOnMyMindTask,
            toggleTaskCompletion: viewModel.toggleOnMyMindTaskCompletion,
            moveTasks: viewModel.moveOnMyMindTasks
        )
    }
}

#Preview {
    PlannerView(date: .now, viewMode: .full)
}

