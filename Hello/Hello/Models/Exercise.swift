import Foundation

// 训练动作模型
struct Exercise: Identifiable, Codable {
    let id: UUID
    let name: String
    let category: ExerciseCategory
    let equipment: String  // 新增器械属性
    let description: String
    let steps: [String]  // 动作步骤
    let tips: [String]   // 注意事项
    let targetMuscles: [MuscleGroup] // 目标肌肉群
    var videoURL: URL?   // 示范视频链接（可选）
    var images: [ExerciseImage]  // 新增
    var difficulty: Difficulty  // 新增难度属性
    
    enum Difficulty: String, Codable {
        case beginner = "初级"
        case intermediate = "中级"
        case advanced = "高级"
    }
}

struct ExerciseImage: Codable {
    let id: UUID
    let url: URL
    let type: ImageType
    
    enum ImageType: String, Codable {
        case start = "起始姿势"
        case middle = "中间过程"
        case end = "结束姿势"
        case detail = "细节图"
    }
}

// 训练动作分类
enum ExerciseCategory: String, CaseIterable, Codable {
    case chest = "胸部"
    case back = "背部"
    case shoulders = "肩部"
    case arms = "手臂"
    case legs = "腿部"
    case core = "核心"
}

// 肌肉群
enum MuscleGroup: String, CaseIterable, Codable {
    case pectoralis = "胸大肌"
    case latissimus = "背阔肌"
    case deltoids = "三角肌"
    case biceps = "二头肌"
    case triceps = "三头肌"
    case quadriceps = "股四头肌"
    case hamstrings = "腘绳肌"
    case abdominals = "腹肌"
    // ... 可以添加更多肌肉群
} 