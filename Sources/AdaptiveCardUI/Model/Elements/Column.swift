import DefaultCodable
import Foundation

/// A container that is part of a ColumnSet.
public struct Column: ColumnSetElementProtocol, Identifiable, Codable, Equatable {
    /// A unique identifier associated with the item.
    @ItemIdentifier public var id: String

    /// If `false`, this item will be removed from the visual tree.
    @Default<True> public var isVisible: Bool

    /// When `true`, draw a separating line at the top of the element.
    @Default<False> public var separator: Bool

    /// Controls the amount of spacing between this column and the preceding column.
    @Default<FirstCase> public var spacing: Spacing

    /// Describes what to do when an unknown element is encountered or the requires of this or any children can’t be met.
    @Default<Fallback.None> public var fallback: Fallback<ColumnSetElement>

    /// A series of key/value pairs indicating features that the item requires with corresponding minimum version.
    /// When a feature is missing or of insufficient version, fallback is triggered.
    @Default<EmptyDictionary> public var requires: [String: SemanticVersion]

    /// The card elements to render inside the `Column`.
    @Default<Empty> public var items: [CardElement]

    /// An Action that will be invoked when the `Column` is tapped or selected.
    public var selectAction: Action?

    /// Style hint for `Column`.
    public var style: ContainerStyle?

    /// Defines how the content should be aligned vertically within the column.
    @Default<FirstCase> public var verticalContentAlignment: VerticalContentAlignment

    /// Determines whether the element should bleed through its parent's padding.
    @Default<False> public var bleed: Bool

    /// The image to use as the background image.
    public var backgroundImage: BackgroundImage?

    /// Specifies the minimum height of the column in pixels.
    public var minHeight: PixelDimension?

    /// Width of the column.
    @Default<ColumnWidth> public var width: ColumnWidth

    public init(
        id: String = "",
        isVisible: Bool = true,
        separator: Bool = false,
        spacing: Spacing = .default,
        fallback: Fallback<ColumnSetElement> = .none,
        requires: [String: SemanticVersion] = [:],
        items: [CardElement],
        selectAction: Action? = nil,
        style: ContainerStyle? = nil,
        verticalContentAlignment: VerticalContentAlignment = .top,
        bleed: Bool = false,
        backgroundImage: BackgroundImage? = nil,
        minHeight: PixelDimension? = nil,
        width: ColumnWidth = .default
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
        self.width = width
    }
}
