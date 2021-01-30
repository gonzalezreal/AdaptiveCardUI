import Foundation

/// Controls the relative size of text elements.
public struct FontSize: Codable, Hashable, RawRepresentable {
    public private(set) var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension FontSize: Equatable {
    public static func == (lhs: FontSize, rhs: FontSize) -> Bool {
        lhs.rawValue.caseInsensitiveCompare(rhs.rawValue) == .orderedSame
    }
}

public extension FontSize {
    static let `default` = FontSize(rawValue: "default")
    static let small = FontSize(rawValue: "small")
    static let medium = FontSize(rawValue: "medium")
    static let large = FontSize(rawValue: "large")
    static let extraLarge = FontSize(rawValue: "extraLarge")
}

extension FontSize: CaseIterable {
    public static var allCases: [FontSize] = [
        .default, .small, .medium, .large, .extraLarge,
    ]
}
