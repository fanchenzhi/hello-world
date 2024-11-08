import SwiftUI

struct ExerciseCard: View {
    let exercise: Exercise
    let workoutStore: WorkoutStore
    @State private var isPressed = false
    @State private var isHovered = false
    @Namespace private var animation
    
    var body: some View {
        NavigationLink(destination: ExerciseDetailView(workoutStore: workoutStore, exercise: exercise)) {
            VStack(alignment: .leading, spacing: 0) {
                // 动作图片
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "figure.strengthtraining.traditional")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 140)
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .matchedGeometryEffect(id: "image\(exercise.id)", in: animation)
                        .scaleEffect(isHovered ? 1.05 : 1.0)
                    
                    // 难度标签
                    DifficultyBadge(difficulty: exercise.difficulty)
                        .padding(8)
                        .transition(.scale.combined(with: .opacity))
                }
                
                // 动作信息
                VStack(alignment: .leading, spacing: 8) {
                    // 动作名称和器械
                    HStack {
                        Text(exercise.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .matchedGeometryEffect(id: "title\(exercise.id)", in: animation)
                        Spacer()
                        EquipmentBadge(equipment: exercise.equipment)
                            .scaleEffect(isHovered ? 1.1 : 1.0)
                    }
                    
                    // 目标肌肉群
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 4) {
                            ForEach(exercise.targetMuscles, id: \.self) { muscle in
                                MuscleBadge(muscle: muscle)
                                    .transition(.slide)
                            }
                        }
                    }
                }
                .padding(12)
                .background(Color(.systemBackground))
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(
                color: isHovered ? .black.opacity(0.15) : .black.opacity(0.1),
                radius: isHovered ? 8 : 4,
                x: 0,
                y: isHovered ? 4 : 2
            )
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
            .animation(.easeInOut(duration: 0.2), value: isHovered)
            .onTapGesture {
                withAnimation {
                    isPressed = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isPressed = false
                    }
                }
            }
            .onHover { hovering in
                withAnimation {
                    isHovered = hovering
                }
            }
        }
    }
}

// 难度标签
struct DifficultyBadge: View {
    let difficulty: Exercise.Difficulty
    @State private var isAnimating = false
    
    var color: Color {
        switch difficulty {
        case .beginner:
            return .green
        case .intermediate:
            return .orange
        case .advanced:
            return .red
        }
    }
    
    var body: some View {
        Text(difficulty.rawValue)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color)
            .cornerRadius(4)
            .scaleEffect(isAnimating ? 1.1 : 1.0)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                    isAnimating = true
                }
            }
    }
}

// 器械标签
struct EquipmentBadge: View {
    let equipment: String
    @State private var isAnimating = false
    
    var body: some View {
        Text(equipment)
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(.systemGray6))
            .cornerRadius(4)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                    .opacity(isAnimating ? 0.5 : 1.0)
            )
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                    isAnimating = true
                }
            }
    }
}

// 肌肉群标签
struct MuscleBadge: View {
    let muscle: MuscleGroup
    @State private var isAnimating = false
    
    var body: some View {
        Text(muscle.rawValue)
            .font(.caption)
            .foregroundColor(.blue)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                Color.blue.opacity(0.1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.blue.opacity(0.2), lineWidth: 1)
                            .scaleEffect(isAnimating ? 1.1 : 1.0)
                            .opacity(isAnimating ? 0.5 : 1.0)
                    )
            )
            .cornerRadius(4)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    isAnimating = true
                }
            }
    }
}

#Preview {
    ExerciseCard(
        exercise: Exercise(
            id: UUID(),
            name: "杠铃卧推",
            category: .chest,
            equipment: "杠铃",
            description: "基础胸部训练动作",
            steps: [],
            tips: [],
            targetMuscles: [.pectoralis, .triceps],
            videoURL: nil,
            images: [],
            difficulty: .intermediate
        ),
        workoutStore: WorkoutStore()
    )
    .padding()
} 