#if canImport(SwiftUI)

    import SwiftUI

    /// A set of values that control the size of images inside adaptive cards.
    ///
    /// To set the image size configuration for a view hierarchy, use the `imageSizeConfiguration(_:)`
    /// modifier and specify an instance of this type.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct ImageSizeConfiguration: Equatable {
        /// Small image size value.
        public let small: CGFloat

        /// Medium image size value.
        public let medium: CGFloat

        /// Large image size value.
        public let large: CGFloat

        public init(
            small: CGFloat,
            medium: CGFloat,
            large: CGFloat
        ) {
            self.small = small
            self.medium = medium
            self.large = large
        }

        public subscript(size: ImageSize) -> CGFloat? {
            switch size {
            case .small:
                return small
            case .medium:
                return medium
            case .large:
                return large
            default:
                return nil
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension ImageSizeConfiguration {
        static let `default` = ImageSizeConfiguration(
            small: 48,
            medium: 96,
            large: 192
        )
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension ImageSizeConfiguration: Decodable {
        private enum CodingKeys: String, CodingKey {
            case small, medium, large
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            small = try container.decodeIfPresent(CGFloat.self, forKey: .small) ?? Self.default.small
            medium = try container.decodeIfPresent(CGFloat.self, forKey: .medium) ?? Self.default.medium
            large = try container.decodeIfPresent(CGFloat.self, forKey: .large) ?? Self.default.large
        }
    }

#endif
