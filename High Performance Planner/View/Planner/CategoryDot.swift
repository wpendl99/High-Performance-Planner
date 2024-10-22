////
////  CategoryDot.swift
////  High Performance Planner
////
////  Created by William Pendleton on 10/15/24.
////
//
//import SwiftUI
//
//struct CategoryDot: View {
//    var category: TaskCategory
//    
//    var body: some View {
//        Menu {
//            ForEach(TaskCategory.allCases) { cat in
//                Button(action: {
////                    category = cat
//                }) {
//                    HStack(spacing: 12) {
//                        Circle()
//                            .fill(cat.color)
//                            .frame(width: 14, height: 14)
//                        Text(cat.rawValue.capitalized)
//                            .foregroundColor(.primary)
//                    }
//                    .padding(.vertical, 6)
//                }
//            }
//        } label: {
//            Circle()
//                .fill(category.color)
//                .frame(width: 16, height: 16)
//                .padding(.trailing, 8)
//        }
//        .menuStyle(BorderlessButtonMenuStyle())
//    }
//}
