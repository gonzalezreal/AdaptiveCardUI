import DefaultCodable
import Foundation

/// Containers group items together.
public struct Container: CardElementProtocol, Codable, Equatable {
    /// A unique identifier associated with the item.
    @ItemIdentifier public var id: String

    /// If `false`, this item will be removed from the visual tree.
    @Default<True> public var isVisible: Bool

    /// When `true`, draw a separating line at the top of the element.
    @Default<False> public var separator: Bool

    /// Controls the amount of spacing between this element and the preceding element.
    @Default<FirstCase> public var spacing: Spacing

    /// Describes what to do when an unknown element is encountered or the requires of this or any children can’t be met.
    @Default<Fallback.None> public var fallback: Fallback<CardElement>

    /// A series of key/value pairs indicating features that the item requires with corresponding minimum version.
    /// When a feature is missing or of insufficient version, fallback is triggered.
    @Default<EmptyDictionary> public var requires: [String: SemanticVersion]

    /// The card elements to render inside the `Container`.
    @Default<Empty> public var items: [CardElement]

    /// An `Action` that will be invoked when the `Container` is tapped or selected.
    public var selectAction: Action?

    /// Style hint for `Container`.
    public var style: ContainerStyle?

    /// Defines how the content should be aligned vertically within the container.
    @Default<FirstCase> public var verticalContentAlignment: VerticalContentAlignment

    /// Determines whether the element should bleed through its parent's padding.
    @Default<False> public var bleed: Bool

    /// Specifies the background image.
    public var backgroundImage: BackgroundImage?

    /// Specifies the minimum height of the container in pixels.
    public var minHeight: PixelDimension?

    public init(
        id: String = "",
        isVisible: Bool = true,
        separator: Bool = false,
        spacing: Spacing = .default,
        fallback: Fallback<CardElement> = .none,
        requires: [String: SemanticVersion] = [:],
        items: [CardElement],
        selectAction: Action? = nil,
        style: ContainerStyle? = nil,
        verticalContentAlignment: VerticalContentAlignment = .top,
        bleed: Bool = false,
        backgroundImage: BackgroundImage? = nil,
        minHeight: PixelDimension? = nil
    ) {
        self.id = id
        self.isVisible = isVisible
        self.separator = separator
        self.spacing = spacing
        self.fallback = fallback
        self.requires = requires
        self.items = items
        self.selectAction = selectAction
        self.style = style
        self.verticalContentAlignment = verticalContentAlignment
        self.bleed = bleed
        self.backgroundImage = backgroundImage
        self.minHeight = minHeight
    }
}
