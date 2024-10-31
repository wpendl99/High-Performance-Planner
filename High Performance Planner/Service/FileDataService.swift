//
//  FileDataService.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/21/24.
//

import Foundation

class FileDataService: DataService {
    private let fileManager = FileManager.default
    private let documentDirectory: URL
    private let dataFolderURL: URL
    private let configFolderURL: URL
    
    init(dataFolderName: String = "HighPerformancePlanners", configFolderName: String = "HighPerformancePlannersConfig"){
        // Setup the folder URL in the document directory
        documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        dataFolderURL = documentDirectory.appendingPathComponent(dataFolderName)
        configFolderURL = documentDirectory.appendingPathComponent(configFolderName)
        
        // Create the directory if it doesn't exist
        if !fileManager.fileExists(atPath: dataFolderURL.path) {
            try? fileManager.createDirectory(at: dataFolderURL, withIntermediateDirectories: true, attributes: nil)
        }
        
        if !fileManager.fileExists(atPath: configFolderURL.path) {
            try? fileManager.createDirectory(at: configFolderURL, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    // MARK: - Planner Functions
    func loadPlanner(for date: Date) -> DailyPlanner? {
        let fileURL = getDataFileURL(for: date)
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return try? JSONDecoder().decode(DailyPlanner.self, from: data)
    }
    
    func savePlanner(_ planner: DailyPlanner, for date: Date) {
        let fileURL = getDataFileURL(for: date)
        if let data = try? JSONEncoder().encode(planner) {
            try? data.write(to: fileURL)
        }
    }
    
    func deletePlanner(for date: Date) {
        let fileURL = getDataFileURL(for: date)
        try? fileManager.removeItem(at: fileURL)
    }
    
    func listAllPlanners() -> [Date] {
        // List all files in the directory
        guard let fileURLs = try? fileManager.contentsOfDirectory(at: dataFolderURL, includingPropertiesForKeys: nil),
              !fileURLs.isEmpty else { return [] }

        // Extract dates from filenames (assuming format "yyyy-MM-dd.json")
        let dateFormatter = Constants.dateFormatter
        var dates: [Date] = []

        for fileURL in fileURLs {
            let fileName = fileURL.deletingPathExtension().lastPathComponent
            if let date = dateFormatter.date(from: fileName) {
                dates.append(date)
            }
        }

        return dates.sorted()
    }
    
    // MARK: - OnMyMind Functions
    func loadOnMyMindTasks() -> [OnMyMindTask] {
        let fileURL = getDocuemntFileURL(for: "OnMyMindTasks")
        if let data = try? Data(contentsOf: fileURL),
           let decodedData = try? JSONDecoder().decode([OnMyMindTask].self, from: data) {
            if decodedData != [] { return decodedData }
        }
        return []
    }
    
    func saveOnMyMindTasks(_ tasks: [OnMyMindTask]) {
        let fileURL = getDocuemntFileURL(for: "OnMyMindTasks")
        if let encodedData = try? JSONEncoder().encode(tasks) {
            try? encodedData.write(to: fileURL)
        }
    }
    
    // MARK: - Default Functions
    func loadDefaultTaskCategories() -> [TaskCategory] {
        let fileURL = getConfigFileURL(for: "TaskCategoriesDefaults")
        if let data = try? Data(contentsOf: fileURL),
           let decodedData = try? JSONDecoder().decode([TaskCategory].self, from: data) {
            if decodedData != [] { return decodedData }
        }
        return Constants.defaultTaskCategories()
    }
    
    func saveDefaultTaskCategories(_ categories: [TaskCategory]) {
        let fileURL = getConfigFileURL(for: "TaskCategoriesDefaults")
        if let encodedData = try? JSONEncoder().encode(categories) {
            try? encodedData.write(to: fileURL)
        }
    }
    
    func loadDefaultReflectionQuestions() -> [ReflectionQuestion] {
        let fileURL = getConfigFileURL(for: "ReflectionQuestionsDefaults")
        if let data = try? Data(contentsOf: fileURL),
           let decodedData = try? JSONDecoder().decode([ReflectionQuestion].self, from: data) {
            if decodedData != [] { return decodedData }
        }
        return Constants.defaultReflectionQuestions()
    }
    
    func saveDefaultReflectionQuestions(_ questions: [ReflectionQuestion]) {
        let fileURL = getConfigFileURL(for: "ReflectionQuestionsDefaults")
        if let encodedData = try? JSONEncoder().encode(questions) {
            try? encodedData.write(to: fileURL)
        }
    }
    
    func loadDefaultReviewQuestions() -> [ReviewQuestion] {
        let fileURL = getConfigFileURL(for: "ReviewQuestionsDefaults")
        if let data = try? Data(contentsOf: fileURL),
           let decodedData = try? JSONDecoder().decode([ReviewQuestion].self, from: data) {
            if decodedData != [] { return decodedData }
        }
        return Constants.defaultReviewQuestions()
    }
    
    func saveDefaultReviewQuestions(_ questions: [ReviewQuestion]) {
        let fileURL = getConfigFileURL(for: "ReviewQuestionsDefaults")
        if let encodedData = try? JSONEncoder().encode(questions) {
            try? encodedData.write(to: fileURL)
        }
    }
    
    // MARK: - Helper Functions
    private func getDataFileURL(for date: Date) -> URL {
        let dateString = Constants.dateFormatter.string(from: date)
        return dataFolderURL.appendingPathComponent("\(dateString).json")
    }
    
    private func getConfigFileURL(for file: String) -> URL {
        let fileName = "\(file).json"
        return configFolderURL.appendingPathComponent(fileName)
    }
    
    private func getDocuemntFileURL(for file: String) -> URL {
        let fileName = "\(file).json"
        return documentDirectory.appendingPathComponent(fileName)
    }
}
