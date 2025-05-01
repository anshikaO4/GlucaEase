import SwiftUI

@main
struct MyApp: App {
    @StateObject private var reminderManager = ReminderManager()
    @State private var isLandingPagePresented = true

    var body: some Scene {
        WindowGroup {
            VStack {
                if isLandingPagePresented {
                    LandingPage(isLandingPagePresented: $isLandingPagePresented)
                        .environmentObject(reminderManager)
                } else {
                    ContentView()
                        .environmentObject(reminderManager)
                }
            }
        }
    }
}
