import SwiftUI

struct AddToTemplateSheet: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var workoutStore: WorkoutStore
    let exercise: Exercise
    
    @State private var sets = ""
    @State private var reps = ""
    @State private var weight = ""
    @State private var notes = ""
    @State private var selectedTemplate: WorkoutTemplate?
    @State private var showingNewTemplateSheet = false
    
    var body: some View {
        NavigationStack {
            TemplateForm(
                sets: $sets,
                reps: $reps,
                weight: $weight,
                notes: $notes,
                selectedTemplate: $selectedTemplate,
                showingNewTemplateSheet: $showingNewTemplateSheet,
                workoutStore: workoutStore,
                isValidInput: isValidInput,
                saveAction: saveToTemplate
            )
            .navigationTitle("添加到训练模板")
            .navigationBarItems(leading: Button("取消") { dismiss() })
            .sheet(isPresented: $showingNewTemplateSheet) {
                CreateTemplateSheet(workoutStore: workoutStore)
            }
        }
    }
    
    private var isValidInput: Bool {
        guard let setsInt = Int(sets),
              let repsInt = Int(reps),
              let weightDouble = Double(weight)
        else { return false }
        return setsInt > 0 && repsInt > 0 && weightDouble > 0
    }
    
    private func saveToTemplate() {
        guard let template = selectedTemplate,
              let setsInt = Int(sets),
              let repsInt = Int(reps),
              let weightDouble = Double(weight)
        else { return }
        
        let templateExercise = TemplateExercise(
            id: UUID(),
            exerciseId: exercise.id,
            sets: setsInt,
            reps: repsInt,
            weight: weightDouble,
            notes: notes.isEmpty ? nil : notes
        )
        
        if let index = workoutStore.templates.firstIndex(where: { $0.id == template.id }) {
            var updatedTemplate = template
            updatedTemplate.exercises.append(templateExercise)
            workoutStore.templates[index] = updatedTemplate
            workoutStore.saveData()
        }
        
        dismiss()
    }
}

private struct TemplateForm: View {
    @Binding var sets: String
    @Binding var reps: String
    @Binding var weight: String
    @Binding var notes: String
    @Binding var selectedTemplate: WorkoutTemplate?
    @Binding var showingNewTemplateSheet: Bool
    let workoutStore: WorkoutStore
    let isValidInput: Bool
    let saveAction: () -> Void
    
    var body: some View {
        Form {
            TemplateSelectionSection(
                selectedTemplate: $selectedTemplate,
                showingNewTemplateSheet: $showingNewTemplateSheet,
                workoutStore: workoutStore
            )
            
            ExerciseParametersSection(
                sets: $sets,
                reps: $reps,
                weight: $weight,
                notes: $notes
            )
            
            VStack {
                Button(action: saveAction) {
                    Text("添加到模板")
                        .frame(maxWidth: .infinity)
                }
                .disabled(!isValidInput || selectedTemplate == nil)
            }
        }
    }
}

private struct TemplateSelectionSection: View {
    @Binding var selectedTemplate: WorkoutTemplate?
    @Binding var showingNewTemplateSheet: Bool
    let workoutStore: WorkoutStore
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("选择模板")
                .font(.headline)
                .padding(.bottom, 8)
            
            if workoutStore.templates.isEmpty {
                Text("暂无训练模板")
                    .foregroundColor(.gray)
            } else {
                Picker("训练模板", selection: $selectedTemplate) {
                    ForEach(workoutStore.templates) { template in
                        Text(template.name).tag(Optional(template))
                    }
                }
            }
            
            Button("创建新模板") {
                showingNewTemplateSheet = true
            }
        }
        .padding(.vertical, 8)
    }
}

private struct ExerciseParametersSection: View {
    @Binding var sets: String
    @Binding var reps: String
    @Binding var weight: String
    @Binding var notes: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("训练参数")
                .font(.headline)
                .padding(.bottom, 8)
            
            TextField("组数", text: $sets)
                .keyboardType(.numberPad)
            TextField("每组次数", text: $reps)
                .keyboardType(.numberPad)
            TextField("重量(kg)", text: $weight)
                .keyboardType(.decimalPad)
            TextEditor(text: $notes)
                .frame(height: 100)
        }
        .padding(.vertical, 8)
    }
}

struct CreateTemplateSheet: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var workoutStore: WorkoutStore
    @State private var templateName = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("模板名称", text: $templateName)
                
                Button("创建模板") {
                    createTemplate()
                }
                .disabled(templateName.isEmpty)
            }
            .navigationTitle("创建新模板")
            .navigationBarItems(leading: Button("取消") { dismiss() })
        }
    }
    
    private func createTemplate() {
        let newTemplate = WorkoutTemplate(
            id: UUID(),
            name: templateName,
            exercises: []
        )
        workoutStore.templates.append(newTemplate)
        workoutStore.saveData()
        dismiss()
    }
} 