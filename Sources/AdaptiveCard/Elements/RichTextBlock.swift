import DefaultCodable
import Foundation

/// Defines an array of inlines, allowing for inline text formatting.
public struct RichTextBlock: CardElementProtocol, Codable, Equatable {
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

    /// The array of inlines.
    public var inlines: [TextRun]

    /// Controls the horizontal text alignment.
    @Default<FirstCase> public var horizontalAlignment: HAlignment

    public init(
        id: String = "",
        isVisible: Bool = true,
        separator: Bool = false,
        spacing: Spacing = .default,
        fallback: Fallback<CardElement> = .none,
        requires: [String: SemanticVersion] = [:],
        inlines: [TextRun],
        horizontalAlignment: HAlignment = .left
    ) {
        self.id = id
        self.isVisible = isVisible
        self.separator = separator
        self.spacing = spacing
        self.fallback = fallback
        self.requires = requires
        self.inlines = inlines
        self.horizontalAlignment = horizontalAlignment
    }
}
