#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    /// A set of values that control the appearance of fact sets inside adaptive cards.
    ///
    /// To set the fact set configuration for a view hierarchy, use the `factSetConfiguration(_:)`
    /// modifier and specify an instance of this type.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct FactSetConfiguration: Equatable {
        /// Text configuration to use for titles in fact sets.
        public let title: TextBlockConfiguration

        /// Text configuration to use for values in fact sets.
        public let value: TextBlockConfiguration

        /// Spacing between titles and values.
        public var spacing: CGFloat

        public init(
            title: TextBlockConfiguration,
            value: TextBlockConfiguration,
            spacing: CGFloat
        ) {
            self.title = title
            self.value = value
            self.spacing = spacing
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension FactSetConfiguration {
        static let `default` = FactSetConfiguration(
            title: TextBlockConfiguration(weight: .bold, maxWidth: 132),
            value: .default,
            spacing: 8
        )
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension FactSetConfiguration: Decodable {
        private enum CodingKeys: String, CodingKey {
            case title, value, spacing
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            title = try container.decodeIfPresent(TextBlockConfiguration.self, forKey: .title) ?? Self.default.title
            value = try container.decodeIfPresent(TextBlockConfiguration.self, forKey: .value) ?? Self.default.value
            spacing = try container.decodeIfPresent(CGFloat.self, forKey: .spacing) ?? Self.default.spacing
        }
    }

#endif
