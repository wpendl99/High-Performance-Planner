//
//  Date+startOfDay.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/21/24.
//

import Foundation

extension Date {
    // Helper function to get just the year, month, and day components
    func startOfDay() -> Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self)
    }
}
