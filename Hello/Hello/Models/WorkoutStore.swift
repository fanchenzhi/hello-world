import Foundation

class WorkoutStore: ObservableObject {
    @Published var workoutRecords: [WorkoutRecord] = []
    @Published var workoutGoals: [WorkoutGoal] = []
    @Published var templates: [WorkoutTemplate] = []
    
    private let recordsKey = "workoutRecords"
    private let goalsKey = "workoutGoals"
    private let templatesKey = "workoutTemplates"
    
    init() {
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: recordsKey),
           let records = try? JSONDecoder().decode([WorkoutRecord].self, from: data) {
            workoutRecords = records
        }
        
        if let data = UserDefaults.standard.data(forKey: goalsKey),
           let goals = try? JSONDecoder().decode([WorkoutGoal].self, from: data) {
            workoutGoals = goals
        }
        
        if let data = UserDefaults.standard.data(forKey: templatesKey),
           let templates = try? JSONDecoder().decode([WorkoutTemplate].self, from: data) {
            self.templates = templates
        }
    }
    
    func saveData() {
        if let encoded = try? JSONEncoder().encode(workoutRecords) {
            UserDefaults.standard.set(encoded, forKey: recordsKey)
        }
        
        if let encoded = try? JSONEncoder().encode(workoutGoals) {
            UserDefaults.standard.set(encoded, forKey: goalsKey)
        }
        
        if let encoded = try? JSONEncoder().encode(templates) {
            UserDefaults.standard.set(encoded, forKey: templatesKey)
        }
    }
    
    // MARK: - Records Management
    func addWorkoutRecord(_ record: WorkoutRecord) {
        workoutRecords.append(record)
        saveData()
    }
    
    func deleteWorkoutRecord(_ record: WorkoutRecord) {
        workoutRecords.removeAll { $0.id == record.id }
        saveData()
    }
    
    // MARK: - Goals Management
    func addWorkoutGoal(_ goal: WorkoutGoal) {
        workoutGoals.append(goal)
        saveData()
    }
    
    func deleteWorkoutGoal(_ goal: WorkoutGoal) {
        workoutGoals.removeAll { $0.id == goal.id }
        saveData()
    }
    
    // MARK: - Templates Management
    func addTemplate(_ template: WorkoutTemplate) {
        templates.append(template)
        saveData()
    }
    
    func updateTemplate(_ template: WorkoutTemplate) {
        if let index = templates.firstIndex(where: { $0.id == template.id }) {
            templates[index] = template
            saveData()
        }
    }
    
    func deleteTemplate(_ template: WorkoutTemplate) {
        templates.removeAll { $0.id == template.id }
        saveData()
    }
} 