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
    @StateObject private var taskCategoryManager = TaskCategoryManager(categoriesFileURL: Constants.taskCategoryFileURL)
    
    var body: some Scene {
        WindowGroup {
            PlannerView()
        }
    }
    
    struct Constants {
        static let taskCategoryFileName: String = "taskCategories.json"
        static let taskCategoryFileURL: URL = {
            let fileManager = FileManager.default
            let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            return documentsDirectory.appendingPathComponent(taskCategoryFileName)
        }()
    }
}
