import SwiftUI

struct ContentView: View {
    @EnvironmentObject var oo: ParentManager
    var body: some View {
        TabView {
            CalendarTab().tabItem {
             Label("Calendar", systemImage: "calendar")
            }
            ListTab().tabItem {
             Label("List", systemImage: "list.bullet")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ParentManager())
    }
}
