//
//  EditableQuestion.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/21/24.
//

import Foundation

class EditableQuestion<T: Question>: ObservableObject, Identifiable {
    @Published var question: T
    
    init(question: T) {
        self.question = question
    }
}
