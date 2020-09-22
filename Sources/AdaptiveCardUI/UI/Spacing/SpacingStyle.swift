#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct SpacingStyle {
        public enum Defaults {
            public static let `default`: CGFloat = 8
            public static let small: CGFloat = 4
            public static let medium: CGFloat = 16
            public static let large: CGFloat = 32
            public static let extraLarge: CGFloat = 48
            public static let padding: CGFloat = 16
        }

        public let `default`: CGFloat
        public let small: CGFloat
        public let medium: CGFloat
        public let large: CGFloat
        public let extraLarge: CGFloat
        public let padding: CGFloat

        public init(
            default: CGFloat = Defaults.default,
            small: CGFloat = Defaults.small,
            medium: CGFloat = Defaults.medium,
            large: CGFloat = Defaults.large,
            extraLarge: CGFloat = Defaults.extraLarge,
            padding: CGFloat = Defaults.padding
        ) {
            self.default = `default`
            self.small = small
            self.medium = medium
            self.large = large
            self.extraLarge = extraLarge
            self.padding = padding
        }

        public init(hostConfig: HostConfig) {
            self.init(
                default: CGFloat(hostConfig.spacing.default),
                small: CGFloat(hostConfig.spacing.small),
                medium: CGFloat(hostConfig.spacing.medium),
                large: CGFloat(hostConfig.spacing.large),
                extraLarge: CGFloat(hostConfig.spacing.extraLarge),
                padding: CGFloat(hostConfig.spacing.padding)
            )
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

#endif
