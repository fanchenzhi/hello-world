import Foundation

enum WorkoutType: String, CaseIterable, Codable {
    case running = "跑步"
    case cycling = "骑行"
    case swimming = "游泳"
    case yoga = "瑜伽"
    case weightTraining = "力量训练"
    case walking = "步行"
    
    var caloriesPerMinute: Double {
        switch self {
        case .running:
            return 10.0  // 跑步消耗最大
        case .cycling:
            return 7.0   // 骑行中等消耗
        case .swimming:
            return 8.0   // 游泳消耗较大
        case .yoga:
            return 4.0   // 瑜伽消耗较小
        case .weightTraining:
            return 6.0   // 力量训练中等消耗
        case .walking:
            return 5.0   // 步行消耗较小
        }
    }
} 