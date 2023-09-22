import Foundation

extension ParentEntity {
    var parentName: String {
        name ?? "any name"
    }
    var parentDay: Date {
        fullday ?? Date()
    }
}
