//
//  Date+Formatted.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/31/24.
//

import Foundation

extension DateFormatter {
    static let halfDateWithWeekdayAndSuffix: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d" // Weekday, Day Month Year
        formatter.locale = Locale.current
        return formatter
    }()
    
    static let fullDateWithWeekdayAndSuffix: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, YYYY" // Weekday, Day Month Year
        formatter.locale = Locale.current
        return formatter
    }()
    
    static func dateForTitles(from date: Date) -> String {
        let day = Calendar.current.component(.day, from: date)
        let dayWithSuffix = "\(day)\(daySuffix(for: day))"
        
        let baseDateString = DateFormatter.halfDateWithWeekdayAndSuffix.string(from: date)
        return baseDateString.replacingOccurrences(of: "\(day)", with: dayWithSuffix)
    }
    
    static func dateForLists(from date: Date) -> String {
        let day = Calendar.current.component(.day, from: date)
        let dayWithSuffix = "\(day)\(daySuffix(for: day))"
        
        let baseDateString = DateFormatter.fullDateWithWeekdayAndSuffix.string(from: date)
        return baseDateString.replacingOccurrences(of: "\(day)", with: dayWithSuffix)
    }
    
    private static func daySuffix(for day: Int) -> String {
        switch day {
        case 11, 12, 13:
            return "th"
        default:
            switch day % 10 {
            case 1:
                return "st"
            case 2:
                return "nd"
            case 3:
                return "rd"
            default:
                return "th"
            }
        }
    }
}
