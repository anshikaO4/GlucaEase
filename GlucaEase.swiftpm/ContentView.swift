import SwiftUI


struct ContentView: View {
    @State private var isProfilePresented = false
    @EnvironmentObject var reminderManager:ReminderManager
    
    var body: some View {
        
            NavigationStack {
                TabView {
                    TabOne().environmentObject(reminderManager)
                        .tabItem {
                            Image(systemName: "heart.text.clipboard")
                            Text("Health")
                            
                        }

                    TabTwo()
                        .tabItem {
                            Image(systemName: "frying.pan.fill")
                            Text("Nourish")
                               
                        }
                    
                }
                .accentColor(Color(hex:"#1C1345"))
                .navigationTitle("")  // Clear title in NavigationStack
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("GlucaEase")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            //.foregroundColor(.black)
                            .foregroundColor(Color(hex:"1C1345"))
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isProfilePresented.toggle()
                        }) {
                            Image(systemName: "person.circle.fill")
                                .font(.title3)
                                .foregroundColor(Color(hex:"1C1345"))
                                
                        }
                    }
                }
            } 
        
        
        .sheet(isPresented: $isProfilePresented) {
            Profile(isProfilePresented: $isProfilePresented).environmentObject(reminderManager)
        }
        
    }
       

}
