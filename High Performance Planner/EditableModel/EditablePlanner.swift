//
//  EditablePlanner.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/21/24.
//

import Foundation

class EditablePlanner: ObservableObject, Identifiable {
    private(set) var date: Date
    @Published var reflectionQuestions: [EditableQuestion<ReflectionQuestion>]
    @Published var taskCategories: [EditableTaskCategory]
    @Published var tasks: [EditableTask<DailyTask>]
    @Published var reviewQuestions: [EditableQuestion<ReviewQuestion>]
    
    init(planner: DailyPlanner) {
        self.date = planner.date
        self.reflectionQuestions = planner.reflectionQuestions.map { EditableQuestion<ReflectionQuestion>(question: $0) }
        self.taskCategories = planner.taskCategories.map { EditableTaskCategory(category: $0) }
        self.tasks = planner.tasks.map { EditableTask<DailyTask>(task: $0) }
        self.reviewQuestions = planner.reviewQuestions.map { EditableQuestion<ReviewQuestion>(question: $0) }
    }
    
    // Convert Back to DailyPlanner struct for data services
    func toDailyPlanner() -> DailyPlanner {
        DailyPlanner(date: date,
                     reflectionQuestions: reflectionQuestions.map { $0.question },
                     taskCategories: taskCategories.map { $0.category },
                     tasks: tasks.map { $0.task },
                     reviewQuestions: reviewQuestions.map { $0.question }
        )
    }
    
    func dateForViews() -> String {
        Constants.dateFormatterForViews.string(from: date)
    }
}
