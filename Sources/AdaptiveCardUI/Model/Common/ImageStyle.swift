import Foundation

public struct ImageStyle: Codable, Hashable, RawRepresentable {
    public private(set) var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension ImageStyle: Equatable {
    public static func == (lhs: ImageStyle, rhs: ImageStyle) -> Bool {
        lhs.rawValue.caseInsensitiveCompare(rhs.rawValue) == .orderedSame
    }
}

public extension ImageStyle {
    static let `default` = ImageStyle(rawValue: "default")
    static let person = ImageStyle(rawValue: "person")
}

extension ImageStyle: CaseIterable {
    public static var allCases: [ImageStyle] = [.default, .person]
}
