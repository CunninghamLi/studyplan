import SwiftUI
import SwiftData

struct AssignmentEditView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var existingAssignment: Assignment?

    var course: Course?
    
    @State private var title: String
    @State private var dueDate: Date
    @State private var status: AssignmentStatus
    @State private var notes: String
    
    init(existingAssignment: Assignment? = nil, course: Course? = nil) {
        self.existingAssignment = existingAssignment
        self.course = course
        
        if let a = existingAssignment {
            _title = State(initialValue: a.title)
            _dueDate = State(initialValue: a.dueDate)
            _status = State(initialValue: a.status)
            _notes = State(initialValue: a.notes)
        } else {
            _title = State(initialValue: "")
            _dueDate = State(initialValue: Date())
            _status = State(initialValue: .notStarted)
            _notes = State(initialValue: "")
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                
                DatePicker(
                    "Due date",
                    selection: $dueDate,
                    displayedComponents: .date
                )
                
                Picker("Status", selection: $status) {
                    ForEach(AssignmentStatus.allCases) { s in
                        Text(s.rawValue).tag(s)
                    }
                }
                
                TextField("Notes", text: $notes, axis: .vertical)
                    .lineLimit(3...6)
            }
            .navigationTitle(existingAssignment == nil ? "New Assignment" : "Edit Assignment")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if let a = existingAssignment {
                            // Update existing assignment
                            a.title = title
                            a.dueDate = dueDate
                            a.status = status
                            a.notes = notes
                        } else {
                            // Create new assignment only when user taps Save
                            let newAssignment = Assignment(
                                title: title,
                                dueDate: dueDate,
                                status: status,
                                notes: notes,
                                course: course
                            )
                            context.insert(newAssignment)
                        }
                        
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
