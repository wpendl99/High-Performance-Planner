//
//  CategoryDot.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/15/24.
//

import SwiftUI

struct CategoryDot: View {
    @Binding var task: DailyTask
    @Binding var lastCategory: TaskCategory
    var categories: [TaskCategory]
    var updateTaskCategory: (DailyTask, TaskCategory) -> Void
    
    var body: some View {
        Menu {
            ForEach(categories) { category in
                Button(action: {
                    updateTaskCategory(task, category)
                    lastCategory = category
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(Color(hex: category.colorHex), .primary, .secondary)
                            .frame(width: 14, height: 14)
                        Text(category.name.capitalized)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 6)
                }
            }
        } label: {
            Circle()
                .fill(Color(hex: task.category.colorHex))
                .frame(width: 16, height: 16)
                .padding(.trailing, 8)
        }
        .menuStyle(BorderlessButtonMenuStyle())
    }
}
