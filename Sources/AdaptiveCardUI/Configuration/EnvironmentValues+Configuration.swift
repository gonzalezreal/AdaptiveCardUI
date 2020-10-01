#if canImport(SwiftUI)

    import SwiftUI

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public extension EnvironmentValues {
        /// The action set configuration of this environment.
        var actionSetConfiguration: ActionSetConfiguration {
            get { self[ActionSetConfigurationKey.self] }
            set { self[ActionSetConfigurationKey.self] = newValue }
        }

        /// The container style configuration of this environment.
        var containerStyleConfiguration: ContainerStyleConfiguration {
            get { self[ContainerStyleConfigurationKey.self] }
            set { self[ContainerStyleConfigurationKey.self] = newValue }
        }

        /// The image size configuration of this environment.
        var imageSizeConfiguration: ImageSizeConfiguration {
            get { self[ImageSizeConfigurationKey.self] }
            set { self[ImageSizeConfigurationKey.self] = newValue }
        }

        /// The fact set configuration of this environment.
        var factSetConfiguration: FactSetConfiguration {
            get { self[FactSetConfigurationKey.self] }
            set { self[FactSetConfigurationKey.self] = newValue }
        }

        /// The font type configuration of this environment.
        var fontTypeConfiguration: FontTypeConfiguration {
            get { self[FontTypeConfigurationKey.self] }
            set { self[FontTypeConfigurationKey.self] = newValue }
        }

        /// The spacing configuration of this environment.
        var spacingConfiguration: SpacingConfiguration {
            get { self[SpacingConfigurationKey.self] }
            set { self[SpacingConfigurationKey.self] = newValue }
        }
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct ActionSetConfigurationKey: EnvironmentKey {
        static let defaultValue = ActionSetConfiguration.default
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct ContainerStyleConfigurationKey: EnvironmentKey {
        static let defaultValue = ContainerStyleConfiguration.default
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct ImageSizeConfigurationKey: EnvironmentKey {
        static let defaultValue = ImageSizeConfiguration.default
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct FontTypeConfigurationKey: EnvironmentKey {
        static let defaultValue = FontTypeConfiguration.default
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct FactSetConfigurationKey: EnvironmentKey {
        static let defaultValue = FactSetConfiguration.default
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    private struct SpacingConfigurationKey: EnvironmentKey {
        static let defaultValue: SpacingConfiguration = .default
    }

#endif
