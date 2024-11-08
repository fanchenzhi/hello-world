import Foundation

// 训练模板
struct WorkoutTemplate: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var exercises: [TemplateExercise]
    var notes: String?
    
    // 实现 Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // 实现 Equatable
    static func == (lhs: WorkoutTemplate, rhs: WorkoutTemplate) -> Bool {
        lhs.id == rhs.id
    }
}

// 模板中的训练动作
struct TemplateExercise: Identifiable, Codable, Hashable {
    let id: UUID
    let exerciseId: UUID  // 关联到 Exercise
    var sets: Int        // 组数
    var reps: Int        // 每组次数
    var weight: Double   // 重量（公斤）
    var notes: String?   // 备注
    
    // 实现 Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // 实现 Equatable
    static func == (lhs: TemplateExercise, rhs: TemplateExercise) -> Bool {
        lhs.id == rhs.id
    }
} 