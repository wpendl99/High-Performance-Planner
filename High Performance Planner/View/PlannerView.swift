//
//  PlannerView.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/11/24.
//

import SwiftUI

struct Constants {
    static let reflectionHeader = "Reflection"
    static let todoHeader = "Things to get done today"
    static let reviewHeader = "Daily Review"
    static let reminderHeader = "Other Things on my mind"
}



struct PlannerView: View {
    @State private var lookForwardResponse: String = ""
    @State private var gratefulResponse: String = ""
    
    @State var reflectionQuestions = [
        TextQuestion(question: "What can I look forward to today?", placeholder: "I am looking forward to..."),
        TextQuestion(question: "Something I am thankful for today?", placeholder: "I am thankful for...")
    ]
    
    @State private var dummy: String = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                reflectionSection
                todoSeciton
                reviewSection
                reminderSection
            }
            .navigationTitle("Planner")
        }
    }
    
    var reflectionSection: some View {
        TextSectionView(header: "Daily Reflection", questions: $reflectionQuestions)
    }
    
    var todoSeciton: some View {
        Section(header: Text("Daily Todos")) {
            TextField("Second name:", text: $dummy)
        }
    }
    
    var reviewSection: some View {
        Section(header: Text("Daily Review")) {
            TextField("Third name:", text: $dummy)
        }
    }
    
    var reminderSection: some View {
        Section(header: Text("Things to keep in mind")) {
            TextField("Fourth name:", text: $dummy)
        }
    }
}



#Preview {
    PlannerView()
}
