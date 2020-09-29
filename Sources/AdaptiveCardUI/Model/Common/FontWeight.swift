import Foundation

/// Controls the weight of text elements.
public struct FontWeight: Codable, Hashable, RawRepresentable {
    public private(set) var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension FontWeight: Equatable {
    public static func == (lhs: FontWeight, rhs: FontWeight) -> Bool {
        lhs.rawValue.caseInsensitiveCompare(rhs.rawValue) == .orderedSame
    }
}

public extension FontWeight {
    static let `default` = FontWeight(rawValue: "default")
    static let light = FontWeight(rawValue: "lighter")
    static let bold = FontWeight(rawValue: "bolder")
}

extension FontWeight: CaseIterable {
    public static var allCases: [FontWeight] = [.default, .light, .bold]
}
