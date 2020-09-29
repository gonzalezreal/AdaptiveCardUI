import DefaultCodable
import Foundation

/// A set of configuration values that specify how an Adaptive Card Renderer generates the UI.
public struct HostConfig: Codable, Equatable {
    /// Options for action elements.
    @Default<ActionsConfig> public var actions: ActionsConfig

    /// Color palettes for the different container styles.
    @Default<ContainerStylesConfig> public var containerStyles: ContainerStylesConfig

    /// Values for the different image sizes.
    @Default<ImageSizesConfig> public var imageSizes: ImageSizesConfig

    /// Controls the display of `FactSet` elements.
    @Default<FactSetConfig> public var factSet: FactSetConfig

    /// The font family and sizes for the different font types.
    @Default<FontTypesConfig> public var fontTypes: FontTypesConfig

    /// Specifies how much spacing should be used for the various spacing options.
    @Default<SpacingConfig> public var spacing: SpacingConfig

    /// Controls how separators are displayed.
    @Default<SeparatorConfig> public var separator: SeparatorConfig

    /// Determines whether or not to render inputs and actions.
    @Default<True> public var supportsInteractivity: Bool

    public init(
        actions: ActionsConfig = .default,
        containerStyles: ContainerStylesConfig = .default,
        imageSizes: ImageSizesConfig = .default,
        factSet: FactSetConfig = .default,
        fontTypes: FontTypesConfig = .default,
        spacing: SpacingConfig = .default,
        separator: SeparatorConfig = .default,
        supportsInteractivity: Bool = true
    ) {
        self.actions = actions
        self.containerStyles = containerStyles
        self.imageSizes = imageSizes
        self.factSet = factSet
        self.fontTypes = fontTypes
        self.spacing = spacing
        self.separator = separator
        self.supportsInteractivity = supportsInteractivity
    }
}
