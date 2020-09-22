import Foundation

public struct ContainerStyle: Codable, Hashable, RawRepresentable {
    public private(set) var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension ContainerStyle: Equatable {
    public static func == (lhs: ContainerStyle, rhs: ContainerStyle) -> Bool {
        lhs.rawValue.caseInsensitiveCompare(rhs.rawValue) == .orderedSame
    }
}

public extension ContainerStyle {
    static let `default` = ContainerStyle(rawValue: "default")
    static let emphasis = ContainerStyle(rawValue: "emphasis")
    static let good = ContainerStyle(rawValue: "good")
    static let attention = ContainerStyle(rawValue: "attention")
    static let warning = ContainerStyle(rawValue: "warning")
    static let accent = ContainerStyle(rawValue: "accent")
}

extension ContainerStyle: CaseIterable {
    public static var allCases: [ContainerStyle] = [
        .default, .emphasis, .good,
        .attention, .warning, .accent,
    ]
}
