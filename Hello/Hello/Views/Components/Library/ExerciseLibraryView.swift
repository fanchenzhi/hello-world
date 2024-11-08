import SwiftUI

struct ExerciseLibraryView: View {
    @StateObject private var exerciseStore = ExerciseStore()
    @StateObject private var workoutStore = WorkoutStore()
    @State private var searchText = ""
    @State private var selectedCategory: String?
    @State private var selectedEquipment: String?
    @State private var showingAddExercise = false
    
    var body: some View {
        NavigationStack {
            LibraryContentView(
                exerciseStore: exerciseStore,
                workoutStore: workoutStore,
                searchText: $searchText,
                selectedCategory: $selectedCategory,
                selectedEquipment: $selectedEquipment,
                showingAddExercise: $showingAddExercise
            )
        }
    }
}

// 主内容视图
private struct LibraryContentView: View {
    @ObservedObject var exerciseStore: ExerciseStore
    @ObservedObject var workoutStore: WorkoutStore
    @Binding var searchText: String
    @Binding var selectedCategory: String?
    @Binding var selectedEquipment: String?
    @Binding var showingAddExercise: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            CategorySideBar(selectedCategory: $selectedCategory)
            
            MainContentView(
                exerciseStore: exerciseStore,
                workoutStore: workoutStore,
                searchText: $searchText,
                selectedEquipment: $selectedEquipment,
                filteredExercises: getFilteredExercises()
            )
        }
        .navigationTitle("动作库")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                AddButton(showingAddExercise: $showingAddExercise)
            }
        }
        .sheet(isPresented: $showingAddExercise) {
            AddExerciseSheet(exerciseStore: exerciseStore)
        }
    }
    
    private func getFilteredExercises() -> [Exercise] {
        var result = exerciseStore.exercises
        
        if !searchText.isEmpty {
            result = exerciseStore.searchExercises(searchText)
        }
        
        if let category = selectedCategory {
            result = result.filter { $0.category.rawValue == category }
        }
        
        if let equipment = selectedEquipment {
            result = result.filter { $0.equipment == equipment }
        }
        
        return result
    }
}

// 左侧分类栏
private struct CategorySideBar: View {
    @Binding var selectedCategory: String?
    
    private let categories = [
        "胸": ["上胸", "中下胸"],
        "背": ["背部"],
        "腿": ["腿部"],
        "肩": ["肩部"],
        "斜方肌": ["斜方肌"],
        "二头": ["二头"],
        "三头": ["三头"],
        "小腿": ["小腿"],
        "前臂": ["前臂"],
        "臀部": ["臀部"],
        "腹部": ["腹部"],
        "热身动作": ["热身动作"],
        "拉伸": ["拉伸"],
        "有氧": ["有氧"],
        "组合": ["组合"]
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(Array(categories.keys.sorted()), id: \.self) { category in
                    CategoryButton(
                        title: category,
                        isSelected: selectedCategory == category,
                        action: {
                            selectedCategory = selectedCategory == category ? nil : category
                        }
                    )
                }
            }
            .padding(.vertical, 16)
        }
        .frame(width: 100)
        .background(Color(.systemBackground))
        .overlay(
            Rectangle()
                .frame(width: 1)
                .foregroundColor(Color(.systemGray4)),
            alignment: .trailing
        )
    }
}

// 主内容区域
private struct MainContentView: View {
    let exerciseStore: ExerciseStore
    let workoutStore: WorkoutStore
    @Binding var searchText: String
    @Binding var selectedEquipment: String?
    let filteredExercises: [Exercise]
    
    private let equipmentTypes = ["常用", "杠铃", "哑铃", "绳索"]
    
    var body: some View {
        VStack(spacing: 0) {
            SearchField(text: $searchText)
                .padding()
            
            FilterBar(
                equipmentTypes: equipmentTypes,
                selectedEquipment: $selectedEquipment
            )
            
            ExerciseGrid(
                exercises: filteredExercises,
                workoutStore: workoutStore
            )
        }
    }
}

// 添加按钮
private struct AddButton: View {
    @Binding var showingAddExercise: Bool
    
    var body: some View {
        Button(action: { showingAddExercise = true }) {
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.blue)
                .font(.title2)
        }
    }
}

// 筛选栏
private struct FilterBar: View {
    let equipmentTypes: [String]
    @Binding var selectedEquipment: String?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(equipmentTypes, id: \.self) { type in
                    EquipmentFilterButton(
                        title: type,
                        isSelected: selectedEquipment == type,
                        action: {
                            selectedEquipment = selectedEquipment == type ? nil : type
                        }
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .background(Color(.systemBackground))
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.systemGray4)),
            alignment: .bottom
        )
    }
}

// 分类按钮
private struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .blue : .primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
        }
    }
}

// 搜索框
private struct SearchField: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("搜索动作", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// 器械筛选按钮
private struct EquipmentFilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(isSelected ? .white : .blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.clear)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.blue, lineWidth: 1)
                )
        }
    }
}

// 动作网格视图
private struct ExerciseGrid: View {
    let exercises: [Exercise]
    let workoutStore: WorkoutStore
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            if exercises.isEmpty {
                ContentUnavailableView(
                    "未找到相关动作",
                    systemImage: "magnifyingglass",
                    description: Text("请尝试其他搜索条件")
                )
                .padding(.top, 40)
            } else {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(exercises) { exercise in
                        ExerciseCard(
                            exercise: exercise,
                            workoutStore: workoutStore
                        )
                    }
                }
                .padding(16)
            }
        }
    }
}

#Preview {
    ExerciseLibraryView()
} 