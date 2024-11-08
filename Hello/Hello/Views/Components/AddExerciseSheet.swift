import SwiftUI

struct AddExerciseSheet: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var exerciseStore: ExerciseStore
    @State private var name = ""
    @State private var category: ExerciseCategory = .chest
    @State private var equipment = ""
    @State private var description = ""
    @State private var steps: [String] = [""]
    @State private var tips: [String] = [""]
    @State private var selectedMuscles: Set<MuscleGroup> = []
    @State private var difficulty: Exercise.Difficulty = .beginner
    
    var body: some View {
        NavigationStack {
            Form {
                // 基本信息
                Section("基本信息") {
                    TextField("动作名称", text: $name)
                    
                    Picker("动作类别", selection: $category) {
                        ForEach(ExerciseCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    
                    TextField("所需器械", text: $equipment)
                    
                    Picker("难度等级", selection: $difficulty) {
                        Text("初级").tag(Exercise.Difficulty.beginner)
                        Text("中级").tag(Exercise.Difficulty.intermediate)
                        Text("高级").tag(Exercise.Difficulty.advanced)
                    }
                }
                
                // 动作描述
                Section("动作描述") {
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
                
                // 目标肌肉群
                Section("目标肌肉") {
                    ForEach(MuscleGroup.allCases, id: \.self) { muscle in
                        Toggle(muscle.rawValue, isOn: Binding(
                            get: { selectedMuscles.contains(muscle) },
                            set: { isSelected in
                                if isSelected {
                                    selectedMuscles.insert(muscle)
                                } else {
                                    selectedMuscles.remove(muscle)
                                }
                            }
                        ))
                    }
                }
                
                // 执行步骤
                Section("执行步骤") {
                    ForEach(steps.indices, id: \.self) { index in
                        HStack {
                            TextField("步骤\(index + 1)", text: $steps[index])
                            if steps.count > 1 {
                                Button(action: { steps.remove(at: index) }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    Button("添加步骤") {
                        steps.append("")
                    }
                }
                
                // 注意事项
                Section("注意事项") {
                    ForEach(tips.indices, id: \.self) { index in
                        HStack {
                            TextField("注意事项\(index + 1)", text: $tips[index])
                            if tips.count > 1 {
                                Button(action: { tips.remove(at: index) }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    Button("添加注意事项") {
                        tips.append("")
                    }
                }
                
                // 保存按钮
                Section {
                    Button("保存动作") {
                        saveExercise()
                    }
                    .disabled(!isValidInput)
                }
            }
            .navigationTitle("添加动作")
            .navigationBarItems(leading: Button("取消") { dismiss() })
        }
    }
    
    private var isValidInput: Bool {
        !name.isEmpty &&
        !equipment.isEmpty &&
        !description.isEmpty &&
        !steps.contains(where: { $0.isEmpty }) &&
        !tips.contains(where: { $0.isEmpty }) &&
        !selectedMuscles.isEmpty
    }
    
    private func saveExercise() {
        let newExercise = Exercise(
            id: UUID(),
            name: name,
            category: category,
            equipment: equipment,
            description: description,
            steps: steps.filter { !$0.isEmpty },
            tips: tips.filter { !$0.isEmpty },
            targetMuscles: Array(selectedMuscles),
            videoURL: nil,
            images: [],
            difficulty: difficulty
        )
        
        exerciseStore.addExercise(newExercise)
        dismiss()
    }
}

#Preview {
    AddExerciseSheet(exerciseStore: ExerciseStore())
} 