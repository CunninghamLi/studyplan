import Foundation
import SwiftData

@Model
final class Course {
    var name: String
    var code: String
    var term: String
    var colorHex: String

    @Relationship(deleteRule: .cascade, inverse: \Assignment.course)
    var assignments: [Assignment] = []

    init(
        name: String,
        code: String,
        term: String = "",
        colorHex: String = "#2E86DE"
    ) {
        self.name = name
        self.code = code
        self.term = term
        self.colorHex = colorHex
    }
}
