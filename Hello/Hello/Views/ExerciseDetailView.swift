import SwiftUI

struct ExerciseDetailView: View {
    @ObservedObject var workoutStore: WorkoutStore
    let exercise: Exercise
    @State private var selectedImageIndex = 0
    @State private var showingAddToTemplate = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 图片轮播
                TabView(selection: $selectedImageIndex) {
                    ForEach(exercise.images.indices, id: \.self) { index in
                        AsyncImage(url: exercise.images[index].url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .tag(index)
                    }
                }
                .frame(height: 250)
                .tabViewStyle(PageTabViewStyle())
                
                // 图片类型指示器
                if !exercise.images.isEmpty {
                    Text(exercise.images[selectedImageIndex].type.rawValue)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                // 视频播放器（如果有）
                if let videoURL = exercise.videoURL {
                    ExerciseVideoPlayer(videoURL: videoURL)
                }
                
                // 动作信息
                VStack(alignment: .leading, spacing: 16) {
                    // 目标肌肉群
                    Section(header: SectionHeader(title: "目标肌肉")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(exercise.targetMuscles, id: \.self) { muscle in
                                    Text(muscle.rawValue)
                                        .font(.subheadline)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(15)
                                }
                            }
                        }
                    }
                    
                    // 动作描述
                    Section(header: SectionHeader(title: "动作描述")) {
                        Text(exercise.description)
                            .font(.body)
                    }
                    
                    // 动作步骤
                    Section(header: SectionHeader(title: "执行步骤")) {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(Array(exercise.steps.enumerated()), id: \.offset) { index, step in
                                HStack(alignment: .top) {
                                    Text("\(index + 1).")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                    Text(step)
                                        .font(.body)
                                }
                            }
                        }
                    }
                    
                    // 注意事项
                    Section(header: SectionHeader(title: "注意事项")) {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(exercise.tips, id: \.self) { tip in
                                HStack(alignment: .top) {
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .foregroundColor(.orange)
                                    Text(tip)
                                        .font(.body)
                                }
                            }
                        }
                    }
                    
                    // 视频教学（如果有）
                    if let videoURL = exercise.videoURL {
                        Section(header: SectionHeader(title: "视频教学")) {
                            Link(destination: videoURL) {
                                HStack {
                                    Image(systemName: "play.circle.fill")
                                        .foregroundColor(.blue)
                                    Text("观看教学视频")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(exercise.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddToTemplate = true }) {
                    Image(systemName: "plus.circle")
                }
            }
        }
        .sheet(isPresented: $showingAddToTemplate) {
            AddToTemplateSheet(workoutStore: workoutStore, exercise: exercise)
        }
    }
}

// 自定义 Section 标题样式
struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.primary)
            .padding(.vertical, 8)
    }
}

// 预览
#Preview {
    NavigationStack {
        ExerciseDetailView(
            workoutStore: WorkoutStore(),
            exercise: Exercise(
                id: UUID(),
                name: "杠铃卧推",
                category: .chest,
                equipment: "杠铃",
                description: "杠铃卧推是一个经典的胸部训练动作，可以有效锻炼胸大肌、三头肌和前束三角肌。",
                steps: [
                    "躺在卧推凳上，双脚平稳踏地",
                    "握住杠铃，手臂略宽于肩",
                    "控制杠铃缓慢下降至胸部",
                    "推起杠铃至起始位置",
                    "重复动作"
                ],
                tips: [
                    "保持手肘与身体呈45度角",
                    "下降时保持肩胛骨收紧",
                    "呼吸节奏：下降吸气，推起呼气",
                    "注意颈部保持中立位置"
                ],
                targetMuscles: [.pectoralis, .triceps, .deltoids],
                videoURL: nil,
                images: [],
                difficulty: .intermediate
            )
        )
    }
} 