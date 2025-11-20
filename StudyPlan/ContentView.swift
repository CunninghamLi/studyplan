import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                TodayView()
            }
            .tabItem {
                Label("Today", systemImage: "calendar")
            }
            
            NavigationStack {
                CourseListView()
            }
            .tabItem {
                Label("Courses", systemImage: "book.closed")
            }
        }
    }
}
