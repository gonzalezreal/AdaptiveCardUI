import DefaultCodable
import Foundation

/// `ColumnSet` divides a region into `Columns`, allowing elements to sit side-by-side.
public struct ColumnSet: CardElementProtocol, Codable, Equatable {
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

    /// The array of `Columns` to divide the region into.
    @Default<Empty> public var columns: [ColumnSetElement]

    /// An `Action` that will be invoked when the `ColumnSet` is tapped or selected.
    public var selectAction: Action?

    /// Style hint for `ColumnSet`.
    public var style: ContainerStyle?

    /// Determines whether the element should bleed through its parent's padding.
    @Default<False> public var bleed: Bool

    /// Specifies the minimum height of the column set in pixels.
    public var minHeight: PixelDimension?

    public init(
        id: String = "",
        isVisible: Bool = true,
        separator: Bool = false,
        spacing: Spacing = .default,
        fallback: Fallback<CardElement> = .none,
        requires: [String: SemanticVersion] = [:],
        columns: [Column],
        selectAction: Action? = nil,
        style: ContainerStyle? = nil,
        bleed: Bool = false,
        minHeight: PixelDimension? = nil
    ) {
        self.id = id
        self.isVisible = isVisible
        self.separator = separator
        self.spacing = spacing
        self.fallback = fallback
        self.requires = requires
        self.columns = columns.map { .column($0) }
        self.selectAction = selectAction
        self.style = style
        self.bleed = bleed
        self.minHeight = minHeight
    }
}
