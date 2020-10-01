#if canImport(SwiftUI)

    import SwiftUI

    /// Specifies how much spacing should be used for the various spacing options inside
    /// adaptive cards.
    ///
    /// To set the spacing configuration for a view hierarchy, use the `spacingConfiguration(_:)`
    /// modifier and specify an instance of this type.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct SpacingConfiguration: Equatable {
        public let `default`: CGFloat
        public let small: CGFloat
        public let medium: CGFloat
        public let large: CGFloat
        public let extraLarge: CGFloat
        public let padding: CGFloat

        public init(
            default: CGFloat,
            small: CGFloat,
            medium: CGFloat,
            large: CGFloat,
            extraLarge: CGFloat,
            padding: CGFloat
        ) {
            self.default = `default`
            self.small = small
            self.medium = medium
            self.large = large
            self.extraLarge = extraLarge
            self.padding = padding
        }

        public subscript(spacing: Spacing) -> CGFloat {
            switch spacing {
            case .none:
                return 0
            case .small:
                return small
            case .medium:
                return medium
            case .large:
                return large
            case .extraLarge:
                return extraLarge
            case .padding:
                return padding
            default:
                return `default`
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension SpacingConfiguration {
        static let `default` = SpacingConfiguration(
            default: 8,
            small: 4,
            medium: 16,
            large: 32,
            extraLarge: 48,
            padding: 16
        )
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension SpacingConfiguration: Decodable {
        private enum CodingKeys: String, CodingKey {
            case small, `default`, medium, large, extraLarge, padding
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            `default` = try container.decodeIfPresent(CGFloat.self, forKey: .default) ?? Self.default.default
            small = try container.decodeIfPresent(CGFloat.self, forKey: .small) ?? Self.default.small
            medium = try container.decodeIfPresent(CGFloat.self, forKey: .medium) ?? Self.default.medium
            large = try container.decodeIfPresent(CGFloat.self, forKey: .large) ?? Self.default.large
            extraLarge = try container.decodeIfPresent(CGFloat.self, forKey: .extraLarge) ?? Self.default.extraLarge
            padding = try container.decodeIfPresent(CGFloat.self, forKey: .padding) ?? Self.default.padding
        }
    }

#endif
