#if canImport(SwiftUI)

    import AdaptiveCard
    import SwiftUI

    /// A container style configuration specifies the configuration values for the different container styles.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct ContainerStyleConfiguration: Equatable {
        /// The configuration values for the `default` container style.
        public let `default`: ContainerConfiguration

        /// The configuration values for the `emphasis` container style.
        public let emphasis: ContainerConfiguration

        /// The configuration values for the `good` container style.
        public let good: ContainerConfiguration

        /// The configuration values for the `warning` container style.
        public let warning: ContainerConfiguration

        /// The configuration values for the `attention` container style.
        public let attention: ContainerConfiguration

        /// The configuration values for the `accent` container style.
        public let accent: ContainerConfiguration

        public init(
            default: ContainerConfiguration = .default,
            emphasis: ContainerConfiguration = .emphasis,
            good: ContainerConfiguration = .default,
            warning: ContainerConfiguration = .default,
            attention: ContainerConfiguration = .default,
            accent: ContainerConfiguration = .accent
        ) {
            self.default = `default`
            self.emphasis = emphasis
            self.good = good
            self.warning = warning
            self.attention = attention
            self.accent = accent
        }

        public subscript(containerStyle: ContainerStyle) -> ContainerConfiguration {
            switch containerStyle {
            case .default: return `default`
            case .emphasis: return emphasis
            case .good: return good
            case .attention: return attention
            case .warning: return warning
            case .accent: return accent
            default: return `default`
            }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension ContainerStyleConfiguration {
        static let `default` = ContainerStyleConfiguration()
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension ContainerStyleConfiguration: Decodable {
        private enum CodingKeys: String, CodingKey {
            case `default`, emphasis, good, warning, attention, accent
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            `default` = try container.decodeIfPresent(ContainerConfiguration.self, forKey: .default) ?? .default
            emphasis = try container.decodeIfPresent(ContainerConfiguration.self, forKey: .emphasis) ?? .emphasis
            good = try container.decodeIfPresent(ContainerConfiguration.self, forKey: .good) ?? .default
            warning = try container.decodeIfPresent(ContainerConfiguration.self, forKey: .warning) ?? .default
            attention = try container.decodeIfPresent(ContainerConfiguration.self, forKey: .attention) ?? .default
            accent = try container.decodeIfPresent(ContainerConfiguration.self, forKey: .accent) ?? .accent
        }
    }

#endif
