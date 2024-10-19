//
//  DailyQuestionManager.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/18/24.
//

import Foundation

class DailyQuestionManager: ObservableObject {
    private var reflectionQuestions: [ReflectionQuestion] = []
    private var reviewQuestions: [ReviewQuestion] = []
    private var reflectionQuestionsFile: URL
    private var reviewQuestionsFile: URL
    
    init(reflectionQuestionsFile: URL, reviewQuestionsFile: URL) {
        self.reflectionQuestionsFile = reflectionQuestionsFile
        self.reviewQuestionsFile = reviewQuestionsFile
        loadQuestions()
    }
    
//    Load questions from the files
    private func loadQuestions() {
        guard let reflectionQuestionsData = try? Data(contentsOf: reflectionQuestionsFile),
              let reviewQuestionsData = try? Data(contentsOf: reviewQuestionsFile) else { return }
        
        let decoder = JSONDecoder()
        
        if let reflectionQuestions = try? decoder.decode([ReflectionQuestion].self, from: reflectionQuestionsData) {
            self.reflectionQuestions = reflectionQuestions
        }
        
        if let reviewQuestions = try? decoder.decode([ReviewQuestion].self, from: reviewQuestionsData) {
            self.reviewQuestions = reviewQuestions
        }
    }
    
//    Save questions to the file
    private func saveQuestions() {
        if let reflectionQuestionsData = try? JSONEncoder().encode(reflectionQuestions),
           let reviewQuestionsData = try? JSONEncoder().encode(reviewQuestions) {
            try? reflectionQuestionsData.write(to: reflectionQuestionsFile)
            try? reviewQuestionsData.write(to: reviewQuestionsFile)
        }
    }
    
//    Get the questions
    func getReflectionQuestions() -> [ReflectionQuestion] {
        return reflectionQuestions
    }
    
    func getReviewQuestions() -> [ReviewQuestion] {
        return reviewQuestions
    }
    
//    Add questions
    func addReflectionQuestion(_ question: ReflectionQuestion) {
        reflectionQuestions.append(question)
        saveQuestions()
    }
    
    func addReviewQuestion(_ question: ReviewQuestion) {
        reviewQuestions.append(question)
        saveQuestions()
    }
    
//    Remove questions
    func removeReflectionQuestion(_ question: ReflectionQuestion) {
        if let index = reflectionQuestions.firstIndex(of: question) {
            reflectionQuestions.remove(at: index)
            saveQuestions()
        }
    }
    
    func removeReviewQuestion(_ question: ReviewQuestion) {
        if let index = reviewQuestions.firstIndex(of: question) {
            reviewQuestions.remove(at: index)
            saveQuestions()
        }
    }
}
