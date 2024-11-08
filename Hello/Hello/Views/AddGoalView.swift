import SwiftUI

struct AddGoalView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var workoutStore: WorkoutStore
    
    @State private var selectedType: WorkoutType = .running
    @State private var targetDuration = ""
    @State private var targetFrequency = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("运动类型") {
                    Picker("选择运动类型", selection: $selectedType) {
                        ForEach(WorkoutType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                }
                
                Section("目标设置") {
                    TextField("每次运动时长（分钟）", text: $targetDuration)
                        .keyboardType(.numberPad)
                    
                    TextField("每周运动次数", text: $targetFrequency)
                        .keyboardType(.numberPad)
                }
                
                Section("每周总目标") {
                    if let duration = Int(targetDuration),
                       let frequency = Int(targetFrequency) {
                        let weeklyTotal = duration * frequency
                        Text("每周总运动时长：\(weeklyTotal) 分钟")
                        
                        // 根据WHO建议显示达标状态
                        let isRecommended = weeklyTotal >= 150
                        HStack {
                            Text("WHO建议达标状态：")
                            if isRecommended {
                                Text("已达标")
                                    .foregroundColor(.green)
                            } else {
                                Text("未达标")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            .navigationTitle("添加运动目标")
            .navigationBarItems(
                leading: Button("取消") {
                    dismiss()
                },
                trailing: Button("保存") {
                    saveGoal()
                }
                .disabled(!isValidInput)
            )
        }
    }
    
    private var isValidInput: Bool {
        guard let duration = Int(targetDuration),
              let frequency = Int(targetFrequency) else {
            return false
        }
        return duration > 0 && frequency > 0
    }
    
    private func saveGoal() {
        guard let duration = Int(targetDuration),
              let frequency = Int(targetFrequency) else {
            return
        }
        
        let newGoal = WorkoutGoal(
            id: UUID(),
            type: selectedType,
            targetDuration: duration,
            targetFrequency: frequency
        )
        
        workoutStore.workoutGoals.append(newGoal)
        workoutStore.saveData()
        dismiss()
    }
} 