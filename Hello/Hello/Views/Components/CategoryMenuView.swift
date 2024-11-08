import SwiftUI

struct CategoryMenuView: View {
    let categories: [String: [String]]
    @Binding var selectedCategory: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(Array(categories.keys.sorted()), id: \.self) { category in
                    Text(category)
                        .foregroundColor(selectedCategory == category ? .blue : .primary)
                        .onTapGesture {
                            selectedCategory = selectedCategory == category ? nil : category
                        }
                }
            }
            .padding()
        }
        .frame(width: 100)
        .background(Color(.systemGray6))
    }
} 