//
//  High_Performance_PlannerApp.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/11/24.
//

import SwiftUI
import Combine

@main
struct High_Performance_PlannerApp: App {
    init() {
        let fileDataService = FileDataService()
        PersistenceManager.configure(with: fileDataService)
    }
    
    @State var selection = 1
    @State private var lastCheckedDate = Date().startOfDay()
    @State private var currentPlannerDate = Date()
    private let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selection) {
                HistoryView()
                    .tabItem { Label("History", systemImage: "clock") }
                    .tag(0)
                
                PlannerView(date: currentPlannerDate, viewMode: .full)
                    .tabItem { Label("Planner", systemImage: "list.bullet") }
                    .tag(1)
                    .onReceive(timer) { _ in
                        checkForDateChange()
                    }
                
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gearshape") }
                    .tag(2)
            }
        }
    }
    
    private func checkForDateChange() {
        let today = Date().startOfDay()
        if today != lastCheckedDate {
            lastCheckedDate = today
            currentPlannerDate = today // Update the date to refresh PlannerView
        }
    }
}

