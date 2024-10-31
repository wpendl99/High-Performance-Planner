//
//  Date+Formatted.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/31/24.
//

import Foundation

extension DateFormatter {
    static let fullDateWithWeekday: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy" // Weekday, Day Month Year
        formatter.locale = Locale.current
        return formatter
    }()
}
