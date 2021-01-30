import Foundation

/// A type that represents a custom card element.
public protocol CustomCardElement: CardElementProtocol {
    /// The type name of this custom card element.
    static var typeName: String { get }
}

public extension CustomCardElement {
    static var typeName: String { String(describing: self) }
}
