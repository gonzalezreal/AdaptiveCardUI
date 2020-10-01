#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct TextBlockConfiguration: Equatable {
        /// The size of the text.
        public let size: FontSize

        /// The weight of the text.
        public let weight: FontWeight

        /// The color of the text.
        public let color: TextColor

        /// Should it be subtle?.
        public let isSubtle: Bool

        /// Is it allowed for the text to wrap.
        public let wrap: Bool

        /// The maximum width for text.
        public let maxWidth: CGFloat?

        public init(
            size: FontSize = .default,
            weight: FontWeight = .default,
            color: TextColor = .default,
            isSubtle: Bool = false,
            wrap: Bool = true,
            maxWidth: CGFloat? = nil
        ) {
            self.size = size
            self.weight = weight
            self.color = color
            self.isSubtle = isSubtle
            self.wrap = wrap
            self.maxWidth = maxWidth
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension TextBlockConfiguration {
        static let `default` = TextBlockConfiguration()
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension TextBlockConfiguration: Decodable {
        private enum CodingKeys: String, CodingKey {
            case size, weight, color, isSubtle, wrap, maxWidth
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            size = try container.decodeIfPresent(FontSize.self, forKey: .size) ?? Self.default.size
            weight = try container.decodeIfPresent(FontWeight.self, forKey: .weight) ?? Self.default.weight
            color = try container.decodeIfPresent(TextColor.self, forKey: .color) ?? Self.default.color
            isSubtle = try container.decodeIfPresent(Bool.self, forKey: .isSubtle) ?? Self.default.isSubtle
            wrap = try container.decodeIfPresent(Bool.self, forKey: .wrap) ?? Self.default.wrap
            maxWidth = try container.decodeIfPresent(CGFloat.self, forKey: .maxWidth)
        }
    }

#endif
