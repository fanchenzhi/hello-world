import SwiftUI

struct GoalsList: View {
    @ObservedObject var workoutStore: WorkoutStore
    
    var body: some View {
        List {
            if workoutStore.workoutGoals.isEmpty {
                EmptyGoalsView()
            } else {
                ForEach(workoutStore.workoutGoals) { goal in
                    GoalRowView(goal: goal, workoutStore: workoutStore)
                }
            }
        }
    }
} 