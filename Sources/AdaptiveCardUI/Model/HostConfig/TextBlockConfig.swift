import DefaultCodable
import Foundation

public struct TextBlockConfig: Codable, Equatable {
    /// The size of the text.
    @Default<FirstCase> public var size: FontSize

    /// The weight of the text.
    @Default<FirstCase> public var weight: FontWeight

    /// The color of the text.
    @Default<FirstCase> public var color: TextColor

    /// Should it be subtle?.
    @Default<False> public var isSubtle: Bool

    /// Is it allowed for the text to wrap.
    @Default<True> public var wrap: Bool

    /// The maximum width for text.
    public var maxWidth: Int?

    public init(
        size: FontSize = .default,
        weight: FontWeight = .default,
        color: TextColor = .default,
        isSubtle: Bool = false,
        wrap: Bool = true,
        maxWidth: Int? = nil
    ) {
        self.size = size
        self.weight = weight
        self.color = color
        self.isSubtle = isSubtle
        self.wrap = wrap
        self.maxWidth = maxWidth
    }
}
