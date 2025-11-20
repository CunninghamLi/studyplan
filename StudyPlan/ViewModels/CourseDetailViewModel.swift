import SwiftUI
import SwiftData
import Combine

@MainActor
final class CourseDetailViewModel: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    func sortedAssignments(for course: Course) -> [Assignment] {
        course.assignments.sorted { $0.dueDate < $1.dueDate }
    }
    
    func toggleStatus(for assignment: Assignment) {
        assignment.status = assignment.status.next
        objectWillChange.send()
    }
    
    func deleteAssignments(
        at offsets: IndexSet,
        in course: Course,
        context: ModelContext
    ) {
        let assignments = sortedAssignments(for: course)
        for index in offsets {
            let assignment = assignments[index]
            context.delete(assignment)
        }
        objectWillChange.send()
    }
}
