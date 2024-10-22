//
//  QuestionModel.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/18/24.
//

import Foundation

typealias TextQuestion = ReflectionQuestion

protocol Question: Identifiable, Codable, Equatable {
    var id: String { get set }
    var question: String { get set }
}

struct ReflectionQuestion: Question {
    var id: String = UUID().uuidString
    var question: String
    var placeholder: String
    var answer: String = ""
}

struct ReviewQuestion: Question {
    var id: String = UUID().uuidString
    var question: String
    var score: Double?
    var notes: String?
}
