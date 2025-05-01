import SwiftUI

struct LandingPage: View {
    @Binding var isLandingPagePresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("GlucaEase")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(hex: "1C1345"))
                        .padding(.top, 20)
                        .padding(.leading)
                    
                    Spacer()
                }
                
                
                Text("Track, manage and live better with GlucaEase")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.trailing, 120)
                    .foregroundColor(Color(hex: "1C1345"))
                
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        isLandingPagePresented = false
                    }) {
                        Text("Get Started")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(width: 120, height: 120)
                            .background(Color(hex:"#1C1345"))
                            .foregroundColor(Color(hex: "#E0E3F0"))
                            .cornerRadius(100)
                            .shadow(radius: 10)
                    }
                    .padding(.bottom, 30)
                    .padding(.trailing, 30)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: "#E0E3F0"))
        }
        .navigationTitle("")
        .navigationBarHidden(true) // Hide the default navigation bar
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage(isLandingPagePresented: .constant(true))
    }
}
