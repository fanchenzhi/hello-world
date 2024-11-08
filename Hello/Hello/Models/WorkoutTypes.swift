import Foundation

enum WorkoutType: String, CaseIterable, Codable {
    case running = "跑步"
    case cycling = "骑行"
    case swimming = "游泳"
    case yoga = "瑜伽"
    case weightTraining = "力量训练"
    case walking = "步行"
} 