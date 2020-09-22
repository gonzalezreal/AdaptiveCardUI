import DefaultCodable
import Foundation

public struct ForegroundColorsConfig: Codable, Equatable {
    @Default<TextColorConfig> public var `default`: TextColorConfig

    @Default<TextColorConfig> public var accent: TextColorConfig

    @Default<TextColorConfig> public var dark: TextColorConfig

    @Default<TextColorConfig> public var light: TextColorConfig

    @Default<TextColorConfig> public var good: TextColorConfig

    @Default<TextColorConfig> public var warning: TextColorConfig

    @Default<TextColorConfig> public var attention: TextColorConfig

    public subscript(textColor: TextColor, isSubtle: Bool) -> String {
        switch (textColor, isSubtle) {
        case (.accent, false): return accent.default
        case (.accent, true): return accent.subtle
        case (.dark, false): return dark.default
        case (.dark, true): return dark.subtle
        case (.light, false): return light.default
        case (.light, true): return light.subtle
        case (.good, false): return good.default
        case (.good, true): return good.subtle
        case (.warning, false): return warning.default
        case (.warning, true): return warning.subtle
        case (.attention, false): return attention.default
        case (.attention, true): return attention.subtle
        case (_, false): return `default`.default
        case (_, true): return `default`.subtle
        }
    }

    public init(
        default: TextColorConfig = .default,
        accent: TextColorConfig = .default,
        dark: TextColorConfig = .default,
        light: TextColorConfig = .default,
        good: TextColorConfig = .default,
        warning: TextColorConfig = .default,
        attention: TextColorConfig = .default
    ) {
        self.default = `default`
        self.accent = accent
        self.dark = dark
        self.light = light
        self.good = good
        self.warning = warning
        self.attention = attention
    }
}

extension ForegroundColorsConfig: DefaultValueProvider {
    public static let `default` = ForegroundColorsConfig()
}
