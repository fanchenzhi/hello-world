//
//  ContentView.swift
//  Hello
//
//  Created by Fred Fan on 2024/11/8.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var workoutStore = WorkoutStore()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            RecordsView(workoutStore: workoutStore)
                .tabItem {
                    Label("记录", systemImage: "list.bullet")
                }
                .tag(0)
            
            StatisticsView(workoutStore: workoutStore)
                .tabItem {
                    Label("统计", systemImage: "chart.bar")
                }
                .tag(1)
            
            ExerciseLibraryView()
                .tabItem {
                    Label("动作库", systemImage: "dumbbell.fill")
                }
                .tag(2)
            
            GoalsView(workoutStore: workoutStore)
                .tabItem {
                    Label("目标", systemImage: "target")
                }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
}
