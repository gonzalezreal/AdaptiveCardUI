import Foundation

/// Controls how content is horizontally positioned within its container.
public struct HAlignment: Codable, Hashable, RawRepresentable {
    public private(set) var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension HAlignment: Equatable {
    public static func == (lhs: HAlignment, rhs: HAlignment) -> Bool {
        lhs.rawValue.caseInsensitiveCompare(rhs.rawValue) == .orderedSame
    }
}

public extension HAlignment {
    static let left = HAlignment(rawValue: "left")
    static let center = HAlignment(rawValue: "center")
    static let right = HAlignment(rawValue: "right")
}

extension HAlignment: CaseIterable {
    public static var allCases: [HAlignment] = [.left, .center, .right]
}
