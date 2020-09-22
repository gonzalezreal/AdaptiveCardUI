import Foundation

/// Controls the approximate size of the image. The physical dimensions will vary per host.
public struct ImageSize: Codable, Hashable, RawRepresentable {
    public private(set) var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension ImageSize: Equatable {
    public static func == (lhs: ImageSize, rhs: ImageSize) -> Bool {
        lhs.rawValue.caseInsensitiveCompare(rhs.rawValue) == .orderedSame
    }
}

public extension ImageSize {
    static let auto = ImageSize(rawValue: "auto")
    static let stretch = ImageSize(rawValue: "stretch")
    static let small = ImageSize(rawValue: "small")
    static let medium = ImageSize(rawValue: "medium")
    static let large = ImageSize(rawValue: "large")
}

extension ImageSize: CaseIterable {
    public static var allCases: [ImageSize] = [
        .auto, .stretch, .small, .medium, .large,
    ]
}
