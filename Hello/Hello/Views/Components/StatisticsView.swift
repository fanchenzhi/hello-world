import SwiftUI
import Charts

struct StatisticsView: View {
    @ObservedObject var workoutStore: WorkoutStore
    
    var body: some View {
        NavigationStack {
            List {
                WeeklyStatsSection(workoutStore: workoutStore)
                WorkoutDistributionSection(workoutStore: workoutStore)
            }
            .navigationTitle("统计")
        }
    }
}

private struct WeeklyStatsSection: View {
    @ObservedObject var workoutStore: WorkoutStore
    
    private var thisWeekRecords: [WorkoutRecord] {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        return workoutStore.workoutRecords.filter { record in
            calendar.isDate(record.date, equalTo: startOfWeek, toGranularity: .weekOfYear)
        }
    }
    
    private var chartData: [ChartData] {
        thisWeekRecords.map { record in
            ChartData(date: record.date, duration: record.duration, type: record.type.rawValue)
        }
    }
    
    var body: some View {
        Section("本周运动统计") {
            if chartData.isEmpty {
                Text("本周暂无运动记录")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                Chart {
                    ForEach(chartData) { data in
                        BarMark(
                            x: .value("日期", data.date, unit: .day),
                            y: .value("时长", data.duration)
                        )
                        .foregroundStyle(by: .value("类型", data.type))
                    }
                }
                .frame(height: 200)
            }
        }
    }
}

private struct WorkoutDistributionSection: View {
    @ObservedObject var workoutStore: WorkoutStore
    
    private var workoutTypeDistribution: [WorkoutTypeCount] {
        var distribution: [WorkoutType: Int] = [:]
        for record in workoutStore.workoutRecords {
            distribution[record.type, default: 0] += 1
        }
        return distribution.map { WorkoutTypeCount(type: $0.key, count: $0.value) }
            .sorted { $0.count > $1.count }
    }
    
    var body: some View {
        Section("运动类型分布") {
            if workoutTypeDistribution.isEmpty {
                Text("暂无运动记录")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                Chart {
                    ForEach(workoutTypeDistribution) { item in
                        SectorMark(
                            angle: .value("数量", Double(item.count))
                        )
                        .foregroundStyle(by: .value("类型", item.type.rawValue))
                    }
                }
                .frame(height: 200)
                
                ForEach(workoutTypeDistribution) { item in
                    HStack {
                        Text(item.type.rawValue)
                        Spacer()
                        Text("\(item.count)次")
                    }
                }
            }
        }
    }
}

private struct ChartData: Identifiable {
    let id = UUID()
    let date: Date
    let duration: Int
    let type: String
}

private struct WorkoutTypeCount: Identifiable {
    let id = UUID()
    let type: WorkoutType
    let count: Int
} 