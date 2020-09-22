import DefaultCodable
import Foundation

/// Controls how separators are displayed.
public struct SeparatorConfig: Codable, Equatable {
    public enum Gray: DefaultValueProvider {
        public static let `default` = "#FF707070"
    }

    /// Thickness of separator line.
    @Default<One> public var lineThickness: Int

    /// Color to use when drawing separator line.
    @Default<Gray> public var lineColor: String

    public init(
        lineThickness: Int = One.default,
        lineColor: String = Gray.default
    ) {
        self.lineThickness = lineThickness
        self.lineColor = lineColor
    }
}

extension SeparatorConfig: DefaultValueProvider {
    public static let `default` = SeparatorConfig()
}
