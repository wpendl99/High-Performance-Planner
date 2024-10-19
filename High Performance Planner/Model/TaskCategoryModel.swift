//
//  TaskCategoryModel.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/18/24.
//

import Foundation
import UIKit

struct TaskCategory: Identifiable, Codable, Equatable {
    var id: String
    let name: String
    var colorHex: String
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
        self.colorHex = UIColor(red: .random(in: 0...2), green: .random(in: 0...2), blue: .random(in: 0...2), alpha: 1.0).hashValue.description
    }
    
    init(name: String, colorHex: String) {
        self.id = UUID().uuidString
        self.name = name
        self.colorHex = colorHex
    }
    
    static func defaultCategories() -> [TaskCategory] {
        return [
            TaskCategory(name: "Work"),
            TaskCategory(name: "School"),
            TaskCategory(name: "Relations"),
            TaskCategory(name: "Physical"),
            TaskCategory(name: "Emotional")
        ]
    }
}
