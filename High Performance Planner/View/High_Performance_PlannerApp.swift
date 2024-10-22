//
//  High_Performance_PlannerApp.swift
//  High Performance Planner
//
//  Created by William Pendleton on 10/11/24.
//

import SwiftUI

@main
struct High_Performance_PlannerApp: App {
    
    // Shared instance objects
    @StateObject private var dataService = FileDataService()
    @StateObject private var plannerManager = PlannerManager(dataService: FileDataService())
    
    @State var selection = 1
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selection) {
                HistoryView()
                    .tabItem { Label("History", systemImage: "clock")}
                    .tag(0)
                
                PlannerView(plannerManager: plannerManager)
                    .tabItem { Label("Planner", systemImage: "list.bullet")}
                    .tag(1)
                
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gearshape")}
                    .tag(2)
            }
        }
    }
}
