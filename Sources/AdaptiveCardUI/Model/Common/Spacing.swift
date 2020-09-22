import Foundation

/// Specifies how much spacing. Hosts pick the exact pixel amounts for each of these.
public struct Spacing: Codable, Hashable, RawRepresentable {
    public private(set) var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension Spacing: Equatable {
    public static func == (lhs: Spacing, rhs: Spacing) -> Bool {
        lhs.rawValue.caseInsensitiveCompare(rhs.rawValue) == .orderedSame
    }
}

public extension Spacing {
    static let `default` = Spacing(rawValue: "default")
    static let none = Spacing(rawValue: "none")
    static let small = Spacing(rawValue: "small")
    static let medium = Spacing(rawValue: "medium")
    static let large = Spacing(rawValue: "large")
    static let extraLarge = Spacing(rawValue: "extraLarge")
    static let padding = Spacing(rawValue: "padding")
}

extension Spacing: CaseIterable {
    public static var allCases: [Spacing] = [
        .default, .none, .small, .medium, .large, .extraLarge, .padding,
    ]
}
