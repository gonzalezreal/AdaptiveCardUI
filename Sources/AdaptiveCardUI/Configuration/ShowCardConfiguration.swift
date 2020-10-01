#if canImport(SwiftUI)

    import SwiftUI

    /// Controls behavior and styling of `showCard` actions.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct ShowCardConfiguration: Equatable {
        /// Indicates the initial container style for the card.
        public let style: ContainerStyle

        /// Amount of margin to use when displaying the card.
        public let inlineTopMargin: CGFloat

        public init(style: ContainerStyle, inlineTopMargin: CGFloat) {
            self.style = style
            self.inlineTopMargin = inlineTopMargin
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension ShowCardConfiguration {
        static let `default` = ShowCardConfiguration(
            style: .emphasis,
            inlineTopMargin: 8
        )
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension ShowCardConfiguration: Decodable {
        private enum CodingKeys: String, CodingKey {
            case style, inlineTopMargin
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            style = try container.decodeIfPresent(ContainerStyle.self, forKey: .style) ?? Self.default.style
            inlineTopMargin = try container.decodeIfPresent(CGFloat.self, forKey: .inlineTopMargin) ?? Self.default.inlineTopMargin
        }
    }

#endif
