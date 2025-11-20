import SwiftUI
import SwiftData

struct CourseDetailView: View {
    @Environment(\.modelContext) private var context
    
    var course: Course
    
    @State private var assignmentForSheet: Assignment?
    @StateObject private var viewModel = CourseDetailViewModel()
    
    var body: some View {
        List {
            let assignments = viewModel.sortedAssignments(for: course)
            
            ForEach(assignments) { assignment in
                Button {
                    // Open existing assignment in sheet
                    assignmentForSheet = assignment
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
                    // Create a new assignment linked to this course, then open it
                    let newAssignment = Assignment(
                        title: "",
                        dueDate: .now,
                        status: .notStarted,
                        notes: "",
                        course: course
                    )
                    context.insert(newAssignment)
                    assignmentForSheet = newAssignment
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
        .sheet(item: $assignmentForSheet) { assignment in
            AssignmentEditView(assignment: assignment)
        }
    }
}
