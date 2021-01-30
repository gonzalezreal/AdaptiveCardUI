#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    /// A font type configuration specifies the different fonts for each font type.
    ///
    /// To set the font type configuration for a view hierarchy, use the `fontTypeConfiguration(_:)`
    /// modifier and specify an instance of this type.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct FontTypeConfiguration: Equatable {
        /// The font configuration for the default font type.
        public let `default`: FontConfiguration

        /// The font configuration for the monospace font type.
        public let monospace: FontConfiguration

        public init(default: FontConfiguration, monospace: FontConfiguration) {
            self.default = `default`
            self.monospace = monospace
        }

        public subscript(fontType: FontType) -> FontConfiguration {
            switch fontType {
            case .monospace:
                return monospace
            default:
                return `default`
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension FontTypeConfiguration {
        static let `default` = FontTypeConfiguration(
            default: .default,
            monospace: .monospace
        )
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension FontTypeConfiguration: Decodable {
        private enum CodingKeys: String, CodingKey {
            case `default`, monospace
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            `default` = try container.decodeIfPresent(FontConfiguration.self, forKey: .default) ?? .default
            monospace = try container.decodeIfPresent(FontConfiguration.self, forKey: .monospace) ?? .monospace
        }
    }

#endif
