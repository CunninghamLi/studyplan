import SwiftUI
import Combine

@MainActor
final class TodayViewModel: ObservableObject {
    
    // Date from which we consider assignments "upcoming"
    @Published var selectedDate: Date = Date()
    
    // Optional filter by status
    @Published var filterStatus: AssignmentStatus? = nil
    
    private let calendar = Calendar.current
    
    func upcomingAssignments(from allAssignments: [Assignment]) -> [Assignment] {
        let startOfSelected = calendar.startOfDay(for: selectedDate)
        
        return allAssignments
            .filter { assignment in
                let assignmentDay = calendar.startOfDay(for: assignment.dueDate)
                
                // Due on or after selected date
                let isUpcoming = assignmentDay >= startOfSelected
                
                let matchesStatus = (filterStatus == nil || assignment.status == filterStatus)
                
                return isUpcoming && matchesStatus
            }
            .sorted { $0.dueDate < $1.dueDate }
    }
    
    func toggleStatus(for assignment: Assignment) {
        assignment.status = assignment.status.next
    }
}
