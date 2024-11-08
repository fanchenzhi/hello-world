import Foundation

struct WorkoutRecord: Identifiable, Codable {
    let id: UUID
    let type: WorkoutType
    let duration: Int
    let date: Date
    let calories: Int
    var notes: String?
} 