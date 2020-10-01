#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension View {
        /// Sets the configuration for adaptive cards within this view.
        func adaptiveCardConfiguration(_ adaptiveCardConfiguration: AdaptiveCardConfiguration) -> some View {
            actionSetConfiguration(adaptiveCardConfiguration.actions)
                .containerStyleConfiguration(adaptiveCardConfiguration.containerStyles)
                .imageSizeConfiguration(adaptiveCardConfiguration.imageSizes)
                .factSetConfiguration(adaptiveCardConfiguration.factSet)
                .fontTypeConfiguration(adaptiveCardConfiguration.fonts)
                .spacingConfiguration(adaptiveCardConfiguration.spacing)
        }

        /// Sets the action set configuration for adaptive cards within this view.
        func actionSetConfiguration(_ actionSetConfiguration: ActionSetConfiguration) -> some View {
            environment(\.actionSetConfiguration, actionSetConfiguration)
        }

        /// Sets the container style configuration for adaptive cards within this view.
        func containerStyleConfiguration(_ containerStyleConfiguration: ContainerStyleConfiguration) -> some View {
            environment(\.containerStyleConfiguration, containerStyleConfiguration)
        }

        /// Sets the image size configuration for adaptive cards within this view.
        func imageSizeConfiguration(_ imageSizeConfiguration: ImageSizeConfiguration) -> some View {
            environment(\.imageSizeConfiguration, imageSizeConfiguration)
        }

        /// Sets the fact set configuration for adaptive cards within this view.
        func factSetConfiguration(_ factSetConfiguration: FactSetConfiguration) -> some View {
            environment(\.factSetConfiguration, factSetConfiguration)
        }

        /// Sets the font type configuration for adaptive cards within this view.
        func fontTypeConfiguration(_ fontTypeConfiguration: FontTypeConfiguration) -> some View {
            environment(\.fontTypeConfiguration, fontTypeConfiguration)
        }

        /// Sets the spacing configuration for adaptive cards within this view.
        func spacingConfiguration(_ spacingConfiguration: SpacingConfiguration) -> some View {
            environment(\.spacingConfiguration, spacingConfiguration)
        }
    }

#endif
