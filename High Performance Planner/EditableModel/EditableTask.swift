//
//  EditableTask.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/21/24.
//

import Foundation

class EditableTask<T: Task>: ObservableObject, Identifiable {
    @Published var task: T
    
    init(task: T) {
        self.task = task
    }
}
