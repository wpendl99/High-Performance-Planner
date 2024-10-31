//
//  PersistenceManager.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/28/24.
//

import Foundation

class PersistenceManager {
    static var shared: PersistenceManager!

    private let dataService: any DataService

    // Private initializer with required DataService
    private init(dataService: any DataService) {
        self.dataService = dataService
    }

    // Configuration method to initialize the singleton instance
    static func configure(with dataService: any DataService) {
        guard shared == nil else {
            print("PersistenceManager is already configured.")
            return
        }
        shared = PersistenceManager(dataService: dataService)
    }

    // MARK: - Planner Functions

    func savePlanner(_ planner: DailyPlanner, for date: Date) {
        dataService.savePlanner(planner, for: date)
    }
    
    func loadPlanner(for date: Date) -> DailyPlanner? {
        return dataService.loadPlanner(for: date)
    }
    
    func deletePlanner(for date: Date) {
        dataService.deletePlanner(for: date)
    }
    
    func listAllPlanners() -> [Date] {
        return dataService.listAllPlanners()
    }

    // MARK: - OnMyMind Tasks Functions

    func saveOnMyMindTasks(_ tasks: [OnMyMindTask]) {
        dataService.saveOnMyMindTasks(tasks)
    }

    func loadOnMyMindTasks() -> [OnMyMindTask] {
        return dataService.loadOnMyMindTasks()
    }

    // MARK: - Default Data Functions

    func loadDefaultTaskCategories() -> [TaskCategory] {
        return dataService.loadDefaultTaskCategories()
    }

    func saveDefaultTaskCategories(_ categories: [TaskCategory]) {
        dataService.saveDefaultTaskCategories(categories)
    }

    func loadDefaultReflectionQuestions() -> [ReflectionQuestion] {
        return dataService.loadDefaultReflectionQuestions()
    }

    func saveDefaultReflectionQuestions(_ questions: [ReflectionQuestion]) {
        dataService.saveDefaultReflectionQuestions(questions)
    }

    func loadDefaultReviewQuestions() -> [ReviewQuestion] {
        return dataService.loadDefaultReviewQuestions()
    }

    func saveDefaultReviewQuestions(_ questions: [ReviewQuestion]) {
        dataService.saveDefaultReviewQuestions(questions)
    }
}
