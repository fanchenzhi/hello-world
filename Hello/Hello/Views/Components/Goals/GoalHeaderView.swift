import SwiftUI

struct GoalHeaderView: View {
    let goal: WorkoutGoal
    let progress: Int
    
    private var progressColor: Color {
        let ratio = Double(progress) / Double(goal.targetFrequency)
        if ratio >= 1.0 {
            return .green
        } else if ratio >= 0.6 {
            return .yellow
        } else {
            return .red
        }
    }
    
    var body: some View {
        HStack {
            Text(goal.type.rawValue)
                .font(.headline)
            Spacer()
            Text("\(progress)/\(goal.targetFrequency)次")
                .foregroundColor(progressColor)
        }
    }
} 