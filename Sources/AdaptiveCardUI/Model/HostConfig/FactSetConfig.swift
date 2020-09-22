import DefaultCodable
import Foundation

public struct FactSetConfig: Codable, Equatable {
    public enum TitleConfig: DefaultValueProvider {
        public static var `default` = TextBlockConfig(
            weight: .bold,
            maxWidth: 150
        )
    }

    public enum ValueConfig: DefaultValueProvider {
        public static var `default` = TextBlockConfig()
    }

    public enum Spacing: DefaultValueProvider {
        public static var `default` = 10
    }

    /// Text configuration to use for titles in fact sets.
    @Default<TitleConfig> public var title: TextBlockConfig

    /// Text configuration to use for values in fact sets.
    @Default<ValueConfig> public var value: TextBlockConfig

    /// Spacing between titles and values.
    @Default<Spacing> public var spacing: Int

    public init(
        title: TextBlockConfig = TitleConfig.default,
        value: TextBlockConfig = ValueConfig.default,
        spacing: Int = Spacing.default
    ) {
        self.title = title
        self.value = value
        self.spacing = spacing
    }
}

extension FactSetConfig: DefaultValueProvider {
    public static let `default` = FactSetConfig()
}
