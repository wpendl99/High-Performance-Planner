//
//  HistoryView.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/19/24.
//

import SwiftUI

struct HistoryView: View {
    @State private var showPlanner = false
    @State private var selectedDate: Date? = nil
    @State private var plannerDates: [Date] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(plannerDates.filter { !$0.isToday }, id: \.self) { date in
                    Button(action: {
                        selectedDate = date
                        showPlanner = true
                        //                        loadPlannerAndShow(for: date)
                    }) {
                        Text(DateFormatter.dateForLists(from: date))
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle("History")
            .onAppear {
                loadPlannerDates()
            }
            .sheet(isPresented: $showPlanner) {
                if let date = selectedDate {
                    PlannerView(date: date, viewMode: .history, isEditing: false)
                        .ignoresSafeArea()
                }
            }
        }
    }
    
    private func loadPlannerDates() {
        plannerDates = PersistenceManager.shared.listAllPlanners().filter { !$0.isToday }
    }
}

extension Date {
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
}

#Preview {
    HistoryView()
}
