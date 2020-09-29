import Foundation

public struct VAlignment: Codable, Hashable, RawRepresentable {
    public private(set) var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension VAlignment: Equatable {
    public static func == (lhs: VAlignment, rhs: VAlignment) -> Bool {
        lhs.rawValue.caseInsensitiveCompare(rhs.rawValue) == .orderedSame
    }
}

public extension VAlignment {
    static let top = VAlignment(rawValue: "top")
    static let center = VAlignment(rawValue: "center")
    static let bottom = VAlignment(rawValue: "bottom")
}

extension VAlignment: CaseIterable {
    public static var allCases: [VAlignment] = [.top, .center, .bottom]
}
