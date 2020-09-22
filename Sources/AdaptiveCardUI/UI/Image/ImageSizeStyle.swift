#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct ImageSizeStyle {
        public enum Defaults {
            public static let small: CGFloat = 48
            public static let medium: CGFloat = 96
            public static let large: CGFloat = 192
        }

        public let small: CGFloat
        public let medium: CGFloat
        public let large: CGFloat

        public init(
            small: CGFloat = Defaults.small,
            medium: CGFloat = Defaults.medium,
            large: CGFloat = Defaults.large
        ) {
            self.small = small
            self.medium = medium
            self.large = large
        }

        public init(hostConfig: HostConfig) {
            self.init(
                small: CGFloat(hostConfig.imageSizes.small),
                medium: CGFloat(hostConfig.imageSizes.medium),
                large: CGFloat(hostConfig.imageSizes.large)
            )
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

#endif
