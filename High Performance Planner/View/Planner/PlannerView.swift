//
//  PlannerView.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/11/24.
//

import SwiftUI

struct PlannerView: View {
    
    @ObservedObject var plannerManager: PlannerManager
    
    var body: some View {
        NavigationView {
            if let planner = plannerManager.planner {
                Form {
                    reflectionSection
                    todoSeciton
                    reviewSection
                    reminderSection
                }
                .navigationTitle("\(planner.dateForViews())")
            } else {
                Text("Error loading planner...")
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing(true)
        }
        .onAppear {
            plannerManager.loadPlanner(for: .now)
        }
    }
    
    var reflectionSection: some View {
        ReflectionSectionView(
            header: Constants.reflectionHeader,
            questions: plannerManager.binding(for: \.reflectionQuestions)
        )
    }
    
    var todoSeciton: some View {
        TaskSectionView(
            header: "Today's Todos",
            plannerManager: plannerManager,
            tasks: plannerManager.binding(for: \.tasks))
    }
    
    var reviewSection: some View {
        Section(header: Text("Daily Review")) {
            Text("Third name:")
        }
    }
    
    var reminderSection: some View {
        Section(header: Text("Things to keep in mind")) {
            Text("Fourth name:")
        }
    }
}

#Preview {
    PlannerView(plannerManager: PlannerManager(dataService: FileDataService()))
}


