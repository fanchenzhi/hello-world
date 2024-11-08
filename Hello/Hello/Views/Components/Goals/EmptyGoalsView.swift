import SwiftUI

struct EmptyGoalsView: View {
    var body: some View {
        ContentUnavailableView(
            "暂无运动目标",
            systemImage: "target",
            description: Text("点击右上角添加新的运动目标")
        )
    }
} 