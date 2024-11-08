import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var workoutStore: WorkoutStore
    
    @State private var selectedType: WorkoutType = .running
    @State private var duration = ""
    @State private var calories = ""
    @State private var notes = ""
    @State private var isAutoCalculate = true
    
    private var suggestedCalories: Int {
        guard let durationInt = Int(duration) else { return 0 }
        return Int(Double(durationInt) * selectedType.caloriesPerMinute)
    }
    
    private func updateCalories() {
        if isAutoCalculate {
            calories = String(suggestedCalories)
        }
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
                    .onChange(of: selectedType) { _, _ in
                        updateCalories()
                    }
                    
                    TextField("运动时长（分钟）", text: $duration)
                        .keyboardType(.numberPad)
                        .onChange(of: duration) { _, _ in
                            updateCalories()
                        }
                }
                
                Section("消耗卡路里") {
                    Toggle("自动计算卡路里", isOn: $isAutoCalculate)
                        .onChange(of: isAutoCalculate) { _, newValue in
                            if newValue {
                                updateCalories()
                            }
                        }
                    
                    TextField("消耗卡路里", text: $calories)
                        .keyboardType(.numberPad)
                        .disabled(isAutoCalculate)
                    
                    if !duration.isEmpty {
                        Text("基于\(selectedType.rawValue)的平均消耗：\(suggestedCalories) 千卡")
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