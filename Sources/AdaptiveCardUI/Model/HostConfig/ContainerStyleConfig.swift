import DefaultCodable
import Foundation

public struct ContainerStyleConfig: Codable, Equatable {
    public enum White: DefaultValueProvider {
        public static let `default` = "#FFFFFFFF"
    }

    /// The background color to use for this container.
    @Default<White> public var backgroundColor: String

    /// The text colors to use for this container.
    @Default<ForegroundColorsConfig> public var foregroundColors: ForegroundColorsConfig

    public init(
        backgroundColor: String,
        foregroundColors: ForegroundColorsConfig
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColors = foregroundColors
    }
}
