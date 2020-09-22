import DefaultCodable
import Foundation

public struct TextColorConfig: Codable, Equatable {
    public enum Black: DefaultValueProvider {
        public static let `default` = "#FF000000"
    }

    public enum SubtleBlack: DefaultValueProvider {
        public static let `default` = "#B2000000"
    }

    /// Color to use when displaying default text in #AARRGGBB format.
    @Default<Black> public var `default`: String

    /// Color to use when displaying subtle text in #AARRGGBB format.
    @Default<SubtleBlack> public var subtle: String

    public init(
        default: String = Black.default,
        subtle: String = SubtleBlack.default
    ) {
        self.default = `default`
        self.subtle = subtle
    }
}

extension TextColorConfig: DefaultValueProvider {
    public static let `default` = TextColorConfig()
}
