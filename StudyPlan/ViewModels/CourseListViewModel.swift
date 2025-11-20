import SwiftUI
import SwiftData
import Combine

@MainActor
final class CourseListViewModel: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    func deleteCourses(
        at offsets: IndexSet,
        from courses: [Course],
        in context: ModelContext
    ) {
        for index in offsets {
            context.delete(courses[index])
        }
        objectWillChange.send()
    }
}
