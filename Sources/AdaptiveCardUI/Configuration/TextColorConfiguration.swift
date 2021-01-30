#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct TextColorConfiguration: Equatable {
        public let `default`: TextColorPair
        public let accent: TextColorPair
        public let dark: TextColorPair
        public let light: TextColorPair
        public let good: TextColorPair
        public let warning: TextColorPair
        public let attention: TextColorPair

        public subscript(textColor: TextColor, isSubtle: Bool) -> Color {
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
            default: TextColorPair = .default,
            accent: TextColorPair = .accent,
            dark: TextColorPair = .dark,
            light: TextColorPair = .light,
            good: TextColorPair = .good,
            warning: TextColorPair = .warning,
            attention: TextColorPair = .attention
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

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension TextColorConfiguration {
        static let `default` = TextColorConfiguration()
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension TextColorConfiguration: Decodable {
        private enum CodingKeys: String, CodingKey {
            case `default`, accent, dark, light, good, warning, attention
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            `default` = try container.decodeIfPresent(TextColorPair.self, forKey: .default) ?? .default
            accent = try container.decodeIfPresent(TextColorPair.self, forKey: .accent) ?? .accent
            dark = try container.decodeIfPresent(TextColorPair.self, forKey: .dark) ?? .dark
            light = try container.decodeIfPresent(TextColorPair.self, forKey: .light) ?? .light
            good = try container.decodeIfPresent(TextColorPair.self, forKey: .good) ?? .good
            warning = try container.decodeIfPresent(TextColorPair.self, forKey: .warning) ?? .warning
            attention = try container.decodeIfPresent(TextColorPair.self, forKey: .attention) ?? .attention
        }
    }

#endif
