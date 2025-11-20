import SwiftUI
import SwiftData

struct CourseDetailView: View {
    @Environment(\.modelContext) private var context
    
    var course: Course
    
    @State private var showNewAssignmentSheet = false
    @State private var assignmentToEdit: Assignment? = nil
    @StateObject private var viewModel = CourseDetailViewModel()
    
    var body: some View {
        List {
            let assignments = viewModel.sortedAssignments(for: course)
            
            ForEach(assignments) { assignment in
                Button {
                    // Edit existing assignment
                    assignmentToEdit = assignment
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(assignment.title)
                                .font(.headline)
                            
                            Text(assignment.dueDate, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Button {
                            viewModel.toggleStatus(for: assignment)
                        } label: {
                            Text(assignment.status.rawValue)
                                .font(.caption)
                                .padding(6)
                                .background(Color.blue.opacity(0.15))
                                .cornerRadius(6)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .onDelete { indexSet in
                viewModel.deleteAssignments(
                    at: indexSet,
                    in: course,
                    context: context
                )
            }
        }
        .navigationTitle(course.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Open sheet to create a brand new assignment
                    showNewAssignmentSheet = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
        // Sheet for creating a new assignment
        .sheet(isPresented: $showNewAssignmentSheet) {
            AssignmentEditView(course: course)
        }
        // Sheet for editing an existing assignment
        .sheet(item: $assignmentToEdit) { assignment in
            AssignmentEditView(existingAssignment: assignment, course: course)
        }
    }
}
