import SwiftUI

struct GoalsView: View {
    @ObservedObject var workoutStore: WorkoutStore
    @State private var showingAddGoal = false
    
    var body: some View {
        NavigationStack {
            GoalsList(workoutStore: workoutStore)
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