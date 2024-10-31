//
//  PlannerViewModel.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/28/24.
//

import Foundation
import SwiftUI
import Combine

class PlannerViewModel: ObservableObject {
    @Published var planner: DailyPlanner
    @Published var onMyMindTasks: [OnMyMindTask] = []            // Real-time value
    @Published private(set) var debouncedOnMyMindTasks: [OnMyMindTask] = [] // Debounced value
    
    private var saveCancellable = Set<AnyCancellable>()
    private let date: Date
    var viewMode: ViewMode
    
    init(date: Date, viewMode: ViewMode) {
        self.date = date
        self.viewMode = viewMode
        if let loadedPlanner = PersistenceManager.shared.loadPlanner(for: date) {
            self.planner = loadedPlanner
        } else {
            // Load default planner if none exists for the date
            self.planner = DailyPlanner(
                date: date,
                reflectionQuestions: PersistenceManager.shared.loadDefaultReflectionQuestions(),
                taskCategories: PersistenceManager.shared.loadDefaultTaskCategories(),
                tasks: [],
                reviewQuestions: PersistenceManager.shared.loadDefaultReviewQuestions()
            )
        }
        loadOnMyMindTasks()
        setupDebouncedSave()
        setupDebouncedOnMyMindTasks()
    }
    
    // Debounced Save Setup for planner
    private func setupDebouncedSave() {
        $planner
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.savePlanner()
            }
            .store(in: &saveCancellable)
    }
    
    // Debounced Setup for onMyMindTasks
    private func setupDebouncedOnMyMindTasks() {
        $onMyMindTasks
            .debounce(for: .seconds(0.75), scheduler: DispatchQueue.main)
            .sink { [weak self] debouncedTasks in
                self?.debouncedOnMyMindTasks = debouncedTasks
            }
            .store(in: &saveCancellable)
        
        // Trigger save when debouncedOnMyMindTasks changes
        $debouncedOnMyMindTasks
            .dropFirst() // To prevent initial empty save
            .sink { [weak self] _ in
                self?.saveOnMyMindTasks()
            }
            .store(in: &saveCancellable)
    }
    
    func savePlanner() {
        PersistenceManager.shared.savePlanner(planner, for: date)
    }
    
    func loadOnMyMindTasks() {
        self.onMyMindTasks = PersistenceManager.shared.loadOnMyMindTasks()
    }
    
    func saveOnMyMindTasks() {
        PersistenceManager.shared.saveOnMyMindTasks(onMyMindTasks)
    }
    
    func filteredOnMyMindTasks() -> Binding<[OnMyMindTask]> {
        let calendar = Calendar.current
        let filteredTasks = onMyMindTasks.filter { task in
            switch viewMode {
            case .full, .mini:
                return !task.isCompleted || (task.completionDate != nil && calendar.isDate(task.completionDate!, inSameDayAs: date))
            case .history:
                return task.isCompleted && (task.completionDate != nil && calendar.isDate(task.completionDate!, inSameDayAs: date))
            }
        }
        
        // Create a binding to the filtered tasks array
        return Binding(
            get: { filteredTasks },
            set: { newTasks in
                for newTask in newTasks {
                    if let index = self.onMyMindTasks.firstIndex(where: { $0.id == newTask.id }) {
                        self.onMyMindTasks[index] = newTask
                    }
                }
                self.saveOnMyMindTasks()
            }
        )
    }
    
    // Add task
    func addOnMyMindTask(_ task: OnMyMindTask) {
        onMyMindTasks.append(task)
        self.saveOnMyMindTasks()
    }
    
    // Delete task
    func removeOnMyMindTask(_ task: OnMyMindTask) {
        onMyMindTasks.removeAll { $0.id == task.id }
        self.saveOnMyMindTasks()
    }
    
    // Toggle completion
    func toggleOnMyMindTaskCompletion(_ task: OnMyMindTask) {
        if let index = onMyMindTasks.firstIndex(where: { $0.id == task.id }) {
            onMyMindTasks[index].isCompleted.toggle()
            onMyMindTasks[index].completionDate = onMyMindTasks[index].isCompleted ? Date() : nil
        }
        self.saveOnMyMindTasks()
    }

    // Move tasks
    func moveOnMyMindTasks(from source: IndexSet, to destination: Int) {
        onMyMindTasks.move(fromOffsets: source, toOffset: destination)
        self.saveOnMyMindTasks()
    }
    
    // All task categories
    var allTaskCategories: [TaskCategory] {
        planner.taskCategories
    }
    
    func updateTaskTaskCategory(_ task: DailyTask, newCategory: TaskCategory) {
        if let index = planner.tasks.firstIndex(where: { $0.id == task.id }) {
            planner.tasks[index].category = newCategory
            savePlanner() // Save changes to PersistenceManager
        }
    }

    // Bindings to planner properties
    var reflectionQuestionsBinding: Binding<[ReflectionQuestion]> {
        Binding(
            get: { self.planner.reflectionQuestions },
            set: { newValue in
                self.planner.reflectionQuestions = newValue
            }
        )
    }
    
    var tasksBinding: Binding<[DailyTask]> {
        Binding(
            get: { self.planner.tasks },
            set: { newValue in
                self.planner.tasks = newValue
            }
        )
    }
}
