import SwiftUI
import SwiftData

struct AssignmentEditView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var assignment: Assignment
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $assignment.title)
                
                DatePicker(
                    "Due date",
                    selection: $assignment.dueDate,
                    displayedComponents: .date
                )
                
                Picker("Status", selection: $assignment.status) {
                    ForEach(AssignmentStatus.allCases) { status in
                        Text(status.rawValue).tag(status)
                    }
                }
                
                TextField("Notes", text: $assignment.notes, axis: .vertical)
                    .lineLimit(3...6)
            }
            .navigationTitle("Edit Assignment")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}
