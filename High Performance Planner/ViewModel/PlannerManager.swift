//
//  PlannerManager.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/19/24.
//

import Foundation
import Combine
import SwiftUI

class PlannerManager: ObservableObject {
    @Published var planner: EditablePlanner?
    @Published var onMyMindTasks: [EditableTask<OnMyMindTask>] = []
    private let dataService: any DataService
    
    init(dataService: any DataService) {
        self.dataService = dataService
    }
    
    // MARK: - Planner Management
    func loadPlanner(for date: Date) {
        guard planner == nil || planner?.date.startOfDay() != date.startOfDay() else { return }
        if let planner = dataService.loadPlanner(for: date) {
            self.planner = EditablePlanner(planner: planner)
        } else {
            self.planner = EditablePlanner(
                planner: .init(
                    date: date,
                    reflectionQuestions: dataService.loadDefaultReflectionQuestions(),
                    taskCategories: dataService.loadDefaultTaskCategories(),
                    tasks: [],
                    reviewQuestions: dataService.loadDefaultReviewQuestions()
                )
            )
        }
    }
    
    func savePlanner() {
        guard let planner else { return }
        let plannerStruct = planner.toDailyPlanner()
        dataService.savePlanner(plannerStruct, for: planner.date)
    }
    
    // MARK: - OnMyMind Tasks Management
    func loadOnMyMindTasks() {
        onMyMindTasks = []
        dataService.loadOnMyMindTasks().forEach { onMyMindTasks.append(EditableTask(task: $0)) }
    }
    
    func saveOnMyMindTasks() {
        dataService.saveOnMyMindTasks(onMyMindTasks.map { $0.task })
    }
    
    func updateOnMyMindTask(_ task: OnMyMindTask) {
        if let index = onMyMindTasks.firstIndex(where: { $0.task.id == task.id }) {
            onMyMindTasks[index].task = task
            saveOnMyMindTasks()
        }
    }
    
    func removeOnMyMindTask(_ task: OnMyMindTask) {
        onMyMindTasks.removeAll { $0.task.id == task.id }
        saveOnMyMindTasks()
    }
    
    func completeOnMyMindTask(_ task: OnMyMindTask) {
        if let index = onMyMindTasks.firstIndex(where: { $0.task.id == task.id }) {
            onMyMindTasks[index].toggleCompletion()
            saveOnMyMindTasks()
        }
    }
    
    // MARK: - Daily Task Management
    func addDailyTask(_ task: any Task, category: TaskCategory) {
        guard let planner else { return }
        let dueDate = planner.date
        planner.tasks.append(EditableTask(task: DailyTask(from: task, dueDate: dueDate, category: category)))
    }
    
    func updateDailyTask(_ task: DailyTask) {
        guard let planner else { return }
        if let index = planner.tasks.firstIndex(where: { $0.task.id == task.id }) {
            planner.tasks[index] = EditableTask(task: task)
        }
    }
    
    func removeDailyTask(_ task: DailyTask) {
        guard let planner else { return }
        if let index = planner.tasks.firstIndex(where: { $0.task.id == task.id }) {
            planner.tasks.remove(at: index)
        }
    }
    
    func completeDailyTask(_ task: DailyTask) {
        guard let planner else { return }
        if let index = planner.tasks.firstIndex(where: { $0.task.id == task.id }) {
            planner.tasks[index].toggleCompletion()
        }
    }
}

extension PlannerManager {
    func binding<T>(for keyPath: ReferenceWritableKeyPath<EditablePlanner, [T]>) -> Binding<[T]> {
        Binding(
            get: { self.planner?[keyPath: keyPath] ?? [] },
            set: {
                self.planner?[keyPath: keyPath] = $0
                self.savePlanner()
            }
        )
    }
}
