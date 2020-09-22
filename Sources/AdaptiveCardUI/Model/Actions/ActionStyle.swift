import Foundation

/// Controls the style of an Action, which influences how the action is displayed, spoken, etc.
public struct ActionStyle: Codable, Hashable, RawRepresentable {
    public private(set) var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension ActionStyle: Equatable {
    public static func == (lhs: ActionStyle, rhs: ActionStyle) -> Bool {
        lhs.rawValue.caseInsensitiveCompare(rhs.rawValue) == .orderedSame
    }
}

public extension ActionStyle {
    static let `default` = ActionStyle(rawValue: "default")
    static let positive = ActionStyle(rawValue: "positive")
    static let destructive = ActionStyle(rawValue: "destructive")
}

extension ActionStyle: CaseIterable {
    public static var allCases: [ActionStyle] = [.default, .positive, .destructive]
}
