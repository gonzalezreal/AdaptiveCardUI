import DefaultCodable
import Foundation

/// Defines a single run of formatted text.
public struct TextRun: Codable, Equatable {
    /// Text to display
    public var text: String

    /// Controls the color of the text.
    public var color: TextColor

    /// Type of font to use for rendering.
    public var fontType: FontType

    /// If `true`, displays the text highlighted.
    public var highlight: Bool

    /// If `true`, displays text slightly toned down to appear less prominent.
    public var isSubtle: Bool

    /// If `true`, displays the text using italic font.
    public var italic: Bool

    /// Action to invoke when this text run is clicked. Visually changes the text run into a hyperlink.
    public var selectAction: Action?

    /// Controls size of text.
    public var size: FontSize

    /// If `true`, displays the text with strikethrough.
    public var strikethrough: Bool

    /// Controls the weight of the text.
    public var weight: FontWeight

    public init(
        text: String,
        color: TextColor = .default,
        fontType: FontType = .default,
        highlight: Bool = false,
        isSubtle: Bool = false,
        italic: Bool = false,
        selectAction: Action? = nil,
        size: FontSize = .default,
        strikethrough: Bool = false,
        weight: FontWeight = .default
    ) {
        self.text = text
        self.color = color
        self.fontType = fontType
        self.highlight = highlight
        self.isSubtle = isSubtle
        self.italic = italic
        self.selectAction = selectAction
        self.size = size
        self.strikethrough = strikethrough
        self.weight = weight
    }

    public init(from decoder: Decoder) throws {
        let singleValueContainer = try decoder.singleValueContainer()

        if let text = try? singleValueContainer.decode(String.self) {
            self.init(text: text)
        } else {
            try self.init(PrimitiveTextRun(from: decoder))
        }
    }

    public func encode(to encoder: Encoder) throws {
        try PrimitiveTextRun(self).encode(to: encoder)
    }

    private init(_ primitiveValue: PrimitiveTextRun) {
        text = primitiveValue.text
        color = primitiveValue.color
        fontType = primitiveValue.fontType
        highlight = primitiveValue.highlight
        isSubtle = primitiveValue.isSubtle
        italic = primitiveValue.italic
        selectAction = primitiveValue.selectAction
        size = primitiveValue.size
        strikethrough = primitiveValue.strikethrough
        weight = primitiveValue.weight
    }
}

private struct PrimitiveTextRun: Codable {
    var type: String = "TextRun"
    var text: String
    @Default<FirstCase> var color: TextColor
    @Default<FirstCase> var fontType: FontType
    @Default<False> var highlight: Bool
    @Default<False> var isSubtle: Bool
    @Default<False> var italic: Bool
    var selectAction: Action?
    @Default<FirstCase> var size: FontSize
    @Default<False> var strikethrough: Bool
    @Default<FirstCase> var weight: FontWeight

    init(_ value: TextRun) {
        text = value.text
        color = value.color
        fontType = value.fontType
        highlight = value.highlight
        isSubtle = value.isSubtle
        italic = value.italic
        selectAction = value.selectAction
        size = value.size
        strikethrough = value.strikethrough
        weight = value.weight
    }
}
