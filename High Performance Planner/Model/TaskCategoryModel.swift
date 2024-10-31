//
//  TaskCategoryModel.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/18/24.
//

import Foundation
import UIKit

struct TaskCategory: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var colorHex: String
    
    init(name: String, colorHex: String) {
        self.name = name
        self.colorHex = colorHex
    }
}
