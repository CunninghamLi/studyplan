import Foundation

enum AssignmentStatus: String, Codable, CaseIterable, Identifiable {
    case notStarted = "Not Started"
    case inProgress = "In Progress"
    case done = "Done"

    var id: String { rawValue }

    var next: AssignmentStatus {
        switch self {
        case .notStarted: return .inProgress
        case .inProgress: return .done
        case .done: return .notStarted
        }
    }
}
