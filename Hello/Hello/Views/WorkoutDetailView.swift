import SwiftUI

struct WorkoutDetailView: View {
    let record: WorkoutRecord
    
    var body: some View {
        List {
            Section("基本信息") {
                LabeledContent("运动类型", value: record.type.rawValue)
                LabeledContent("运动时长", value: "\(record.duration) 分钟")
                LabeledContent("消耗卡路里", value: "\(record.calories) 千卡")
                LabeledContent("记录时间", value: record.date.formatted(date: .long, time: .shortened))
            }
            
            if let notes = record.notes {
                Section("备注") {
                    Text(notes)
                }
            }
            
            Section("运动强度") {
                // 根据时长和卡路里计算强度
                let intensity = Double(record.calories) / Double(record.duration)
                HStack {
                    Text("平均每分钟消耗")
                    Spacer()
                    Text(String(format: "%.1f 千卡", intensity))
                }
                
                // 运动强度评级
                HStack {
                    Text("强度评级")
                    Spacer()
                    IntensityRatingView(intensity: intensity)
                }
            }
        }
        .navigationTitle("运动详情")
    }
}

struct IntensityRatingView: View {
    let intensity: Double
    
    var ratingText: String {
        switch intensity {
        case ..<3:
            return "低强度"
        case 3..<6:
            return "中等强度"
        default:
            return "高强度"
        }
    }
    
    var ratingColor: Color {
        switch intensity {
        case ..<3:
            return .green
        case 3..<6:
            return .orange
        default:
            return .red
        }
    }
    
    var body: some View {
        Text(ratingText)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(ratingColor)
            .cornerRadius(4)
    }
} 