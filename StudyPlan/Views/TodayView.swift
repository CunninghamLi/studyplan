import SwiftUI
import SwiftData

struct TodayView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Assignment.dueDate) private var allAssignments: [Assignment]
    
    @StateObject private var viewModel = TodayViewModel()
    
    var body: some View {
        let upcoming = viewModel.upcomingAssignments(from: allAssignments)
        
        VStack {
            // Calendar-style date picker
            DatePicker(
                "From date",
                selection: $viewModel.selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .padding(.horizontal)
            
            // Status filter button
            HStack {
                Menu {
                    Button("All statuses") {
                        viewModel.filterStatus = nil
                    }
                    
                    ForEach(AssignmentStatus.allCases) { status in
                        Button(status.rawValue) {
                            viewModel.filterStatus = status
                        }
                    }
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            // List of upcoming assignments
            List {
                if upcoming.isEmpty {
                    Text("No upcoming assignments from this date")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(upcoming) { assignment in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(assignment.title)
                                    .font(.headline)
                                
                                if let course = assignment.course {
                                    Text(course.code)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                Text(assignment.dueDate, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Button {
                                viewModel.toggleStatus(for: assignment)
                            } label: {
                                Text(assignment.status.rawValue)
                                    .font(.caption2)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.15))
                                    .cornerRadius(8)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .navigationTitle("Upcoming")
    }
}
