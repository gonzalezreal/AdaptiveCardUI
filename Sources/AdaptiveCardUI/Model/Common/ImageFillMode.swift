import Foundation

public struct ImageFillMode: Codable, Hashable, RawRepresentable {
    public private(set) var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension ImageFillMode: Equatable {
    public static func == (lhs: ImageFillMode, rhs: ImageFillMode) -> Bool {
        lhs.rawValue.caseInsensitiveCompare(rhs.rawValue) == .orderedSame
    }
}

public extension ImageFillMode {
    static let cover = ImageFillMode(rawValue: "cover")
    static let repeatHorizontally = ImageFillMode(rawValue: "repeatHorizontally")
    static let repeatVertically = ImageFillMode(rawValue: "repeatVertically")
    static let `repeat` = ImageFillMode(rawValue: "repeat")
}

extension ImageFillMode: CaseIterable {
    public static var allCases: [ImageFillMode] = [
        .cover, .repeatHorizontally, .repeatVertically, .repeat,
    ]
}
