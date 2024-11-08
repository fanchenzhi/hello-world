import SwiftUI

struct GoalRowView: View {
    let goal: WorkoutGoal
    @ObservedObject var workoutStore: WorkoutStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            GoalHeaderView(goal: goal, progress: weeklyProgress)
            GoalDurationView(duration: goal.targetDuration)
            GoalProgressView(progress: weeklyProgress, target: goal.targetFrequency)
        }
        .padding(.vertical, 4)
    }
    
    private var weeklyProgress: Int {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        
        return workoutStore.workoutRecords.filter { record in
            record.type == goal.type &&
            calendar.isDate(record.date, equalTo: startOfWeek, toGranularity: .weekOfYear)
        }.count
    }
} 