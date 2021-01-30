import Foundation

public struct TextColor: Codable, Hashable, RawRepresentable {
    public private(set) var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension TextColor: Equatable {
    public static func == (lhs: TextColor, rhs: TextColor) -> Bool {
        lhs.rawValue.caseInsensitiveCompare(rhs.rawValue) == .orderedSame
    }
}

public extension TextColor {
    static let `default` = TextColor(rawValue: "default")
    static let dark = TextColor(rawValue: "dark")
    static let light = TextColor(rawValue: "light")
    static let accent = TextColor(rawValue: "accent")
    static let good = TextColor(rawValue: "good")
    static let warning = TextColor(rawValue: "warning")
    static let attention = TextColor(rawValue: "attention")
}

extension TextColor: CaseIterable {
    public static var allCases: [TextColor] = [
        .default, .dark, .light, .accent, .good, .warning, .attention,
    ]
}
