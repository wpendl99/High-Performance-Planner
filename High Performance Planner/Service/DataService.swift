//
//  DataService.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/21/24.
//

import Foundation

protocol DataService: ObservableObject {
    // MARK: - Planner Functions
    func loadPlanner(for date: Date) -> DailyPlanner?
    func savePlanner(_ planner: DailyPlanner, for date: Date)
    func deletePlanner(for date: Date)
    func listAllPlanners() -> [Date]
    
    // MARK: - OnMyMind Functions
    func loadOnMyMindTasks() -> [OnMyMindTask]
    func saveOnMyMindTasks(_ tasks: [OnMyMindTask])
    
    // MARK: - Defaults Functions
    func loadDefaultTaskCategories() -> [TaskCategory]
    func saveDefaultTaskCategories(_ categories: [TaskCategory])
    func loadDefaultReflectionQuestions() -> [ReflectionQuestion]
    func saveDefaultReflectionQuestions(_ questions: [ReflectionQuestion])
    func loadDefaultReviewQuestions() -> [ReviewQuestion]
    func saveDefaultReviewQuestions(_ questions: [ReviewQuestion])
}
