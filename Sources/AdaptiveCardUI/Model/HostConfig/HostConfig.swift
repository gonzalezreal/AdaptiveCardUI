import DefaultCodable
import Foundation

public struct HostConfig: Codable, Equatable {
    @Default<ActionsConfig> public var actions: ActionsConfig

    @Default<ContainerStylesConfig> public var containerStyles: ContainerStylesConfig

    @Default<ImageSizesConfig> public var imageSizes: ImageSizesConfig

    @Default<FactSetConfig> public var factSet: FactSetConfig

    @Default<FontTypesConfig> public var fontTypes: FontTypesConfig

    @Default<SpacingConfig> public var spacing: SpacingConfig

    @Default<SeparatorConfig> public var separator: SeparatorConfig

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
