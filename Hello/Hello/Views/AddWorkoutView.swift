import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var workoutStore: WorkoutStore
    
    @State private var selectedType: WorkoutType = .running
    @State private var duration = ""
    @State private var calories = ""
    @State private var notes = ""
    
    // 用于显示运动强度建议
    private var suggestedCalories: String {
        guard let duration = Int(duration) else { return "" }
        
        let estimatedCalories: Int
        switch selectedType {
        case .running:
            estimatedCalories = duration * 10  // 约10卡/分钟
        case .cycling:
            estimatedCalories = duration * 7   // 约7卡/分钟
        case .swimming:
            estimatedCalories = duration * 8   // 约8卡/分钟
        case .yoga:
            estimatedCalories = duration * 4   // 约4卡/分钟
        case .weightTraining:
            estimatedCalories = duration * 6   // 约6卡/分钟
        case .walking:
            estimatedCalories = duration * 5   // 约5卡/分钟
        }
        
        return "建议值: 约\(estimatedCalories)千卡"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("运动信息") {
                    Picker("运动类型", selection: $selectedType) {
                        ForEach(WorkoutType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    
                    TextField("运动时长（分钟）", text: $duration)
                        .keyboardType(.numberPad)
                }
                
                Section("消耗卡路里") {
                    TextField("消耗卡路里", text: $calories)
                        .keyboardType(.numberPad)
                    
                    if !duration.isEmpty {
                        Text(suggestedCalories)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Section("备注（可选）") {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
                
                Section {
                    Button(action: saveWorkout) {
                        Text("保存记录")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                    }
                    .listRowBackground(isValidInput ? Color.blue : Color.gray)
                    .disabled(!isValidInput)
                }
            }
            .navigationTitle("添加运动记录")
            .navigationBarItems(
                leading: Button("取消") {
                    dismiss()
                }
            )
        }
    }
    
    private var isValidInput: Bool {
        guard let durationInt = Int(duration),
              let caloriesInt = Int(calories) else {
            return false
        }
        return durationInt > 0 && caloriesInt > 0
    }
    
    private func saveWorkout() {
        guard let durationInt = Int(duration),
              let caloriesInt = Int(calories) else {
            return
        }
        
        let newRecord = WorkoutRecord(
            id: UUID(),
            type: selectedType,
            duration: durationInt,
            date: Date(),
            calories: caloriesInt,
            notes: notes.isEmpty ? nil : notes
        )
        
        workoutStore.workoutRecords.append(newRecord)
        workoutStore.saveData()
        dismiss()
    }
}

#Preview {
    AddWorkoutView(workoutStore: WorkoutStore())
} 