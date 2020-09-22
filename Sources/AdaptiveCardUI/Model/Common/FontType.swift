import Foundation

public struct FontType: Codable, Hashable, RawRepresentable {
    public private(set) var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension FontType: Equatable {
    public static func == (lhs: FontType, rhs: FontType) -> Bool {
        lhs.rawValue.caseInsensitiveCompare(rhs.rawValue) == .orderedSame
    }
}

public extension FontType {
    static let `default` = FontType(rawValue: "default")
    static let monospace = FontType(rawValue: "monospace")
}

extension FontType: CaseIterable {
    public static var allCases: [FontType] = [.default, .monospace]
}
