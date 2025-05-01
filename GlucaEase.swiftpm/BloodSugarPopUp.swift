import SwiftUI

struct BloodSugarPopup: View {
    @Binding var isAddButtonTapped: Bool
    @Binding var bloodSugarLevel: Double?
    
    @State private var newBloodSugar: String = ""
    @Binding var bloodSugarHistory: [Double]
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Log Your Blood Sugar")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 20)
                .padding(.bottom, 30)
            
            
            TextField("Enter Blood Sugar Level", text: $newBloodSugar)
                .keyboardType(.decimalPad)
                .padding(.horizontal, 15)
                .padding(.vertical, 15)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hex:"1C1345"))
                        .background(Color(hex: "E3EAFA"))
                )
                .padding(.horizontal, 32)
                .frame(height: 60)
            
            Spacer()
            
            HStack(spacing: 0) {
                Button(action: {
                    isAddButtonTapped = false
                }) {
                    Text("Cancel")
                        .foregroundColor(.red)
                        .font(.body)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hex:"1C1345"))
                        .background(Color(hex: "E3EAFA"))
                )
                
                VStack {
                    Divider()
                        .background(Color(hex:"1C1345"))
                        .frame(width: 1)
                }
                
                Button(action: {
                    if let bloodSugarValue = Double(newBloodSugar) {
                        bloodSugarLevel = bloodSugarValue
                        bloodSugarHistory.append(bloodSugarValue)
                    }
                    isAddButtonTapped = false
                    newBloodSugar = ""
                }) {
                    Text("Save")
                        .font(.body)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hex:"1C1345"))
                        .background(Color(hex: "E3EAFA"))
                )
            }
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 220)
        .background((Color(hex: "E3EAFA")))
        .cornerRadius(8)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
    }
}

struct BloodSugarPopup_Previews: PreviewProvider {
    static var previews: some View {
        BloodSugarPopup(isAddButtonTapped: .constant(false),
                        bloodSugarLevel: .constant(100),
                        bloodSugarHistory: .constant([90, 95, 100]))
    }
}


