//
//  TaskModel.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/15/24.
//

import Foundation

protocol Task: Identifiable, Codable {
    var id: UUID { get set }
    var description: String { get set }
    var notes: String? { get set }
    var isCompleted: Bool { get set }
    var completionDate: Date? { get set }
}

struct DailyTask: Task {
    var id: UUID = UUID()
    var description: String
    var notes: String?
    var isCompleted: Bool
    var completionDate: Date?
    var dueDate: Date?
    var category: TaskCategory?
}

struct OnMyMindTask: Task {
    var id: UUID = UUID()
    var description: String
    var notes: String?
    var isCompleted: Bool = false
    var completionDate: Date?
}
