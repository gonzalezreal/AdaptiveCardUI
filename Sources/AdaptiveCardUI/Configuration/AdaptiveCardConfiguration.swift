#if canImport(SwiftUI)

    import SwiftUI

    /// A set of configuration values that specify how an AdaptiveCardView generates its UI.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public struct AdaptiveCardConfiguration {
        /// Options for action set elements.
        public let actions: ActionSetConfiguration

        /// Configuration values for the different container styles.
        public let containerStyles: ContainerStyleConfiguration

        /// Values for the different image sizes.
        public let imageSizes: ImageSizeConfiguration

        /// Configuration values for fact set elements.
        public let factSet: FactSetConfiguration

        /// The different fonts for each font type.
        public let fonts: FontTypeConfiguration

        /// Specifies how much spacing should be used for the various spacing options.
        public let spacing: SpacingConfiguration

        public init(
            actions: ActionSetConfiguration,
            containerStyles: ContainerStyleConfiguration,
            imageSizes: ImageSizeConfiguration,
            factSet: FactSetConfiguration,
            fonts: FontTypeConfiguration,
            spacing: SpacingConfiguration
        ) {
            self.actions = actions
            self.containerStyles = containerStyles
            self.imageSizes = imageSizes
            self.factSet = factSet
            self.fonts = fonts
            self.spacing = spacing
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    extension AdaptiveCardConfiguration: Decodable {
        private enum CodingKeys: String, CodingKey {
            case actions, containerStyles, imageSizes, factSet, fontTypes, spacing
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            actions = try container.decodeIfPresent(ActionSetConfiguration.self, forKey: .actions) ?? .default
            containerStyles = try container.decodeIfPresent(ContainerStyleConfiguration.self, forKey: .containerStyles) ?? .default
            imageSizes = try container.decodeIfPresent(ImageSizeConfiguration.self, forKey: .imageSizes) ?? .default
            factSet = try container.decodeIfPresent(FactSetConfiguration.self, forKey: .factSet) ?? .default
            fonts = try container.decodeIfPresent(FontTypeConfiguration.self, forKey: .fontTypes) ?? .default
            spacing = try container.decodeIfPresent(SpacingConfiguration.self, forKey: .spacing) ?? .default
        }
    }

#endif
