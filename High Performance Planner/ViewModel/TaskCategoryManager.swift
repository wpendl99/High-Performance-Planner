//
//  TaskCategoryManager.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/18/24.
//

import Foundation

class TaskCategoryManager: ObservableObject {
    private var taskCategories: [TaskCategory] = []
    private let categoriesFile: URL
    
    init(categoriesFile: URL) {
        self.categoriesFile = categoriesFile
        loadCategories()
    }
    
//    Load categories from the file
    private func loadCategories() {
        guard let data = try? Data(contentsOf: categoriesFile) else { return }
        let decoder = JSONDecoder()
        if let categories = try? decoder.decode([TaskCategory].self, from: data) {
            taskCategories = categories
        } else {
            taskCategories = TaskCategory.defaultCategories()
        }
    }
    
//    Save categories to the file
    private func saveCategories() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(taskCategories) {
            try? data.write(to: categoriesFile)
        }
    }
    
//    Get the current categories
    func getCategories() -> [TaskCategory] {
        taskCategories
    }
    
//    Add a new category
    func addCategory(_ category: TaskCategory) {
        taskCategories.append(category)
        saveCategories()
    }
    
//    Remove a category
    func removeCategory(_ category: TaskCategory) {
        if let index = taskCategories.firstIndex(of: category) {
            taskCategories.remove(at: index)
            saveCategories()
        }
    }
    
}
