//
//  ContentView.swift
//  Hello
//
//  Created by Fred Fan on 2024/11/8.
//

import SwiftUI
import Charts

class WorkoutStore: ObservableObject {
    @Published var workoutRecords: [WorkoutRecord] = []
    @Published var workoutGoals: [WorkoutGoal] = []
    
    private let recordsKey = "workoutRecords"
    private let goalsKey = "workoutGoals"
    
    init() {
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: recordsKey),
           let records = try? JSONDecoder().decode([WorkoutRecord].self, from: data) {
            workoutRecords = records
        }
        
        if let data = UserDefaults.standard.data(forKey: goalsKey),
           let goals = try? JSONDecoder().decode([WorkoutGoal].self, from: data) {
            workoutGoals = goals
        }
    }
    
    func saveData() {
        if let encoded = try? JSONEncoder().encode(workoutRecords) {
            UserDefaults.standard.set(encoded, forKey: recordsKey)
        }
        if let encoded = try? JSONEncoder().encode(workoutGoals) {
            UserDefaults.standard.set(encoded, forKey: goalsKey)
        }
    }
}

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
            
            GoalsView(workoutStore: workoutStore)
                .tabItem {
                    Label("目标", systemImage: "target")
                }
                .tag(2)
        }
    }
}

struct RecordsView: View {
    @ObservedObject var workoutStore: WorkoutStore
    @State private var showingAddWorkout = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(workoutStore.workoutRecords.sorted(by: { $0.date > $1.date })) { record in
                    NavigationLink(destination: WorkoutDetailView(record: record)) {
                        WorkoutRowView(record: record)
                    }
                }
            }
            .navigationTitle("健身记录")
            .toolbar {
                Button(action: { showingAddWorkout = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddWorkout) {
                AddWorkoutView(workoutStore: workoutStore)
            }
        }
    }
}

struct WorkoutRowView: View {
    let record: WorkoutRecord
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: record.date)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(record.type.rawValue)
                .font(.headline)
            HStack {
                Text("时长: \(record.duration)分钟")
                Text("卡路里: \(record.calories)")
                Spacer()
                Text(formattedDate)
                    .foregroundColor(.gray)
            }
            .font(.subheadline)
        }
        .padding(.vertical, 4)
    }
}

struct StatisticsView: View {
    @ObservedObject var workoutStore: WorkoutStore
    
    private var thisWeekRecords: [WorkoutRecord] {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        return workoutStore.workoutRecords.filter { record in
            calendar.isDate(record.date, equalTo: startOfWeek, toGranularity: .weekOfYear)
        }
    }
    
    private var workoutTypeDistribution: [(type: WorkoutType, count: Int)] {
        var distribution: [WorkoutType: Int] = [:]
        for record in workoutStore.workoutRecords {
            distribution[record.type, default: 0] += 1
        }
        return distribution.map { ($0.key, $0.value) }
            .sorted { $0.1 > $1.1 }
    }
    
    // 用于图表的数据结构
    private struct ChartData: Identifiable {
        let id = UUID()
        let date: Date
        let duration: Int
        let type: String
    }
    
    private var chartData: [ChartData] {
        thisWeekRecords.map { record in
            ChartData(date: record.date, duration: record.duration, type: record.type.rawValue)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("本周运动统计") {
                    if chartData.isEmpty {
                        Text("本周暂无运动记录")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    } else {
                        Chart(chartData) { data in
                            BarMark(
                                x: .value("日期", data.date, unit: .day),
                                y: .value("时长", data.duration)
                            )
                            .foregroundStyle(by: .value("类型", data.type))
                        }
                        .frame(height: 200)
                    }
                }
                
                Section("运动类型分布") {
                    if workoutTypeDistribution.isEmpty {
                        Text("暂无运动记录")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    } else {
                        Chart(workoutTypeDistribution, id: \.type) { item in
                            SectorMark(
                                angle: .value("数量", Double(item.count))
                            )
                            .foregroundStyle(by: .value("类型", item.type.rawValue))
                        }
                        .frame(height: 200)
                        
                        ForEach(workoutTypeDistribution, id: \.type) { item in
                            HStack {
                                Text(item.type.rawValue)
                                Spacer()
                                Text("\(item.count)次")
                            }
                        }
                    }
                }
            }
            .navigationTitle("统计")
        }
    }
}

struct GoalsView: View {
    @ObservedObject var workoutStore: WorkoutStore
    @State private var showingAddGoal = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(workoutStore.workoutGoals) { goal in
                    VStack(alignment: .leading) {
                        Text(goal.type.rawValue)
                            .font(.headline)
                        Text("每周目标: \(goal.targetFrequency)次")
                        Text("每次时长: \(goal.targetDuration)分钟")
                    }
                }
            }
            .navigationTitle("运动目标")
            .toolbar {
                Button(action: { showingAddGoal = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddGoal) {
                AddGoalView(workoutStore: workoutStore)
            }
        }
    }
}

#Preview {
    ContentView()
}
