import DefaultCodable
import Foundation

/// Displays an image.
public struct Image: CardElementProtocol, Codable, Equatable {
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

    /// The URL to the image.
    public var url: URL

    /// Alternate text describing the image.
    public var altText: String?

    /// Applies a background to a transparent image. This property will respect the image style.
    public var backgroundColor: String?

    /// The desired height of the image. This overrides the `size` property.
    @Default<BlockElementHeight> public var height: BlockElementHeight

    /// Controls how this element is horizontally positioned within its parent.
    @Default<FirstCase> public var horizontalAlignment: HAlignment

    /// An Action that will be invoked when the `Image` is tapped or selected.
    public var selectAction: Action?

    /// Controls the approximate size of the image.
    @Default<FirstCase> public var size: ImageSize

    /// Controls how this `Image` is displayed.
    @Default<FirstCase> public var style: ImageStyle

    /// The desired on-screen width of the image. This overrides the `size` property.
    public var width: PixelDimension?

    public init(
        id: String = "",
        isVisible: Bool = true,
        separator: Bool = false,
        spacing: Spacing = .default,
        fallback: Fallback<CardElement> = .none,
        requires: [String: SemanticVersion] = [:],
        url: URL,
        altText: String? = nil,
        backgroundColor: String? = nil,
        height: BlockElementHeight = .default,
        horizontalAlignment: HAlignment = .left,
        selectAction: Action? = nil,
        size: ImageSize = .auto,
        style: ImageStyle = .default,
        width: PixelDimension? = nil
    ) {
        self.id = id
        self.isVisible = isVisible
        self.separator = separator
        self.spacing = spacing
        self.fallback = fallback
        self.requires = requires
        self.url = url
        self.altText = altText
        self.backgroundColor = backgroundColor
        self.height = height
        self.horizontalAlignment = horizontalAlignment
        self.selectAction = selectAction
        self.size = size
        self.style = style
        self.width = width
    }
}
