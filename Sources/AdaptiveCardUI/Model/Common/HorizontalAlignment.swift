import Foundation

/// Controls how content is horizontally positioned within its container.
public struct HorizontalAlignment: Codable, Hashable, RawRepresentable {
    public private(set) var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension HorizontalAlignment: Equatable {
    public static func == (lhs: HorizontalAlignment, rhs: HorizontalAlignment) -> Bool {
        lhs.rawValue.caseInsensitiveCompare(rhs.rawValue) == .orderedSame
    }
}

public extension HorizontalAlignment {
    static let left = HorizontalAlignment(rawValue: "left")
    static let center = HorizontalAlignment(rawValue: "center")
    static let right = HorizontalAlignment(rawValue: "right")
}

extension HorizontalAlignment: CaseIterable {
    public static var allCases: [HorizontalAlignment] = [.left, .center, .right]
}
