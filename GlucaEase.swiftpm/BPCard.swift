
import SwiftUI

struct BPCard: View {
    @Binding var isAddButtonTapped: Bool
    @Binding var bloodPressureLevel: (systolic: Double?, diastolic: Double?)
    @Binding var bloodPressureHistory: [(systolic: Double, diastolic: Double)]
    
    let screenWidth = UIScreen.main.bounds.width
    let barWidth: CGFloat = 20
    
  
    
    var body: some View {
        ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(hex: "C9D3F5"))
                        .frame(width: screenWidth - 40, height: 250)
                        .overlay(
                            VStack {
                                BPHeader(isAddButtonTapped: $isAddButtonTapped)
                                
                                Spacer().frame(height: 70)
                               
                                GeometryReader { geometry in
                                    BPGraphView(bloodPressureHistory: $bloodPressureHistory, geometry: geometry)
                                }
                                
                               
                                BPLevelDisplay(bloodPressureLevel: $bloodPressureLevel)
                            }
                        )
                }
    }
}

struct BPHeader: View {
    @Binding var isAddButtonTapped: Bool
    
    var body: some View {
        HStack {
            Text("Blood Pressure")
                .font(.headline)
                .foregroundColor(Color(hex:"1C1345"))
                .padding(.leading, 16)
                .padding(.top, 10)
            
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
       
    }
}


struct BPGraphView: View {
    @Binding var bloodPressureHistory: [(systolic: Double, diastolic: Double)]
    let geometry: GeometryProxy
    
    
    var body: some View {
        VStack {
            if bloodPressureHistory.isEmpty {
                Text("No data available")
                    .foregroundColor(.gray)
                    .italic()
            } else {
               
                let latestSystolic = bloodPressureHistory.suffix(10).map { $0.systolic }
                let latestDiastolic = bloodPressureHistory.suffix(10).map { $0.diastolic }
                
                LineGraph(data: latestSystolic, color: .red)
                    .frame(height: 100)
                
                LineGraph(data: latestDiastolic, color: .blue)
                    .frame(height: 100)
            }
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
        
    }
}


struct LineGraph: View {
    var data: [Double]
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                
                
                guard !data.isEmpty else { return }
                
                
                let maxValue = data.max() ?? 1
                
                for i in 0..<data.count {
                    let xPosition = width * (Double(i) / Double(data.count - 1))
                    let yPosition = height * (1 - (data[i] / maxValue))
                    
                    if i == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    } else {
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
            }
            .stroke(color, lineWidth: 2)
        }
    }
}


struct BPLevelDisplay: View {
    @Binding var bloodPressureLevel: (systolic: Double?, diastolic: Double?)
    
    var body: some View {
        VStack(alignment: .leading) {
            if let systolic = bloodPressureLevel.systolic, let diastolic = bloodPressureLevel.diastolic {
                Text("\(Int(systolic)) / \(Int(diastolic))")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("mmHg")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

        }
        .padding(.vertical, 8)
        .padding(.trailing, 250)
    }
}




struct BPCard_Previews: PreviewProvider {
    static var previews: some View {
        BPCard(isAddButtonTapped: .constant(false), bloodPressureLevel: .constant((120, 80)), bloodPressureHistory: .constant([(120, 80), (130, 85), (125, 78)]))
    }
}

