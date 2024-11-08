import SwiftUI

struct FilterOptionsView: View {
    let equipmentTypes: [String]
    @Binding var selectedEquipment: String?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(equipmentTypes, id: \.self) { type in
                    FilterButton(
                        title: type,
                        isSelected: selectedEquipment == type,
                        action: {
                            selectedEquipment = selectedEquipment == type ? nil : type
                        }
                    )
                }
            }
            .padding()
        }
    }
}

struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.white)
                .foregroundColor(isSelected ? .white : .blue)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.blue, lineWidth: 1)
                )
        }
    }
} 