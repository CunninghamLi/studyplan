import SwiftUI
import SwiftData
import Combine

struct CourseListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Course.name) private var courses: [Course]
    
    @State private var showAddCourse = false
    @StateObject private var viewModel = CourseListViewModel()
    
    var body: some View {
        List {
            ForEach(courses) { course in
                NavigationLink(destination: CourseDetailView(course: course)) {
                    VStack(alignment: .leading) {
                        Text(course.name)
                            .font(.headline)
                        Text(course.code)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .onDelete { indexSet in
                viewModel.deleteCourses(
                    at: indexSet,
                    from: courses,
                    in: context
                )
            }
        }
        .navigationTitle("Courses")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAddCourse = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
        .sheet(isPresented: $showAddCourse) {
            CourseEditView()
        }
    }
}
