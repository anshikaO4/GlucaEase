import SwiftUI

struct BloodSugarCard: View {
    @Binding var isAddButtonTapped: Bool
    @Binding var bloodSugarLevel: Double?
    @Binding var bloodSugarHistory: [Double]
    
    let screenWidth = UIScreen.main.bounds.width
    let barWidth: CGFloat = 20
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(hex: "C9D3F5"))
                .frame(width: screenWidth - 40, height: 250)
                .cornerRadius(8)
                .overlay(
                    VStack {
                        HStack {
                            Text("Blood Sugar")
                                .font(.headline)
                                //.foregroundColor(.black)
                                .padding(.leading, 16)
                                .padding(.top, 10)
                                .foregroundColor(Color(hex:"1C1345"))
                            
                            Spacer()
                            
                            Button(action: {
                                isAddButtonTapped.toggle()
                            }) {
                                Image(systemName: "plus.circle")
                                    .foregroundColor(Color(hex:"1C1345"))
                                    .font(.title)
                                    .padding(.trailing, 16)
                                    .padding(.top, 10)
                            }
                        }
                        
                        Spacer()
                        
                        
                        if bloodSugarHistory.isEmpty {
                            Text("No Data Available")
                                .font(.body)
                                .italic()
                                .foregroundColor(.gray)
                                .padding(.top, 16)
                        } else {
                            
                            GeometryReader { geometry in
                                HStack(spacing: 8) {
                                    ForEach(bloodSugarHistory.suffix(10), id: \.self) { level in
                                        VStack {
                                            Rectangle()
                                                .fill(level > 100 ? Color.red : Color.green)
                                                .frame(width: barWidth, height: CGFloat(level / 2))
                                                .frame(maxHeight: geometry.size.height, alignment: .bottom)
                                            
                                            Text("\(Int(level))")
                                                .font(.caption)
                                                .foregroundColor(.black)
                                                .padding(.top, 4)
                                        }
                                    }
                                }
                                .frame(width: screenWidth - 40, height: geometry.size.height)
                                .padding(.top, 8)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            if let level = bloodSugarLevel {
                                Text("\(Int(level))")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                Text("mg/dL")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.trailing, 280)
                    }
                )
        }
    }
}

struct BloodSugarCard_Previews: PreviewProvider {
    static var previews: some View {
        BloodSugarCard(isAddButtonTapped: .constant(false), bloodSugarLevel: .constant(100), bloodSugarHistory: .constant([90, 110, 150, 125, 95, 100, 120, 180, 100]))
    }
}
