//
//  EditableTaskCategory.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/21/24.
//

import Foundation
import UIKit

class EditableTaskCategory: ObservableObject, Identifiable {
    @Published var category: TaskCategory
    
    init(category: TaskCategory) {
        self.category = category
    }
}
