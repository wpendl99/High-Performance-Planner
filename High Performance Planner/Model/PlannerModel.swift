//
//  PlannerModel.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/19/24.
//

import Foundation

struct DailyPlanner: Codable {
    var date: Date
    var reflectionQuestions: [ReflectionQuestion]
    var taskCategories: [TaskCategory]
    var tasks: [DailyTask]
    var reviewQuestions: [ReviewQuestion]
}
