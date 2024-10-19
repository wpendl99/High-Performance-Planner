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
    private func saveToFile() {
        if let data = try? JSONEncoder().encode(dailyPlanner) {
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
    func updateReflectionQuestion(_ question: ReflectionQuestion) {
        if let index = dailyPlanner.reflectionQuestions.firstIndex(of: question) {
            dailyPlanner.reflectionQuestions[index].question = question.question
        } else {
            dailyPlanner.reflectionQuestions.append(question)
        }
        saveToFile()
    }
    
    func updateReflectionQuestionAnswer(_ question: ReflectionQuestion) {
        if let index = dailyPlanner.reflectionQuestions.firstIndex(of: question) {
            dailyPlanner.reflectionQuestions[index].answer = question.answer
            saveToFile()
        }
    }
    
    func updateTaskCategories(_ categories: [TaskCategory]) {
        dailyPlanner.taskCategories = categories
        saveToFile()
    }
    
    func updateTask(_ task: DailyTask) {
        if let index = dailyPlanner.tasks.firstIndex(of: task) {
            dailyPlanner.tasks[index] = task
            saveToFile()
        }
    }
    
    func updateTasks(_ tasks: [DailyTask]) {
        dailyPlanner.tasks = tasks
        saveToFile()
    }
    
    func updateReviewQuestion(_ question: ReviewQuestion) {
        if let index = dailyPlanner.reviewQuestions.firstIndex(of: question) {
            dailyPlanner.reviewQuestions[index].question = question.question
        } else {
            dailyPlanner.reviewQuestions.append(question)
        }
        saveToFile()
    }
    
    func updateReviewQuestionAnswer(_ question: ReviewQuestion) {
        if let index = dailyPlanner.reviewQuestions.firstIndex(of: question) {
            dailyPlanner.reviewQuestions[index].notes = question.notes
            dailyPlanner.reviewQuestions[index].score = question.score
            saveToFile()
        }
    }
    
//    Remove Functions
    func removeReflectionQuestion(_ question: ReflectionQuestion) {
        if let index = dailyPlanner.reflectionQuestions.firstIndex(of: question) {
            dailyPlanner.reflectionQuestions.remove(at: index)
            saveToFile()
        }
    }
    
    func removeTask(_ task: DailyTask) {
        if let index = dailyPlanner.tasks.firstIndex(of: task) {
            dailyPlanner.tasks.remove(at: index)
            saveToFile()
        }
    }
    
    func removeReviewQuestion(_ question: ReviewQuestion) {
        if let index = dailyPlanner.reviewQuestions.firstIndex(of: question) {
            dailyPlanner.reviewQuestions.remove(at: index)
            saveToFile()
        }
    }
}
