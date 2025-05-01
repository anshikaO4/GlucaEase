import SwiftUI

struct BloodPressurePopup: View {
    @Binding var isAddButtonTapped: Bool
    @Binding var bloodPressureLevel: (systolic: Double?, diastolic: Double?)
    
    @State private var newSystolic: String = ""
    @State private var newDiastolic: String = ""
    
    @Binding var bloodPressureHistory: [(systolic: Double, diastolic: Double)] // Dynamic history
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Log Your Blood Pressure")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 20)
                .padding(.bottom, 30)
            
            HStack {
                TextField("Systolic", text: $newSystolic)
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
                
                TextField("Diastolic", text: $newDiastolic)
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
            }
            
            Spacer()
            
            HStack(spacing: 0) {
                Button(action: {
                    isAddButtonTapped = false // Close the popup without saving
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
                                    // Add values to history and update the binding
                                    if let systolicValue = Double(newSystolic), let diastolicValue = Double(newDiastolic) {
                                        bloodPressureLevel = (systolic: systolicValue, diastolic: diastolicValue)
                                        // Append the new values to the history
                                        bloodPressureHistory.append((systolic: systolicValue, diastolic: diastolicValue))
                                    }
                                    isAddButtonTapped = false
                                    newSystolic = "" // Reset input field
                                    newDiastolic = ""
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
        .background(Color(hex:"E3EAFA"))
        .cornerRadius(8)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
    }
}





