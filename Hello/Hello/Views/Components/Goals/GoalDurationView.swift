import SwiftUI

struct GoalDurationView: View {
    let duration: Int
    
    var body: some View {
        Text("每次目标时长：\(duration)分钟")
            .font(.subheadline)
            .foregroundColor(.gray)
    }
} 