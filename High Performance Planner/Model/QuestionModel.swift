//
//  QuestionModel.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/18/24.
//

import Foundation

protocol Question: Identifiable, Codable, Equatable {
    var id: String { get set }
    var question: String { get set }
}

struct ReflectionQuestion: Question {
    var id: String = UUID().uuidString
    var question: String
    var answer: String?
    
    static func defaultQuestions() -> [ReflectionQuestion] {
        [
            ReflectionQuestion(question: "What can I look forward to today?"),
            ReflectionQuestion(question: "Something I am thankful for today:"),
        ]
    }
}

struct ReviewQuestion: Question {
    var id: String = UUID().uuidString
    var question: String
    var score: Double?
    var notes: String?
    
    static func defaultQuestions() -> [ReviewQuestion] {
        [
            ReviewQuestion(question: "I worked intentionally today"),
            ReviewQuestion(question: "I accomplished the things that had to happen today"),
            ReviewQuestion(question: "I took care of work"),
            ReviewQuestion(question: "I took care of important relationships"),
            ReviewQuestion(question: "I took care of my physical self"),
            ReviewQuestion(question: "I took care of my emotional/spiritual self"),
        ]
    }
}
