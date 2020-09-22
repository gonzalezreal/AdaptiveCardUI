import Foundation

/// Describes a fact in a `FactSet` as a key / value pair.
public struct Fact: Codable, Equatable {
    /// The title of the fact.
    public var title: String

    /// The value of the fact.
    public var value: String

    public init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}
