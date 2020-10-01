#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct ContainerConfiguration: Equatable {
        /// The background color to use for this container.
        public let backgroundColor: Color

        /// The text colors to use for this container.
        public let textColors: TextColorConfiguration

        public init(backgroundColor: Color, textColors: TextColorConfiguration) {
            self.backgroundColor = backgroundColor
            self.textColors = textColors
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension ContainerConfiguration {
        static let `default` = ContainerConfiguration(
            backgroundColor: .defaultBackground,
            textColors: .default
        )

        static let emphasis = ContainerConfiguration(
            backgroundColor: .emphasisBackground,
            textColors: .default
        )

        static let accent = ContainerConfiguration(
            backgroundColor: .accentColor,
            textColors: .default
        )
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension ContainerConfiguration: Decodable {
        private enum CodingKeys: String, CodingKey {
            case backgroundColor, foregroundColors
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            backgroundColor = (try Color(argbHex: container.decodeIfPresent(String.self, forKey: .backgroundColor))) ?? .defaultBackground
            textColors = try container.decodeIfPresent(TextColorConfiguration.self, forKey: .foregroundColors) ?? .default
        }
    }

#endif
