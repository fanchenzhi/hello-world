import SwiftUI

struct RecordsView: View {
    @ObservedObject var workoutStore: WorkoutStore
    @State private var showingAddWorkout = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(workoutStore.workoutRecords.sorted(by: { $0.date > $1.date })) { record in
                    NavigationLink(destination: WorkoutDetailView(record: record)) {
                        WorkoutRowView(record: record)
                    }
                }
            }
            .navigationTitle("健身记录")
            .toolbar {
                Button(action: { showingAddWorkout = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddWorkout) {
                AddWorkoutView(workoutStore: workoutStore)
            }
        }
    }
}

struct WorkoutRowView: View {
    let record: WorkoutRecord
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: record.date)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(record.type.rawValue)
                .font(.headline)
            HStack {
                Text("时长: \(record.duration)分钟")
                Text("卡路里: \(record.calories)")
                Spacer()
                Text(formattedDate)
                    .foregroundColor(.gray)
            }
            .font(.subheadline)
        }
        .padding(.vertical, 4)
    }
} 