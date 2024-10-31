//
//  Constants.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/21/24.
//

import Foundation

struct Constants {
    static let reflectionHeader = "Reflection"
    static let todoHeader = "Things to get done today"
    static let reviewHeader = "Daily Review"
    static let reminderHeader = "Other Things on my mind"
    
    // MARK: - Helper Functions
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let dateFormatterForTitles: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter
    }()
    
    static let dateFormatterForViews: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM dd, yyyy"
        return formatter
    }()
    
    // MARK: - Default Values
    static func defaultTaskCategories() -> [TaskCategory] {
        [
            TaskCategory(name: "Work", colorHex: "#ED5564"),
            TaskCategory(name: "School", colorHex: "#FFCE54"),
            TaskCategory(name: "Relations", colorHex: "#A0D568"),
            TaskCategory(name: "Physical", colorHex: "#4FC1E8"),
            TaskCategory(name: "Emotional", colorHex: "#AC92EB")
        ]
    }
    
    static func defaultReflectionQuestions() -> [ReflectionQuestion] {
        [
            ReflectionQuestion(question: "What can I look forward to today?", placeholder: "I am looking forward to..."),
            ReflectionQuestion(question: "Something I am thankful for today:", placeholder: "I am thankful for..."),
        ]
    }
    
    static func defaultReviewQuestions() -> [ReviewQuestion] {
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

