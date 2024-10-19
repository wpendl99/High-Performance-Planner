//
//  OnMyMindTaskManager.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/19/24.
//

import Foundation

class OnMyMindTaskManager: ObservableObject {
    private var tasks: [OnMyMindTask] = []
    
    struct Constants {
        static let taskKey = "OnMyMindTasks"
    }
    
    init() {
        self.tasks = OnMyMindTaskManager.loadTasks()
    }
    
//    Load Tasks from UserDefaults
    private static func loadTasks() -> [OnMyMindTask] {
        if let data = UserDefaults.standard.data(forKey: Constants.taskKey),
           let tasks = try? JSONDecoder().decode([OnMyMindTask].self, from: data) {
            return tasks
        }
        return []
    }
    
//    Save Tasks to UserDefaults
    func saveTasks() {
        if let data = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(data, forKey: Constants.taskKey)
        }
    }
    
//    Get Function
    func getTasks() -> [OnMyMindTask] {
        tasks
    }
    
//    Update Functions
    func addTask(_ task: OnMyMindTask) {
        tasks.append(task)
        saveTasks()
    }
    
    func updateTask(_ task: OnMyMindTask) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks[index] = task
        saveTasks()
    }
    
//    Delete Functions
    func deleteTask(_ task: OnMyMindTask) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        saveTasks()
    }
}
