import DefaultCodable
import Foundation

/// Displays text, allowing control over font sizes, weight, and color.
public struct TextBlock: CardElementProtocol, Codable, Equatable {
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

    /// Text to display
    public var text: String

    /// Controls the color of `TextBlock` elements.
    @Default<FirstCase> public var color: TextColor

    /// Type of font to use for rendering.
    @Default<FirstCase> public var fontType: FontType

    /// Controls the horizontal text alignment.
    @Default<FirstCase> public var horizontalAlignment: HorizontalAlignment

    /// If `true`, displays text slightly toned down to appear less prominent.
    @Default<False> public var isSubtle: Bool

    /// Specifies the maximum number of lines to display. If `nil`, no line limit applies.
    public var maxLines: Int?

    /// Controls size of text.
    @Default<FirstCase> public var size: FontSize

    /// Controls the weight of `TextBlock` elements.
    @Default<FirstCase> public var weight: FontWeight

    /// If `true`, allow text to wrap. Otherwise, text is clipped.
    @Default<False> public var wrap: Bool

    public init(
        id: String = "",
        isVisible: Bool = true,
        separator: Bool = false,
        spacing: Spacing = .default,
        fallback: Fallback<CardElement> = .none,
        requires: [String: SemanticVersion] = [:],
        text: String,
        color: TextColor = .default,
        fontType: FontType = .default,
        horizontalAlignment: HorizontalAlignment = .left,
        isSubtle: Bool = false,
        maxLines: Int? = nil,
        size: FontSize = .default,
        weight: FontWeight = .default,
        wrap: Bool = false
    ) {
        self.id = id
        self.isVisible = isVisible
        self.separator = separator
        self.spacing = spacing
        self.fallback = fallback
        self.requires = requires
        self.text = text
        self.color = color
        self.fontType = fontType
        self.horizontalAlignment = horizontalAlignment
        self.isSubtle = isSubtle
        self.maxLines = maxLines
        self.size = size
        self.weight = weight
        self.wrap = wrap
    }
}
