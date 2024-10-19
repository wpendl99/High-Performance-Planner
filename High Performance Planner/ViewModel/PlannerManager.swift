//
//  PlannerManager.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/19/24.
//

import Foundation
import Combine

class PlannerManager: ObservableObject {
    private var dailyPlanner: DailyPlanner
    private let plannerFile: URL
    private let dailyQuestionManager: DailyQuestionManager
    private let taskCategoryManager: TaskCategoryManager
    
    init(plannerFile: URL, dailyQuestionManager: DailyQuestionManager, taskCategoryManager: TaskCategoryManager) {
        self.plannerFile = plannerFile
        self.dailyQuestionManager = dailyQuestionManager
        self.taskCategoryManager = taskCategoryManager
        
        if let planner = PlannerManager.loadFromFile(plannerFile: plannerFile) {
            self.dailyPlanner = planner
        } else {
            self.dailyPlanner = DailyPlanner(
                date: Date(),
                reflectionQuestions: dailyQuestionManager.getReflectionQuestions(),
                taskCategories: taskCategoryManager.getCategories(),
                tasks: [],
                reviewQuestions: dailyQuestionManager.getReviewQuestions()
            )
        }
    }
    
//    Load Planner from file
    private static func loadFromFile(plannerFile: URL) -> DailyPlanner? {
        if let data = try? Data(contentsOf: plannerFile),
           let planner = try? JSONDecoder().decode(DailyPlanner.self, from: data) {
            return planner
        }
        return nil
    }
    
//    Save planner to file
    private static func saveToFile(planner: DailyPlanner, plannerFile: URL) {
        if let data = try? JSONEncoder().encode(planner) {
            try? data.write(to: plannerFile)
        }
    }
    
//    Get functions for each component
    func getReflectionQuestions() -> [ReflectionQuestion] {
        dailyPlanner.reflectionQuestions
    }
    
    func getTaskCategories() -> [TaskCategory] {
        dailyPlanner.taskCategories
    }
    
    func getTasks() -> [DailyTask] {
        dailyPlanner.tasks
    }
    
    func getReviewQuestions() -> [ReviewQuestion] {
        dailyPlanner.reviewQuestions
    }
    
//    Update functions for each component
    func updateReflectionQuestions(_ questions: [ReflectionQuestion]) {
        dailyPlanner.reflectionQuestions = questions
        PlannerManager.saveToFile(planner: dailyPlanner, plannerFile: plannerFile)
    }
    
    func updateTaskCategories(_ categories: [TaskCategory]) {
        dailyPlanner.taskCategories = categories
        PlannerManager.saveToFile(planner: dailyPlanner, plannerFile: plannerFile)
    }
    
    func updateTasks(_ tasks: [DailyTask]) {
        dailyPlanner.tasks = tasks
        PlannerManager.saveToFile(planner: dailyPlanner, plannerFile: plannerFile)
    }
    
    func updateReviewQuestions(_ questions: [ReviewQuestion]) {
        dailyPlanner.reviewQuestions = questions
        PlannerManager.saveToFile(planner: dailyPlanner, plannerFile: plannerFile)
    }
}
