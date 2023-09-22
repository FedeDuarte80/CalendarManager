import SwiftUI

@main
struct CalendarManagerApp: App {
    @StateObject var oo = ParentManager()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environmentObject(oo)
        }
    }
}
