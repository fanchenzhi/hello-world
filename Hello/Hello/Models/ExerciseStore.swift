import Foundation

class ExerciseStore: ObservableObject {
    @Published var exercises: [Exercise]
    private let exercisesKey = "customExercises"
    
    init() {
        // 加载自定义动作
        if let data = UserDefaults.standard.data(forKey: exercisesKey),
           let decoded = try? JSONDecoder().decode([Exercise].self, from: data) {
            self.exercises = decoded + allExercises // 合并自定义动作和预设动作
        } else {
            self.exercises = allExercises // 只使用预设动作
        }
    }
    
    // 添加新动作
    func addExercise(_ exercise: Exercise) {
        exercises.append(exercise)
        saveCustomExercises()
    }
    
    // 删除动作
    func deleteExercise(_ exercise: Exercise) {
        // 只能删除自定义动作，不能删除预设动作
        if !allExercises.contains(where: { $0.id == exercise.id }) {
            exercises.removeAll { $0.id == exercise.id }
            saveCustomExercises()
        }
    }
    
    // 更新动作
    func updateExercise(_ exercise: Exercise) {
        if let index = exercises.firstIndex(where: { $0.id == exercise.id }) {
            exercises[index] = exercise
            saveCustomExercises()
        }
    }
    
    // 保存自定义动作
    private func saveCustomExercises() {
        // 只保存自定义动作，不保存预设动作
        let customExercises = exercises.filter { exercise in
            !allExercises.contains(where: { $0.id == exercise.id })
        }
        
        if let encoded = try? JSONEncoder().encode(customExercises) {
            UserDefaults.standard.set(encoded, forKey: exercisesKey)
        }
    }
    
    // 获取特定类别的动作
    func exercises(for category: String?) -> [Exercise] {
        guard let category = category else { return exercises }
        return exercises.filter { $0.category.rawValue == category }
    }
    
    // 获取使用特定器械的动作
    func exercises(withEquipment equipment: String?) -> [Exercise] {
        guard let equipment = equipment else { return exercises }
        return exercises.filter { $0.equipment == equipment }
    }
    
    // 搜索动作
    func searchExercises(_ query: String) -> [Exercise] {
        guard !query.isEmpty else { return exercises }
        return exercises.filter { exercise in
            exercise.name.localizedCaseInsensitiveContains(query) ||
            exercise.description.localizedCaseInsensitiveContains(query)
        }
    }
} 