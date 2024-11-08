import Foundation

struct WorkoutGoal: Identifiable, Codable {
    let id: UUID
    let type: WorkoutType
    let targetDuration: Int
    let targetFrequency: Int // 每周次数
} 