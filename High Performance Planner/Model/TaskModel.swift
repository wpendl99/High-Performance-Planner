//
//  TaskModel.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/15/24.
//

import Foundation

protocol Todo: Identifiable, Codable, Equatable {
    var id: UUID { get set }
    var description: String { get set }
    var notes: String? { get set }
    var isCompleted: Bool { get set }
    var completionDate: Date? { get set }
}

struct DailyTask: Todo {
    var id: UUID = UUID()
    var description: String
    var notes: String?
    var isCompleted: Bool = false
    var completionDate: Date?
    var dueDate: Date?
    var category: TaskCategory
    
    init(_ description: String, category: TaskCategory){
        self.id = UUID()
        self.description = description
        self.notes = nil
        self.isCompleted = false
        self.completionDate = nil
        self.dueDate = nil
        self.category = category
    }
    
    init(from task: any Todo, dueDate: Date, category: TaskCategory){
        self.id = task.id
        self.description = task.description
        self.notes = task.notes
        self.isCompleted = task.isCompleted
        self.completionDate = task.completionDate
        self.dueDate = dueDate
        self.category = category
    }
}

struct OnMyMindTask: Todo {
    var id: UUID = UUID()
    var description: String
    var notes: String?
    var isCompleted: Bool = false
    var completionDate: Date?
    
    init(_ description: String){
        self.id = UUID()
        self.description = description
        self.notes = nil
        self.isCompleted = false
        self.completionDate = nil
    }
}
