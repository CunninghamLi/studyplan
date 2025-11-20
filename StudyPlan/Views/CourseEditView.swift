import SwiftUI
import SwiftData

struct CourseEditView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var existingCourse: Course?
    
    @State private var name: String = ""
    @State private var code: String = ""
    @State private var term: String = ""
    @State private var colorHex: String = "#2E86DE"
    
    init(existingCourse: Course? = nil) {
        self.existingCourse = existingCourse
        if let course = existingCourse {
            _name = State(initialValue: course.name)
            _code = State(initialValue: course.code)
            _term = State(initialValue: course.term)
            _colorHex = State(initialValue: course.colorHex)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Course name", text: $name)
                TextField("Course code", text: $code)
                TextField("Term (optional)", text: $term)
                TextField("Color hex", text: $colorHex)
            }
            .navigationTitle(existingCourse == nil ? "New Course" : "Edit Course")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if let course = existingCourse {
                            course.name = name
                            course.code = code
                            course.term = term
                            course.colorHex = colorHex
                        } else {
                            let newCourse = Course(
                                name: name,
                                code: code,
                                term: term,
                                colorHex: colorHex
                            )
                            context.insert(newCourse)
                        }
                        dismiss()
                    }
                    .disabled(name.isEmpty || code.isEmpty)
                }
            }
        }
    }
}
