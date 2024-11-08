import SwiftUI

struct ExerciseGridView: View {
    let exercises: [Exercise]
    let workoutStore: WorkoutStore
    
    var body: some View {
        if exercises.isEmpty {
            ContentUnavailableView(
                "未找到相关动作",
                systemImage: "magnifyingglass",
                description: Text("请尝试其他搜索条件")
            )
        } else {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(exercises) { exercise in
                        ExerciseCard(
                            exercise: exercise,
                            workoutStore: workoutStore
                        )
                    }
                }
                .padding()
            }
        }
    }
} 