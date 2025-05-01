import SwiftUI

struct CustomSegmentedControl: View {
    let items: [String]
    @Binding var selectedIndex: Int
    var selectedColor: Color = Color(hex: "1C1345")
    var unselectedColor: Color = Color(hex: "#1C1345")
    var font: Font = .headline

    var body: some View {
        // Make the HStack scrollable
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) { 
                ForEach(0..<items.count, id: \.self) { index in
                    Text(items[index])
                        .font(font)
                        .foregroundColor(selectedIndex == index ? selectedColor : unselectedColor)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            withAnimation {
                                selectedIndex = index
                            }
                        }
                        .background(
                            selectedIndex == index ? selectedColor.opacity(0.2) : Color.clear
                        )
                        .cornerRadius(8)
                }
            
            } .padding(.horizontal, 0)
        
        }
    }
}
