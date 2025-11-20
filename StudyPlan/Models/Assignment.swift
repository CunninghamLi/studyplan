import Foundation
import SwiftData

@Model
final class Assignment {
    var title: String
    var dueDate: Date
    var statusRaw: String
    var notes: String

    @Relationship
    var course: Course?

    var status: AssignmentStatus {
        get { AssignmentStatus(rawValue: statusRaw) ?? .notStarted }
        set { statusRaw = newValue.rawValue }
    }

    init(
        title: String,
        dueDate: Date,
        status: AssignmentStatus = .notStarted,
        notes: String = "",
        course: Course? = nil
    ) {
        self.title = title
        self.dueDate = dueDate
        self.statusRaw = status.rawValue
        self.notes = notes
        self.course = course
    }
}

