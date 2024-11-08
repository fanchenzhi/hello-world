import SwiftUI

struct GoalProgressView: View {
    let progress: Int
    let target: Int
    
    private var progressColor: Color {
        let ratio = Double(progress) / Double(target)
        if ratio >= 1.0 {
            return .green
        } else if ratio >= 0.6 {
            return .yellow
        } else {
            return .red
        }
    }
    
    var body: some View {
        ProgressView(value: Double(progress), total: Double(target))
            .tint(progressColor)
    }
} 