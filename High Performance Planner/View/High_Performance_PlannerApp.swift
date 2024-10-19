//
//  High_Performance_PlannerApp.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/11/24.
//

import SwiftUI

@main
struct High_Performance_PlannerApp: App {
    
    // Shared instance objects
    @StateObject private var taskCategoryManager = TaskCategoryManager(categoriesFile: Constants.taskCategoryFileURL)
    @StateObject private var dailyQuestionManager = DailyQuestionManager(reflectionQuestionsFile: Constants.reflectionQuestionsFileURL, reviewQuestionsFile: Constants.reviewQuestionsFileURL)
    
    var body: some Scene {
        WindowGroup {
            PlannerView()
        }
    }
    
    struct Constants {
        static let taskCategoryFileName: String = "taskCategories.json"
        static let reflectionQuestion: String = "reflectionQuestion.json"
        static let reviewQuestion: String = "reviewQuestion.json"
        
        static let taskCategoryFileURL: URL = getURLFrom(filename: taskCategoryFileName)
        static let reflectionQuestionsFileURL: URL = getURLFrom(filename: reflectionQuestion)
        static let reviewQuestionsFileURL: URL = getURLFrom(filename: reviewQuestion)
        
        static private func getURLFrom(filename: String) -> URL {
            let fileManager = FileManager.default
            let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            return documentsDirectory.appendingPathComponent(filename)
        }
    }
}
