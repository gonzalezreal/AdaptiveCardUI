import Foundation

public struct VerticalContentAlignment: Codable, Hashable, RawRepresentable {
    public private(set) var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension VerticalContentAlignment: Equatable {
    public static func == (lhs: VerticalContentAlignment, rhs: VerticalContentAlignment) -> Bool {
        lhs.rawValue.caseInsensitiveCompare(rhs.rawValue) == .orderedSame
    }
}

public extension VerticalContentAlignment {
    static let top = VerticalContentAlignment(rawValue: "top")
    static let center = VerticalContentAlignment(rawValue: "center")
    static let bottom = VerticalContentAlignment(rawValue: "bottom")
}

extension VerticalContentAlignment: CaseIterable {
    public static var allCases: [VerticalContentAlignment] = [.top, .center, .bottom]
}

// The Adaptive Card schema also have this type, with the same values ¯\_(ツ)_/¯
public typealias VerticalAlignment = VerticalContentAlignment
