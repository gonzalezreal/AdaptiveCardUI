import DefaultCodable
import Foundation

/// The color palettes for the different container styles.
public struct ContainerStylesConfig: Codable, Equatable {
    public enum DefaultPalette: DefaultValueProvider {
        public static let `default` = ContainerStyleConfig(
            backgroundColor: "#FFFFFFFF",
            foregroundColors: ForegroundColorsConfig(
                default: TextColorConfig(default: "#FF000000", subtle: "#B2000000"),
                accent: TextColorConfig(default: "#FF0000FF", subtle: "#B20000FF"),
                dark: TextColorConfig(default: "#FF101010", subtle: "#B2101010"),
                light: TextColorConfig(default: "#FFFFFFFF", subtle: "#B2FFFFFF"),
                good: TextColorConfig(default: "#FF008000", subtle: "#B2008000"),
                warning: TextColorConfig(default: "#FFFFD700", subtle: "#B2FFD700"),
                attention: TextColorConfig(default: "#FF8B0000", subtle: "#B28B0000")
            )
        )
    }

    public enum EmphasisPalette: DefaultValueProvider {
        public static let `default` = ContainerStyleConfig(
            backgroundColor: "#08000000",
            foregroundColors: ForegroundColorsConfig(
                default: TextColorConfig(default: "#FF000000", subtle: "#B2000000"),
                accent: TextColorConfig(default: "#FF0000FF", subtle: "#B20000FF"),
                dark: TextColorConfig(default: "#FF101010", subtle: "#B2101010"),
                light: TextColorConfig(default: "#FFFFFFFF", subtle: "#B2FFFFFF"),
                good: TextColorConfig(default: "#FF008000", subtle: "#B2008000"),
                warning: TextColorConfig(default: "#FFFFD700", subtle: "#B2FFD700"),
                attention: TextColorConfig(default: "#FF8B0000", subtle: "#B28B0000")
            )
        )
    }

    public enum GoodPalette: DefaultValueProvider {
        public static let `default` = ContainerStyleConfig(
            backgroundColor: "#FFD5F0DD",
            foregroundColors: ForegroundColorsConfig(
                default: TextColorConfig(default: "#FF000000", subtle: "#B2000000"),
                accent: TextColorConfig(default: "#FF0000FF", subtle: "#B20000FF"),
                dark: TextColorConfig(default: "#FF101010", subtle: "#B2101010"),
                light: TextColorConfig(default: "#FFFFFFFF", subtle: "#B2FFFFFF"),
                good: TextColorConfig(default: "#FF008000", subtle: "#B2008000"),
                warning: TextColorConfig(default: "#FFA60000", subtle: "#B2FFA600"),
                attention: TextColorConfig(default: "#FF8B0000", subtle: "#B28B0000")
            )
        )
    }

    public enum WarningPalette: DefaultValueProvider {
        public static let `default` = ContainerStyleConfig(
            backgroundColor: "#F7F7DF",
            foregroundColors: ForegroundColorsConfig(
                default: TextColorConfig(default: "#FF000000", subtle: "#B2000000"),
                accent: TextColorConfig(default: "#FF0000FF", subtle: "#B20000FF"),
                dark: TextColorConfig(default: "#FF101010", subtle: "#B2101010"),
                light: TextColorConfig(default: "#FFFFFFFF", subtle: "#B2FFFFFF"),
                good: TextColorConfig(default: "#FF008000", subtle: "#B2008000"),
                warning: TextColorConfig(default: "#FFA60000", subtle: "#B2FFA600"),
                attention: TextColorConfig(default: "#FF8B0000", subtle: "#B28B0000")
            )
        )
    }

    public enum AttentionPalette: DefaultValueProvider {
        public static let `default` = ContainerStyleConfig(
            backgroundColor: "#F7E9E9",
            foregroundColors: ForegroundColorsConfig(
                default: TextColorConfig(default: "#FF000000", subtle: "#B2000000"),
                accent: TextColorConfig(default: "#FF0000FF", subtle: "#B20000FF"),
                dark: TextColorConfig(default: "#FF101010", subtle: "#B2101010"),
                light: TextColorConfig(default: "#FFFFFFFF", subtle: "#B2FFFFFF"),
                good: TextColorConfig(default: "#FF008000", subtle: "#B2008000"),
                warning: TextColorConfig(default: "#FFA60000", subtle: "#B2FFA600"),
                attention: TextColorConfig(default: "#FF8B0000", subtle: "#B28B0000")
            )
        )
    }

    public enum AccentPalette: DefaultValueProvider {
        public static let `default` = ContainerStyleConfig(
            backgroundColor: "#DCE5F7",
            foregroundColors: ForegroundColorsConfig(
                default: TextColorConfig(default: "#FF000000", subtle: "#B2000000"),
                accent: TextColorConfig(default: "#FF0000FF", subtle: "#B20000FF"),
                dark: TextColorConfig(default: "#FF101010", subtle: "#B2101010"),
                light: TextColorConfig(default: "#FFFFFFFF", subtle: "#B2FFFFFF"),
                good: TextColorConfig(default: "#FF008000", subtle: "#B2008000"),
                warning: TextColorConfig(default: "#FFA60000", subtle: "#B2FFA600"),
                attention: TextColorConfig(default: "#FF8B0000", subtle: "#B28B0000")
            )
        )
    }

    /// The color palette for the `default` container style.
    @Default<DefaultPalette> public var `default`: ContainerStyleConfig

    /// The color palette for the `emphasis` container style.
    @Default<EmphasisPalette> public var emphasis: ContainerStyleConfig

    /// The color palette for the `good` container style.
    @Default<GoodPalette> public var good: ContainerStyleConfig

    /// The color palette for the `warning` container style.
    @Default<WarningPalette> public var warning: ContainerStyleConfig

    /// The color palette for the `attention` container style.
    @Default<AttentionPalette> public var attention: ContainerStyleConfig

    /// The color palette for the `accent` container style.
    @Default<AccentPalette> public var accent: ContainerStyleConfig

    public subscript(containerStyle: ContainerStyle) -> ContainerStyleConfig {
        switch containerStyle {
        case .default: return `default`
        case .emphasis: return emphasis
        case .good: return good
        case .attention: return attention
        case .warning: return warning
        case .accent: return accent
        default: return `default`
        }
    }

    public init(
        default: ContainerStyleConfig = DefaultPalette.default,
        emphasis: ContainerStyleConfig = EmphasisPalette.default,
        good: ContainerStyleConfig = GoodPalette.default,
        warning: ContainerStyleConfig = WarningPalette.default,
        attention: ContainerStyleConfig = AttentionPalette.default,
        accent: ContainerStyleConfig = AccentPalette.default
    ) {
        self.default = `default`
        self.emphasis = emphasis
        self.good = good
        self.warning = warning
        self.attention = attention
        self.accent = accent
    }
}

extension ContainerStylesConfig: DefaultValueProvider {
    public static let `default` = ContainerStylesConfig()
}
